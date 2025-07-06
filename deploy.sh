#!/bin/bash

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# 检查是否在正确的目录
if [ ! -f "package.json" ]; then
    print_error "请在项目根目录运行此脚本"
    exit 1
fi

# 检查是否在 main 分支
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    print_warning "当前分支是 $current_branch，正在切换到 main 分支..."
    git checkout main
    if [ $? -ne 0 ]; then
        print_error "切换到 main 分支失败"
        exit 1
    fi
fi

print_step "开始自动化部署流程..."

# 1. 检查是否有未提交的更改
if [ -z "$(git status --porcelain)" ]; then
    print_warning "没有检测到任何更改，无需部署"
    exit 0
fi

# 2. 显示当前更改
print_step "检测到的更改："
git status --short

# 3. 添加所有更改
print_step "添加所有更改到暂存区..."
git add .
if [ $? -ne 0 ]; then
    print_error "添加文件失败"
    exit 1
fi

# 4. 生成提交信息
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
commit_message="Auto deploy: $timestamp"

# 5. 提交更改
print_step "提交更改..."
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
    print_error "提交失败"
    exit 1
fi

# 6. 推送到远程仓库
print_step "推送到 GitHub..."
git push origin main
if [ $? -ne 0 ]; then
    print_error "推送失败"
    exit 1
fi

print_message "✅ 代码已成功推送到 GitHub"

# 7. 等待用户确认是否要本地构建测试
echo ""
read -p "是否要在本地构建测试？(y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_step "开始本地构建测试..."
    
    # 检查 Node.js 是否安装
    if ! command -v node &> /dev/null; then
        print_error "Node.js 未安装，跳过本地构建"
    else
        # 安装依赖
        print_step "安装依赖..."
        npm install
        if [ $? -ne 0 ]; then
            print_error "依赖安装失败"
            exit 1
        fi
        
        # 构建项目
        print_step "构建项目..."
        npm run build
        if [ $? -ne 0 ]; then
            print_error "构建失败"
            exit 1
        fi
        
        print_message "✅ 本地构建成功"
    fi
fi

# 8. 显示部署信息
echo ""
print_message "🚀 部署流程完成！"
echo ""
print_step "下一步："
echo "1. 访问 GitHub Actions: https://github.com/alalalex-m/alalalex-m.github.io/actions"
echo "2. 等待构建完成（通常 2-5 分钟）"
echo "3. 访问你的网站: https://alalalex-m.github.io/"
echo ""
print_warning "注意：GitHub Pages 可能需要几分钟时间才能更新"

# 9. 可选：打开相关链接
read -p "是否要打开 GitHub Actions 页面？(y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    open "https://github.com/alalalex-m/alalalex-m.github.io/actions"
fi

read -p "是否要打开你的网站？(y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    open "https://alalalex-m.github.io/"
fi

print_message "自动化部署脚本执行完成！" 