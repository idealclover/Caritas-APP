# coding = utf-8
import os
import re
from config import *


def lint(config):
    fileList = os.listdir(config["SOURCE_DIR"])
    # for file_name in fileList:
    #     if ".md" not in file_name or file_name in IGNORE_FILES:
    #         continue
    #     # print(file_name)
    #     with open(os.path.join(config["SOURCE_DIR"], file_name), "r", encoding="utf-8") as f:
    #         content = f.read()
    #     content = re.sub("(?: *)\n", "\n", content)
    #     content = re.sub("\n\n*\n", "\n\n", content)
    #     content = re.sub("\n\n$", "\n", content)
    #     content = re.sub("\*\*(.*)。\*\*", "**\g<1>**。", content)
    #     with open(os.path.join(config["SOURCE_DIR"], file_name), "w", encoding="utf-8") as f:
    #         f.write(content)

    for PATH in config["PATHS"]:
        p = os.walk(config["SOURCE_DIR"] + PATH)
        for path, dir_list, file_list in p:
            for file_name in file_list:
                if file_name in IGNORE_FILES:
                    continue
                with open(os.path.join(path, file_name), "r", encoding="utf-8") as f:
                    content = f.read()
                content = re.sub("\*(.*?)\*\((.*?)\)", "[\g<1>](\g<2>)", content)
                content = re.sub("(?: *)\n", "\n", content)
                content = re.sub("\n\n*\n", "\n\n", content)
                content = re.sub("(?:\n| )*$", "", content)
                content = re.sub("\n +", "\n", content)

                content = re.sub("[0-9]* 赞同 .* 评论回答", "", content)
                content = re.sub("[0-9]* 赞同 .*评论文章", "", content)
                content = re.sub("[0-9]* 赞同 .*评论回答\!\[\]\(.*?\)", "", content)
                content = re.sub("[0-9]*\.[0-9]* 万浏览 · [0-9]* 关注收藏夹\!\[\]\(.*?\)", "", content)
                content = re.sub("[0-9]*\.[0-9]* 万浏览 · [0-9]* 关注收藏夹\[\]\(.*?\)", "", content)
                content = re.sub("[0-9]*\.[0-9]* 万浏览 · [0-9]* 关注收藏夹", "", content)
                content = re.sub("[0-9]* 浏览 · [0-9]* 关注收藏夹", "", content)
                content = re.sub("([^\*]*)\*\*(.*)(，|。|！)\*\*([^\*\n]+)\n", "\g<1>**\g<2>**\g<3>\g<4>\n", content)
                # if re.search(r"[^\*]*\*\*.*(?:，|。|！)\*\*[^\*\n]+\n", content):
                # # if re.search(r"[0-9]*赞同 .*评论回答", content):
                #     print(file_name)
                #     # num += 1
                #     # content = re.sub("(?:\n| )*$", "\n", content)

                # content = re.sub("$", "\n$", content)
                with open(os.path.join(path, file_name), "w", encoding="utf-8") as f:
                    f.write(content + "\n")
