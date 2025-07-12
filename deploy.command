#!/bin/bash

# 设置错误处理
set -e

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 切换到项目目录
cd "$SCRIPT_DIR"

echo "🚀 Portfolio Deployer 启动..."
echo "📁 当前目录: $(pwd)"

# 检查是否在正确的项目目录
if [ ! -f "package.json" ]; then
    echo "❌ 错误: 请在项目根目录运行此脚本"
    echo "当前目录: $(pwd)"
    echo "按任意键关闭..."
    read -n 1
    exit 1
fi

echo "✅ 找到 package.json，开始部署..."

# 运行快速部署脚本
if [ -f "quick-deploy.sh" ]; then
    echo "📝 运行快速部署脚本..."
    ./quick-deploy.sh
else
    echo "⚠️  快速部署脚本未找到，执行基本部署..."
    
    # 检查分支
    current_branch=$(git branch --show-current)
    if [ "$current_branch" != "main" ]; then
        echo "🔄 切换到 main 分支..."
        git checkout main
    fi
    
    # 检查更改
    if [ -n "$(git status --porcelain)" ]; then
        echo "📝 添加所有更改..."
        git add .
        
        echo "💾 提交更改..."
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        git commit -m "Auto deploy: $timestamp"
        
        echo "🚀 推送到 GitHub..."
        git push origin main
        
        echo "✅ 部署完成！"
    else
        echo "⚠️  没有检测到更改"
    fi
fi

echo ""
echo "📋 下一步："
echo "1. 查看构建状态: https://github.com/alalalex-m/alalalex-m.github.io/actions"
echo "2. 访问网站: https://alalalex-m.github.io/"
echo ""
echo "⏱️  等待 2-5 分钟让 GitHub Pages 更新..."

# 显示完成通知
osascript -e 'display notification "部署完成！" with title "Portfolio Deployer"'

echo ""
echo "按任意键关闭窗口..."
read -n 1 