#!/bin/bash

# 设置颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}🚀 快速部署脚本启动...${NC}"

# 检查是否在正确的目录
if [ ! -f "package.json" ]; then
    echo -e "${RED}❌ 请在项目根目录运行此脚本${NC}"
    exit 1
fi

# 检查是否在 main 分支
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    echo -e "${YELLOW}⚠️  切换到 main 分支...${NC}"
    git checkout main
fi

# 检查是否有更改
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}⚠️  没有检测到更改${NC}"
    exit 0
fi

# 执行部署流程
echo -e "${GREEN}📝 添加所有更改...${NC}"
git add .

echo -e "${GREEN}💾 提交更改...${NC}"
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
git commit -m "Auto deploy: $timestamp"

echo -e "${GREEN}🚀 推送到 GitHub...${NC}"
git push origin main

echo -e "${GREEN}✅ 部署完成！${NC}"
echo -e "${YELLOW}📋 下一步：${NC}"
echo "1. 查看构建状态: https://github.com/alalalex-m/alalalex-m.github.io/actions"
echo "2. 访问网站: https://alalalex-m.github.io/"
echo ""
echo -e "${YELLOW}⏱️  等待 2-5 分钟让 GitHub Pages 更新...${NC}" 