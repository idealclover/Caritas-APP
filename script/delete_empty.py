# coding = utf-8
import os
import re

DIR = r"/Users/idealclover/GitHub/Sth-Matters/"
PATHS = [r"Anonymity/"]
IGNORE_FILES = [".DS_Store", "README.md", ".md", "致读者 - 关于收费.JPEG"]
# DIR = r"/Users/idealclover/GitHub/Nell-Nell/"
# PATHS = [
#     "00 - 致读者",
#     "01 - “是什么”系列",
#     "02 - “怎么办”系列",
#     "03 - “如何看待”系列",
#     "04 - “好好活着”系列",
#     "05 - 圣经 & 神学",
#     "06 - 书评 & 影评",
#     "08 - 推荐",
#     "09 - 简答",
# ]


def clearBlankLine():
    fileList = os.listdir(DIR)
    for file_name in fileList:
        if ".md" not in file_name or file_name in IGNORE_FILES:
            continue
        # print(file_name)
        with open(os.path.join(DIR, file_name), "r", encoding="utf-8") as f:
            content = f.read()
        content = re.sub("(?: *)\n", "\n", content)
        content = re.sub("\n\n*\n", "\n\n", content)
        content = re.sub("\n\n$", "\n", content)
        content = re.sub("\*\*(.*)。\*\*", "**\g<1>**。", content)
        with open(os.path.join(DIR, file_name), "w", encoding="utf-8") as f:
            f.write(content)

    for PATH in PATHS:
        p = os.walk(DIR + PATH)
        for path, dir_list, file_list in p:
            for file_name in file_list:
                if file_name in IGNORE_FILES:
                    continue
                # print(file_name)
                with open(os.path.join(path, file_name), "r", encoding="utf-8") as f:
                    content = f.read()
                content = re.sub("(?: *)\n", "\n", content)
                content = re.sub("\n\n*\n", "\n\n", content)
                content = re.sub("(?:\n| )*$", "", content)
                content = re.sub("\n +", "\n", content)
                # content = re.sub("$", "\n$", content)
                with open(os.path.join(path, file_name), "w", encoding="utf-8") as f:
                    f.write(content + '\n')

        # file1 = open('poem1.txt', 'r', encoding='utf-8') # 要去掉空行的文件
        # file2 = open('poem2.txt', 'w', encoding='utf-8') # 生成没有空行的文件
        # try:
        #     for line in file1.readlines():
        #         if line == '\n':
        #             line = line.strip("\n")
        #         file2.write(line)
        # finally:
        #     file1.close()
        #     file2.close()


if __name__ == "__main__":
    clearBlankLine()
