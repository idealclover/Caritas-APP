AZURE_KEY = "f3ec6ae68b2040e091073268e40a14a4"
AZURE_REGION = "eastasia"
SOURCE_DIR = r"/Users/idealclover/GitHub/Sth-Matters/"
PATHS = [r"Anonymity/"]
IGNORE_FILES = [".DS_Store", "README.md", ".md", "致读者 - 关于收费.JPEG"]
TARGET_DIR = r"/Users/idealclover/GitHub/Sth-Matters-Audio/"

import os
import re
import azure.cognitiveservices.speech as speechsdk
from azure.cognitiveservices.speech.audio import AudioOutputConfig
from bs4 import BeautifulSoup
from markdown import markdown

def md_to_text(md):
    html = markdown(md)
    soup = BeautifulSoup(html, features='html.parser')
    return soup.get_text()

def synthesize_to_speaker(path, tar_filename, content):
	#Find your key and resource region under the 'Keys and Endpoint' tab in your Speech resource in Azure Portal
	#Remember to delete the brackets <> when pasting your key and region!
    speech_config = speechsdk.SpeechConfig(subscription=AZURE_KEY, region=AZURE_REGION)
    #In this sample we are using the default speaker
    #Learn how to customize your speaker using SSML in Azure Cognitive Services Speech documentation
    # audio_config = AudioOutputConfig(use_default_speaker=True)
    speech_config.speech_synthesis_language = "zh-CN"
    speech_config.speech_synthesis_voice_name ="zh-CN-XiaoxuanNeural"
    print(TARGET_DIR + path + tar_filename)
    audio_config = AudioOutputConfig(filename=TARGET_DIR + path + tar_filename)
    synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config, audio_config=audio_config)
    synthesizer.speak_text_async(content)

def get_info(path, file_name):
    with open(os.path.join(SOURCE_DIR, path, file_name), "r", encoding="utf-8") as f:
        content = f.read()
    reg = r"> Author:(.*)\n*(?:(?:> )?Last update: \*(.*)\*)?\n*(?:(?:> Link:)(?:\[.*\]\(.*\))? *(\[\[.*\]\])? *)?\n*(?:(?:> Tag:) *(#.*)? *)?\n*(?:> 沙海拾金.*)?(?:\n)*"
    content = re.sub(reg, "", content)
    content = md_to_text(content)
    return content


fileList = os.listdir(SOURCE_DIR)
for file_name in fileList:
    if ".md" not in file_name or file_name in IGNORE_FILES:
        continue
    path = ""
    tar_filename = file_name.replace(".md", ".wav")
    if os.path.exists(TARGET_DIR + path + tar_filename):
        print(tar_filename + " exists, skip")
        continue
    content = get_info("", file_name)
    synthesize_to_speaker("", tar_filename, content)

for PATH in PATHS:
    p = os.walk(SOURCE_DIR + PATH)
    for path, dir_list, file_list in p:
        if("/Users/idealclover/GitHub/Sth-Matters/Anonymity/05 - 科学答集" in path):
            continue;
        for file_name in file_list:
            if ".md" not in file_name or file_name in IGNORE_FILES:
                continue
            tar_filename = file_name.replace(".md", ".wav")
            if os.path.exists(TARGET_DIR + path.replace(SOURCE_DIR, "").replace(PATH, "") + "/" + tar_filename):
                print(tar_filename + " exists, skip")
                continue
            content = get_info(path.replace(SOURCE_DIR, ""), file_name)
            synthesize_to_speaker(path.replace(SOURCE_DIR, "").replace(PATH, "") + "/", tar_filename, content)


