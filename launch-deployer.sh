#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 切换到项目目录
cd "$SCRIPT_DIR"

# 检查是否在正确的项目目录
if [ ! -f "package.json" ]; then
    osascript -e 'display alert "错误" message "请在项目根目录运行此脚本"'
    exit 1
fi

# 运行快速部署脚本
if [ -f "quick-deploy.sh" ]; then
    ./quick-deploy.sh
else
    echo "🚀 开始部署..."
    
    # 检查分支
    current_branch=$(git branch --show-current)
    if [ "$current_branch" != "main" ]; then
        git checkout main
    fi
    
    # 检查更改
    if [ -n "$(git status --porcelain)" ]; then
        git add .
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        git commit -m "Auto deploy: $timestamp"
        git push origin main
        echo "✅ 部署完成！"
    else
        echo "⚠️  没有检测到更改"
    fi
fi

# 显示完成消息
osascript -e 'display notification "部署完成！" with title "Portfolio Deployer"'

echo "按任意键关闭..."
read -n 1
