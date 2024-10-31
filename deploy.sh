#!/bin/bash

# 添加所有修改
git add.

# 检查文件是否成功添加到暂存区
if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to add. Please check your files."
    exit 1
fi

# 设置提交说明，格式为 Site updated: YYYY-MM-DD HH:MM:SS
time=$(date "+%Y-%m-dd HH:MM:SS")
commit="Site updated:"$time
echo $commit

# 提交
git commit -m "$commit"

# 检查是否成功提交
if [ -z "$(git log -1)" ]; then
    echo "Commit failed. Please check your commit message and try again."
    exit 1
fi

# 推送到source分支上
git push origin main

# 检查推送是否成功
if [ $? -ne 0 ]; then
    echo "Push to main branch failed. Please check your network connection and remote repository settings."
    exit 1
fi