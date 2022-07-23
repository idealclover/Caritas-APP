import os
import re
import json
from datetime import datetime

DIR = r"/Users/idealclover/GitHub/Sth-Matters/"
PATH = r"Anonymity/"
VERSION = 3
# TARGET = r"./data.json"
TARGET = r"../res/data.json"
IGNORE_FILES = [".DS_Store", "README.md", ".md"]
CONFIG_ORDER = [["致用户", "致读者 - I", "致读者 - II", "致读者 - III", "致读者 - IV", "致读者 - 留言", "致读者 - 鼓励利用我的内容盈利", "致你们"]]

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
}

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
    ],
    "articles": [],
}


def getArticle(content, tag):
    reg = r"^ *(?: *#(?: *)(.*))?\n* *(\*.*\*|\[.*\])?(\(http.*\))?\n*(?: *> Author: *(.*) *)?\n*(?:> Last update: \*(.*)\* *)?\n*(?:(?:> Links:|> Link:s) *(\[\[.*\]\])? *)?\n*(?:> Tags: *(#.*)? *)?(?: |\n)*"
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
        article["title"] = file_name.replace(".md", "")
    article["id"] = article["title"]

    # question
    article["question"] = article["question"].replace("*", "").replace("[", "").replace("]", "")

    # zhihuLink
    article["zhihuLink"] = article["zhihuLink"].replace("(", "").replace(")", "")

    # lastUpdate
    if article["lastUpdate"] == "":
        article["lastUpdate"] = "01/01/1970"

    # links
    links = re.findall(r"\[\[(.*?)\]\]", article["links"])
    # print(links)
    article["links"] = links

    # tags
    tags = re.findall(r"#(.*?)(?: |\n)", article["tags"])
    tags.append(tag)
    article["tags"] = tags

    # content
    # article['content'] = content
    article["content"] = re.sub(reg, "", content)
    # remove 沙海拾金
    article["content"] = re.sub("> 沙海拾金.*\n*", "", article["content"])
    # remove zhihu auto link
    article["content"] = re.sub("\[(.*)\]\(https://www\.zhihu\.com/search\?q=.*\)", "\g<1>", article["content"]).strip()
    return article


columns = ["title", "question", "zhihuLink", "author", "lastUpdate", "links", "tags"]
rst = {"total": 0, "match": 0}
for c in columns:
    rst[c] = 0

fileList = os.listdir(DIR)
for file_name in fileList:
    if ".md" not in file_name or file_name in IGNORE_FILES:
        continue

    rst["total"] += 1
    article = {"id": ""}
    for c in columns:
        article[c] = ""

    with open(os.path.join(DIR, file_name), "r", encoding="utf-8") as f:
        content = f.read()

    tag = "最近更新"
    article = getArticle(content, tag)

    data["articles"].append(article)

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

        tag = categories[path.replace(DIR + PATH, "").replace("/自然科学", "").replace("/应用科学", "")]
        article = getArticle(content, tag)

        data["articles"].append(article)

        # print(file_name)
        # print(os.path.join(path, file_name))
print(json.dumps(rst, indent=2))


# sorted by update time
data["articles"] = sorted(
    data["articles"], key=lambda k: datetime.strptime(k["lastUpdate"], "%d/%m/%Y").date(), reverse=True
)

for order in CONFIG_ORDER:
    for itemName in reversed(order):
        # print([i for i, obj in enumerate(data["articles"]) if obj['id']==itemName][0])
        data["articles"].insert(
            0, data["articles"].pop([i for i, obj in enumerate(data["articles"]) if obj["id"] == itemName][0])
        )


with open(TARGET, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
