# coding = utf-8
import os
import re
from pathlib import Path
from config import *


def lint_content(content):
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
    return content

def lint_recent(recent_path):
    fileList = os.listdir(recent_path)
    for file_name in fileList:
        if ".md" not in file_name or file_name in IGNORE_FILES:
            continue
        # print(file_name)
        # print(os.path.join(recent_path, file_name))
        with open(os.path.join(recent_path, file_name), "r", encoding="utf-8") as f:
            content = f.read()
        content = lint_content(content)
        # print(content)
        with open(os.path.join(recent_path, file_name), "w", encoding="utf-8") as f:
            f.write(content + "\n")

def lint_dir(path):
    for item in path.iterdir():
        if item.is_dir():
            # 如果是目录，递归处理
            lint_dir(item)
        elif item.suffix == '.md':
            # print(item.name)
            if item.name in IGNORE_FILES:
                continue
            with open(item, "r", encoding="utf-8") as f:
                content = f.read()
            content = lint_content(content)
            with open(item, "w", encoding="utf-8") as f:
                f.write(content + "\n")

def lint(config):
    lint_recent(config["SOURCE_DIR"] + "【本周更新】")

    for PATH in config["PATHS"]:
        p = Path(config["SOURCE_DIR"] + PATH)
        lint_dir(p)
