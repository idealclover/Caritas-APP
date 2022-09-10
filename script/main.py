import os
import re
import json
from datetime import datetime
from urllib.parse import unquote

VERSION = 14
TARGET = r"../res/data.json"

# 常量定义

JOHN_DIR = r"/Users/idealclover/GitHub/Sth-Matters/"
JOHN_AUDIO_DIR = r"/Users/idealclover/GitHub/Sth-Matters-Audio/"
JOHN_PATHS = [r"Anonymity/"]
NELL_DIR = r"/Users/idealclover/GitHub/Nell-Nell/"
NELL_AUDIO_DIR = r"/Users/idealclover/GitHub/Nell-Nell-Audio/"
NELL_PATHS = ["00 - 致读者", "01 - “是什么”系列", "02 - “怎么办”系列", "03 - “如何看待”系列", "04 - “好好活着”系列", "06 - 书评 & 影评", "09 - 简答"]

# TARGET = r"./data.json"
IGNORE_FILES = [".DS_Store", "README.md", ".md", "致读者 - 关于收费.JPEG"]
CONFIG_ORDER = [
    [
        "致用户 @idealclover",
        "致用户 @Dav",
        "致读者 @Anonymity",
        "致读者 @NellNell",
        "致读者 - II @Anonymity",
        "致读者 - III @Anonymity",
        "致读者 - IV @Anonymity",
        "致读者 - 留言 @Anonymity",
        "致读者 - 关于盈利 @Anonymity",
        "致你们 @Anonymity",
        "致读者 - 卖瓜 @Anonymity",
        "致读者 - 写作 @NellNell",
        "致读者 - 潜力 @NellNell",
        "致读者 - 十年 @NellNell"
    ]
]

categories = {
    "00 - 致读者": "致读者",
    "01 - 家族答集": "处世",
    "02 - 企管答集": "企管",
    "03 - 第一性": "性别",
    "04 - 社科答集": "社科",
    "05 - 科学答集": "科学",
    "06 - 未来科技": "科技",
    "07 - 军事技术与艺术": "军事",
    "08 - 文艺答集": "文艺",
    "09 - 神学答集": "神学",
    "10 - “就你机灵”系列": "抖机灵",
    "11 - 新冠": "新冠",
    "12 - 大过滤器": "大过滤器",
    "13 - 百年未有之变局": "时政",
    "01 - “是什么”系列": "是什么",
    "02 - “怎么办”系列": "怎么办",
    "03 - “如何看待”系列": "如何看",
    "04 - “好好活着”系列": "好好活",
    "06 - 书评 & 影评": "书评影评",
    "09 - 简答": "简答",
}

# static 变量定义

data = {
    "version": VERSION,
    "categories": [
        {"title": categories["00 - 致读者"]},
        {"title": "最近更新"},
        {"title": categories["01 - 家族答集"]},
        {"title": categories["02 - 企管答集"]},
        {"title": categories["04 - 社科答集"]},
        {"title": categories["05 - 科学答集"]},
        {"title": categories["06 - 未来科技"]},
        {"title": categories["07 - 军事技术与艺术"]},
        {"title": categories["13 - 百年未有之变局"]},
        {"title": categories["03 - 第一性"]},
        {"title": categories["08 - 文艺答集"]},
        {"title": categories["09 - 神学答集"]},
        {"title": categories["11 - 新冠"]},
        {"title": categories["10 - “就你机灵”系列"]},
        {"title": categories["12 - 大过滤器"]},
        {"title": categories["01 - “是什么”系列"]},
        {"title": categories["02 - “怎么办”系列"]},
        {"title": categories["03 - “如何看待”系列"]},
        {"title": categories["04 - “好好活着”系列"]},
        {"title": categories["06 - 书评 & 影评"]},
        {"title": categories["09 - 简答"]},
    ],
    "tags": [],
    "articles": [],
}

columns = ["title", "question", "zhihuLink", "author", "lastUpdate", "links", "tags"]
rst = {"total": 0, "match": 0}
for c in columns:
    rst[c] = 0


