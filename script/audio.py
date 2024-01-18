import os, re, time, json
from config import *
from pathlib import Path

import azure.cognitiveservices.speech as speechsdk
from azure.cognitiveservices.speech.audio import AudioOutputConfig

from qcloud_cos import CosConfig
from qcloud_cos import CosS3Client

from tencentcloud.common import credential
from tencentcloud.common.profile.client_profile import ClientProfile
from tencentcloud.common.profile.http_profile import HttpProfile
from tencentcloud.common.exception.tencent_cloud_sdk_exception import TencentCloudSDKException
from tencentcloud.cdn.v20180606 import cdn_client, models

from bs4 import BeautifulSoup
from markdown import markdown


def md_to_text(md):
    html = markdown(md)
    soup = BeautifulSoup(html, features="html.parser")
    return soup.get_text()


def synthesize_to_speaker(config, path, tar_filename, content):
    # Find your key and resource region under the 'Keys and Endpoint' tab in your Speech resource in Azure Portal
    # Remember to delete the brackets <> when pasting your key and region!
    speech_config = speechsdk.SpeechConfig(subscription=AZURE_KEY, region=AZURE_REGION)
    # In this sample we are using the default speaker
    # Learn how to customize your speaker using SSML in Azure Cognitive Services Speech documentation
    # audio_config = AudioOutputConfig(use_default_speaker=True)
    speech_config.speech_synthesis_language = "zh-CN"
    speech_config.speech_synthesis_voice_name = "zh-CN-XiaoxuanNeural"
    print(config["AUDIO_TARGET_DIR"] + path + tar_filename)
    audio_config = AudioOutputConfig(
        filename=(config["AUDIO_TARGET_DIR"] + path + tar_filename).replace("/应用科学", "").replace("/自然科学", "")
    )
    synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config, audio_config=audio_config)
    speech_synthesis_result = synthesizer.speak_text_async(content).get()
    if speech_synthesis_result.reason == speechsdk.ResultReason.SynthesizingAudioCompleted:
        print("Speech synthesized for {}".format(tar_filename))
    elif speech_synthesis_result.reason == speechsdk.ResultReason.Canceled:
        cancellation_details = speech_synthesis_result.cancellation_details
        print("Speech synthesis canceled: {}".format(cancellation_details.reason))
        if cancellation_details.reason == speechsdk.CancellationReason.Error:
            if cancellation_details.error_details:
                print("Error details: {}".format(cancellation_details.error_details))
                print("Did you set the speech resource key and region values?")


def get_info(file):
    with open(file, "r", encoding="utf-8") as f:
        content = f.read()
    reg = reg_audio
    content = re.sub(reg, "", content)
    content = md_to_text(content)
    return content


def get_categories(item):
    categories = []
    if(CATEGORIES[item.parent.name]):
        categories = [item.parent.name]
    # print(item.parent.name)
    with open(item, "r") as file:
        for i, line in enumerate(file, 1):
            if i == 7:
                if line.startswith("> Category: "):
                    # 输出 'category' 后的内容
                    # 使用 len('category') 来跳过 'category'，使用 strip() 删除行末的换行符
                    rst = line[len("> Category: ") :].strip()
                    categories = re.findall(r"#(.*?)(?= |$)", rst)
                    categories = [CATEGORIES_REVERSE[CATEGORIES[i]] if i in CATEGORIES else i for i in categories]
                    # print(categories)
                break
    return categories


def get_audio_recent(config):
    fileList = os.listdir(config["SOURCE_DIR"] + "【本周更新】/")
    for file_name in fileList:
        if ".md" not in file_name or file_name in IGNORE_FILES:
            continue
        path = "【本周更新】/"
        tar_filename = file_name.replace(".md", ".wav")
        if os.path.exists(config["AUDIO_TARGET_DIR"] + path + tar_filename):
            print(tar_filename + " exists, skip")
            continue
        content = get_info(Path(config["SOURCE_DIR"] + path + file_name))
        synthesize_to_speaker(config, path, tar_filename, content)


