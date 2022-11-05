from config import *
import json
import upyun


def upload_config():
    up = upyun.UpYun(UPYUN_SERVICE, UPYUN_USERNAME, UPYUN_PASSWORD)
    with open(DATABASE_TARGET_PATH, "r", encoding="utf-8") as f:
        content = f.read()
        res = up.put("/projects/Caritas/data_" + str(DATABASE_VERSION) + ".json", content, checksum=True)
        print(res)
    with open(DATABASE_CONFIG_PATH, "w", encoding="utf-8") as f:
        json.dump(DATABASE_CONFIG_CONTENT, f, ensure_ascii=False)
    with open(DATABASE_CONFIG_PATH, "r", encoding="utf-8") as f:
        content = f.read()
        res = up.put("/projects/Caritas/database.json", content, checksum=True)
        print(res)
