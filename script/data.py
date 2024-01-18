import os
import re
import json
from config import *
from pathlib import Path
from datetime import datetime
from urllib.parse import unquote

data = {
    "version": DATABASE_VERSION,
    "categories": [
        {"title": CATEGORIES["00 - 致读者"]},
        {"title": CATEGORIES["【本周更新】"]},
        {"title": CATEGORIES["其它/万赞回答"]},
        {"title": CATEGORIES["01 - 家族答集"]},
        {"title": CATEGORIES["02 - 企管答集"]},
        {"title": CATEGORIES["04 - 社科答集"]},
        {"title": CATEGORIES["05 - 科学答集"]},
        {"title": CATEGORIES["06 - 未来科技"]},
        {"title": CATEGORIES["14 - 人与智能"]},
        {"title": CATEGORIES["07 - 军事技术与艺术"]},
        {"title": CATEGORIES["13 - 百年未有之变局"]},
        {"title": CATEGORIES["03 - 第一性"]},
        {"title": CATEGORIES["08 - 文艺答集"]},
        {"title": CATEGORIES["09 - 神学答集"]},
        {"title": CATEGORIES["11 - 新冠"]},
        {"title": CATEGORIES["10 - “就你机灵”系列"]},
        {"title": CATEGORIES["12 - 大过滤器"]},
        {"title": CATEGORIES["01 - “是什么”系列"]},
        {"title": CATEGORIES["02 - “怎么办”系列"]},
        {"title": CATEGORIES["03 - “如何看待”系列"]},
        {"title": CATEGORIES["04 - “好好活着”系列"]},
        {"title": CATEGORIES["06 - 书评 & 影评"]},
        {"title": CATEGORIES["09 - 简答"]},
    ],
    "tags": [],
    "articles": [],
}

columns = ["title", "question", "zhihuLink", "author", "lastUpdate", "links", "categories", "tags"]
rst = {"total": 0, "match": 0}
for c in columns:
    rst[c] = 0


def try_parsing_date(text):
    for fmt in ("%Y-%m-%d", "%d/%m/%Y", "%Y-%m-%d %H:%M"):
        try:
            return datetime.strptime(text, fmt)
        except ValueError:
            pass
    raise ValueError("No valid date format found: " + text)


def getArticle(file_name, content, tag):
    article = {"id": ""}
    for c in columns:
        article[c] = ""

    # print(reg)
    m = re.match(reg, content)

    if m == None:
        print("not found: " + file_name)
        print(reg)
        return

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

    # author
    article["author"] = AUTHORS[article["author"]]

    # lastUpdate
    if article["lastUpdate"] == "":
        # print(file_name)
        article["lastUpdate"] = "01/01/1970"
    article["lastUpdate"] = try_parsing_date(article["lastUpdate"]).strftime("%Y-%m-%d")

    # links
    # links = re.findall(r"\[\[(.*?)\]\]", article["links"])
    links = list(map(lambda x: re.sub(r"Anonymity\/.*?\/", "", x), re.findall(r"\[\[(.*?)\]\]", article["links"])))
    article["links"] = links
    # print(links)

    # tags
    # print(re.findall(r"#(.*?)(?= |$)", article["categories"]))
    categories = re.findall(r"#(.*?)(?= |$)", article["categories"])
    tags = re.findall(r"#(.*?)(?= |$)", article["tags"])
    if categories:
        tags = tags + categories
    for i, t in enumerate(tags):
        # print(t)
        if t == tag:
            tags.remove(t)
        if t in CATEGORIES.keys():
            tags[i] = CATEGORIES[t]
            # print(tags)

    if tag:
        tags.append(tag)
    # print(tags)
    article["tags"] = tags
    article.pop("categories")

    # content
    # article['content'] = content
    article["content"] = re.sub(reg, "", content)
    # # remove 沙海拾金
    # article["content"] = re.sub("> 沙海拾金.*\n*", "", article["content"])
    # # remove 评论区
    # article["content"] = re.sub("> 评论区.*\n*", "", article["content"])
    # # remove 泛讨论
    # article["content"] = re.sub("> 泛讨论.*\n*", "", article["content"])

    # remove zhihu auto link
    article["content"] = re.sub("\[(.*?)\]\(https://www\.zhihu\.com/search\?q=.*?\)", "\g<1>", article["content"])
    # remove zhihu redirect link
    article["content"] = re.sub(
        "\(https?://link\.zhihu\.com/\?target=http(s?)%3A//(.*?)\)",
        lambda x: "(http" + x.group(1) + "://" + unquote(x.group(2), encoding="utf-8") + ")",
        article["content"],
    ).strip()

    # print(article)

    # if re.search("\n +", article["content"]) is not None:
    #     print(file_name)
    # if article["title"] == "":
    #     print(file_name)
    # if article["question"] == "":
    #     print(file_name)
    # if "Tags" in article["content"]:
    #     print(file_name)
    # if article["author"] == "":
    #     print(file_name)
    return article


def getArticleListRecent(path):
    fileList = os.listdir(path)
    for file_name in fileList:
        if ".md" not in file_name or file_name in IGNORE_FILES:
            continue

        rst["total"] += 1

        with open(os.path.join(path, file_name), "r", encoding="utf-8") as f:
            content = f.read()

        tag = "最近更新"
        article = getArticle(file_name, content, tag)

        # if os.path.exists((AUDIO_DIR + file_name).replace(".md", ".wav")):
        #     article["audio"] = True

        data["articles"].append(article)


def getArticleListDir(path):
    for item in path.iterdir():
        if item.is_dir():
            # print(item.name)
            if item.name in IGNORE_PATHS:
                continue
            # 如果是目录，递归处理
            getArticleListDir(item)
        elif item.suffix == ".md":
            if item.name in IGNORE_FILES:
                continue

            # print(item.name)
            rst["total"] += 1
            article = {"id": ""}
            for c in columns:
                article[c] = ""

            with open(item, "r", encoding="utf-8") as f:
                content = f.read()

            tag = CATEGORIES.get(item.parent.name, "")
            article = getArticle(item.name, content, tag)

            data["articles"].append(article)


def getArticleList(DIR, PATHS):

    getArticleListRecent(DIR + "【本周更新】")

    for PATH in PATHS:
        p = Path(DIR + PATH)
        getArticleListDir(p)


def get_data():

    getArticleList(JOHN["SOURCE_DIR"], JOHN["PATHS"])
    getArticleList(NELL["SOURCE_DIR"], NELL["PATHS"])

    print(json.dumps(rst, indent=2))

    # sorted by update time
    data["articles"] = sorted(
        data["articles"], key=lambda k: datetime.strptime(k["lastUpdate"], "%Y-%m-%d").date(), reverse=True
    )
    for order in CONFIG_ORDER:
        for itemName in reversed(order):
            # print(itemName)
            data["articles"].insert(
                0, data["articles"].pop([i for i, obj in enumerate(data["articles"]) if obj["id"] == itemName][0])
            )

    with open(DATABASE_TARGET_PATH, "w", encoding="utf-8") as f:
        # json.dump(data, f, ensure_ascii=False, indent=2)
        json.dump(data, f, ensure_ascii=False)


if __name__ == "__main__":
    get_data()
