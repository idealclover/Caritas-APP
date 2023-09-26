import os
from pathlib import Path

# 定义源文件夹和目标文件夹
folder_A = Path('C:\\Users\\cuiro\\Documents\\GitHub\\Sth-Matters-bak\\Anonymity')
folder_B = Path('C:\\Users\\cuiro\\Documents\\GitHub\\Sth-Matters\\【文章目录】')

# 创建一个空列表用于存储匹配不到的文件名称
unmatched_files = []

# 创建一个计数器用于记录匹配到的文件数量
matched_files_count = [0]

def process_folder(b_folder, a_folder, unmatched, matched_count):
    for b_item in b_folder.iterdir():
        if b_item.is_dir():
            # 如果是目录，递归处理
            process_folder(b_item, a_folder, unmatched, matched_count)
        elif b_item.suffix == '.md':
            # 如果是 markdown 文件
            found = False
            for a_subfolder in a_folder.iterdir():
                if a_subfolder.is_dir():
                    a_file = a_subfolder / b_item.name
                    if a_file.exists():
                        found = True
                        print(a_subfolder.name[5:])
                        with open(b_item, 'r', encoding='utf-8') as file:
                            lines = file.readlines()
                        lines.insert(6, '> Category: #' + a_subfolder.name[5:] + '\n')
                        with open(b_item, 'w', encoding='utf-8') as file:
                            file.writelines(lines)
                        # 更新匹配到的文件数量
                        matched_count[0] += 1
                        break
            if not found:
                unmatched.append(str(b_item))

# 这里我们使用一个列表来存储计数器，因为Python的函数只能修改可变类型的参数
process_folder(folder_B, folder_A, unmatched_files, matched_files_count)

# 输出匹配到的文件数量
print(f"Matched files count: {matched_files_count[0]}")

# 将没有匹配的文件写入到日志文件中
with open('unmatched_files.log', 'w') as log_file:
    for file_name in unmatched_files:
        log_file.write(file_name + '\n')