def getArticle(file_name, content, tag):
    article = {"id": ""}
    for c in columns:
        article[c] = ""

    # reg = r"^ *(?: *#(?: *)(.*))?\n* *(\*.*\*|\[.*\])?(\(http.*\))? *\n*(?: *> ?Author: *(.*) *)?\n*(?:(?:> )?Last update: \*(.*)\* *)?\n*(?:(?:> )?(?:Links:|Link:s|Link:) *(?:\[.*\]\(.*\))? *(\[\[.*\]\])? *)?\n*(?:(?:> )?(?:Tags:|Tag:) *(#.*)? *)?(?: |\n)*"
    reg = r"^(?:# (.*))?\n*(\*.*\*|\[.*\])?(\(http.*\))?\n*(?:> Author:(.*))?\n*(?:(?:> )?Last update: \*(.*)\*)?\n*(?:(?:> Link:)(?:\[.*\]\(.*\))? *(\[\[.*\]\])? *)?\n*(?:(?:> Tag:) *(#.*)? *)?(?:\n)*"
    m = re.match(reg, content)

    if m.group(0) is not None:
        rst["match"] += 1

    for i, c in enumerate(columns):
        if m.group(i + 1) is None:
            continue
        rst[c] += 1
        article[c] = m.group(i + 1)

    # id and title
    if article["title"] == "":
        print(file_name)
        article["title"] = file_name.replace(".md", "")
    article["id"] = article["title"]

    # question
    article["question"] = article["question"].replace("*", "").replace("[", "").replace("]", "")

    # zhihuLink
    article["zhihuLink"] = article["zhihuLink"].replace("(", "").replace(")", "")

    # lastUpdate
    if article["lastUpdate"] == "":
        # print(file_name)
        article["lastUpdate"] = "01/01/1970"

    # links
    # links = re.findall(r"\[\[(.*?)\]\]", article["links"])
    links = list(map(lambda x: re.sub(r"Anonymity\/.*?\/", "", x), re.findall(r"\[\[(.*?)\]\]", article["links"])))
    article["links"] = links
    # print(links)

    # tags
    tags = re.findall(r"#(.*?)(?= |\n|#)", article["tags"])
    # for t in tags:
    #     if {"title": t} not in data["tags"]:
    #         data["tags"].append({"title": t})
    tags.append(tag)
    article["tags"] = tags

    # content
    # article['content'] = content
    article["content"] = re.sub(reg, "", content)
    # remove 沙海拾金
    article["content"] = re.sub("> 沙海拾金.*\n*", "", article["content"])
    # remove zhihu auto link
    article["content"] = re.sub("\[(.*?)\]\(https://www\.zhihu\.com/search\?q=.*?\)", "\g<1>", article["content"])
    # remove zhihu redirect link
    article["content"] = re.sub(
        "\(https?://link\.zhihu\.com/\?target=http(s?)%3A//(.*?)\)",
        lambda x: "(http" + x.group(1) + "://" + unquote(x.group(2), encoding="utf-8") + ")",
        article["content"],
    ).strip()

    # if re.search("\n +", article["content"]) is not None:
    #     print(file_name)
    # if article["question"] == "":
    #     print(file_name)
    # if "Tags" in article["content"]:
    #     print(file_name)
    # if article["author"] == "":
    #     print(file_name)
    return article


def getArticleList(DIR, PATHS, AUDIO_DIR, REPLACE_PATH):

    fileList = os.listdir(DIR)
    for file_name in fileList:
        if ".md" not in file_name or file_name in IGNORE_FILES:
            continue

        rst["total"] += 1

        with open(os.path.join(DIR, file_name), "r", encoding="utf-8") as f:
            content = f.read()

        tag = "最近更新"
        article = getArticle(file_name, content, tag)

        # if os.path.exists((AUDIO_DIR + file_name).replace(".md", ".wav")):
        #     article["audio"] = True

        data["articles"].append(article)

    for PATH in PATHS:
        p = os.walk(DIR + PATH)
        for path, dir_list, file_list in p:
            for file_name in file_list:
                if file_name in IGNORE_FILES:
                    continue

                rst["total"] += 1
                article = {"id": ""}
                for c in columns:
                    article[c] = ""

                with open(os.path.join(path, file_name), "r", encoding="utf-8") as f:
                    content = f.read()

                # print(path)
                if REPLACE_PATH:
                    tag = categories.get(path.replace(DIR + PATH, "").replace("/自然科学", "").replace("/应用科学", ""), "")
                else:
                    tag = categories[path.replace(DIR, "")]
                article = getArticle(file_name, content, tag)

                data["articles"].append(article)

        # print(file_name)
        # print(os.path.join(path, file_name))


def main():

    getArticleList(JOHN_DIR, JOHN_PATHS, JOHN_AUDIO_DIR, True)
    getArticleList(NELL_DIR, NELL_PATHS, NELL_AUDIO_DIR, False)

    print(json.dumps(rst, indent=2))

    # sorted by update time
    data["articles"] = sorted(
        data["articles"], key=lambda k: datetime.strptime(k["lastUpdate"], "%d/%m/%Y").date(), reverse=True
    )

    for order in CONFIG_ORDER:
        for itemName in reversed(order):
            data["articles"].insert(
                0, data["articles"].pop([i for i, obj in enumerate(data["articles"]) if obj["id"] == itemName][0])
            )

    with open(TARGET, "w", encoding="utf-8") as f:
        # json.dump(data, f, ensure_ascii=False, indent=2)
        json.dump(data, f, ensure_ascii=False)


if __name__ == "__main__":
    main()
