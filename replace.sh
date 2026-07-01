#!/bin/bash

# 替换当前目录下所有 .md 文件中的字符串
for file in ./docs/*.md; do
  if [ -f "$file" ]; then
    sed -i.bak -e 's|http://ciyuanshangcheng.com|https://tokengine.hanyoai.com|g' \
               -e 's|词链AI|Tokengine平台|g' "$file"
    # 删除备份
    rm -f "$file.bak"
  fi
done