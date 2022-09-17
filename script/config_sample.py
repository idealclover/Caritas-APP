# 生成出的数据库版本及路径

DATABASE_VERSION = 1
DATABASE_TARGET_PATH = r"../res/data.json"

AZURE_KEY = ""
AZURE_REGION = ""

secret_id = ""
secret_key = ""
region = ""
bucket = ""

# 源仓库路径

JOHN = {
    "SOURCE_DIR": r"/Sth-Matters/",
    "PATHS": [r"Anonymity/"],
    "AUDIO_TARGET_DIR": r"/Sth-Matters-Audio/",
    "MP3_TARGET_DIR": r"/Sth-Matters-Audio-MP3/",
}

NELL = {
    "SOURCE_DIR": r"/Nell-Nell/",
    "PATHS": [r"Nell Nell/"],
    "AUDIO_TARGET_DIR": r"/Nell-Nell-Audio/",
    "MP3_TARGET_DIR": r"/Nell-Nell-Audio-MP3/",
}

COS_TARGET_DIR = r"/caritas/audio/"

# 忽略的路径与文件

IGNORE_PATHS = ["05 - 圣经 & 神学", "08 - 推荐"]
IGNORE_FILES = [".DS_Store", "README.md", ".md", "致读者 - 关于收费.JPEG"]

# 需要特殊注明的顺序

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
        "致读者 - 卖瓜 @Anonymity",
        "致你们 @Anonymity",
        "致全体女性 @Anonymity",
        "致读者 - 写作 @NellNell",
        "致读者 - 潜力 @NellNell",
        "致读者 - 十年 @NellNell"
    ]
]

# 分类映射

CATEGORIES = {
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