def get_audio_dir(path, config):
    for item in path.iterdir():
        if item.is_dir():
            # print(item.name)
            if item.name in IGNORE_PATHS:
                continue
            # 如果是目录，递归处理
            get_audio_dir(item, config)
        elif item.suffix == ".md":
            if item.name in IGNORE_FILES:
                continue
            categories = get_categories(item)
            # print(categories)
            if not categories:
                continue
            tar_filename = config["AUDIO_TARGET_DIR"] + categories[0] + "/" + item.name.replace(".md", ".wav")
            if os.path.exists(tar_filename):
                # print(tar_filename + " exists, skip")
                continue
            # print(tar_filename)
            # # print(path.replace(config["SOURCE_DIR"], "") + tar_filename + " not exists")
            content = get_info(item)
            synthesize_to_speaker(
                config, categories[0] + '/', item.name.replace(".md", ".wav"), content
            )


def get_audio(config):
    get_audio_recent(config)

    for PATH in config["PATHS"]:
        p = Path(config["SOURCE_DIR"] + PATH)
        get_audio_dir(p, config)


def convert_to_mp3(config):
    p = os.walk(config["AUDIO_TARGET_DIR"])
    for path, dir_list, file_list in p:
        for file_name in file_list:
            if ".wav" not in file_name or file_name in IGNORE_FILES:
                continue
            target = (
                config["MP3_TARGET_DIR"]
                + path.replace(config["AUDIO_TARGET_DIR"], "").replace("/应用科学", "").replace("/自然科学", "")
                + "/"
                + file_name.replace(".wav", ".mp3")
            )
            for s, t in CATEGORIES.items():
                target = target.replace(s, t)
            if os.path.exists(target):
                # print(target + " exists, skip")
                continue
            # print(target)
            command = (
                'ffmpeg -i "' + path + "/" + file_name + '" -codec:v copy -codec:a libmp3lame -q:a 0 "' + target + '"'
            )
            # print(command)
            os.system(command)


def upload_to_cos(config):
    cos_config = CosConfig(Region=region, SecretId=secret_id, SecretKey=secret_key, Token=None, Scheme="https")
    client = CosS3Client(cos_config)

    p = os.walk(config["MP3_TARGET_DIR"])
    for path, dir_list, file_list in p:
        for file_name in file_list:
            if ".mp3" not in file_name or file_name in IGNORE_FILES:
                continue
            ntime = time.time()
            mtime = os.path.getmtime(path + "/" + file_name)
            rst = ntime - mtime
            if rst < 60 * 60 * 24:
                mp3_filename = path + "/" + file_name
                cos_filename = mp3_filename.replace(config["MP3_TARGET_DIR"], COS_TARGET_DIR)
                print(cos_filename)

                ### 文件流简单上传（不支持超过5G的文件，推荐使用下方高级上传接口）
                ### 强烈建议您以二进制模式(binary mode)打开文件,否则可能会导致错误
                with open(mp3_filename, "rb") as fp:
                    response = client.put_object(
                        Bucket=bucket, Body=fp, Key=cos_filename, StorageClass="STANDARD", EnableMD5=False
                    )
                print(response["ETag"])


def refresh_cdn():
    try:
        # 实例化一个认证对象，入参需要传入腾讯云账户secretId，secretKey,此处还需注意密钥对的保密
        # 密钥可前往https://console.cloud.tencent.com/cam/capi网站进行获取
        cred = credential.Credential(secret_id, secret_key)
        # 实例化一个http选项，可选的，没有特殊需求可以跳过
        httpProfile = HttpProfile()
        httpProfile.endpoint = "cdn.tencentcloudapi.com"

        # 实例化一个client选项，可选的，没有特殊需求可以跳过
        clientProfile = ClientProfile()
        clientProfile.httpProfile = httpProfile
        # 实例化要请求产品的client对象,clientProfile是可选的
        client = cdn_client.CdnClient(cred, "", clientProfile)

        # 实例化一个请求对象,每个接口都会对应一个request对象
        req = models.PurgePathCacheRequest()
        params = {"Paths": [COS_URL], "FlushType": "flush"}
        req.from_json_string(json.dumps(params))

        # 返回的resp是一个PurgePathCacheResponse的实例，与请求对象对应
        resp = client.PurgePathCache(req)
        # 输出json格式的字符串回包
        print(resp.to_json_string())

    except TencentCloudSDKException as err:
        print(err)
