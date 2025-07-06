#!/bin/bash

# 创建 macOS 应用程序包
APP_NAME="Portfolio Deployer"
APP_DIR="${APP_NAME}.app"
CONTENTS_DIR="${APP_DIR}/Contents"
MACOS_DIR="${CONTENTS_DIR}/MacOS"
RESOURCES_DIR="${CONTENTS_DIR}/Resources"

# 创建目录结构
mkdir -p "$MACOS_DIR" "$RESOURCES_DIR"

# 创建 Info.plist
cat > "${CONTENTS_DIR}/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>deploy</string>
    <key>CFBundleIdentifier</key>
    <string>com.portfolio.deployer</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.10</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>LSBackgroundOnly</key>
    <false/>
    <key>NSAppleEventsUsageDescription</key>
    <string>This app needs to display notifications and alerts.</string>
</dict>
</plist>
EOF

# 创建可执行文件
cat > "${MACOS_DIR}/deploy" << 'EOF'
#!/bin/bash

# 设置错误处理
set -e

# 获取应用程序包所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
PROJECT_DIR="$(dirname "$APP_DIR")"

# 切换到项目目录
cd "$PROJECT_DIR"

# 记录日志（用于调试）
LOG_FILE="/tmp/portfolio-deployer.log"
echo "$(date): Starting deployment from $PROJECT_DIR" > "$LOG_FILE"

# 检查是否在正确的项目目录
if [ ! -f "package.json" ]; then
    echo "$(date): Error - package.json not found" >> "$LOG_FILE"
    osascript -e 'display alert "错误" message "请在项目根目录运行此应用程序"'
    exit 1
fi

echo "$(date): Found package.json, proceeding with deployment" >> "$LOG_FILE"

# 运行快速部署脚本
if [ -f "quick-deploy.sh" ]; then
    echo "$(date): Running quick-deploy.sh" >> "$LOG_FILE"
    ./quick-deploy.sh >> "$LOG_FILE" 2>&1
else
    echo "$(date): quick-deploy.sh not found, running basic deployment" >> "$LOG_FILE"
    # 如果没有快速部署脚本，执行基本部署
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

echo "$(date): Deployment completed" >> "$LOG_FILE"

# 显示完成消息
osascript -e 'display notification "部署完成！" with title "Portfolio Deployer"'

# 等待几秒后关闭
sleep 2
EOF

# 给可执行文件添加权限
chmod +x "${MACOS_DIR}/deploy"

# 创建启动脚本（备用方案）
cat > "launch-deployer.sh" << 'EOF'
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
EOF

chmod +x "launch-deployer.sh"

echo "✅ macOS 应用程序包已创建: ${APP_DIR}"
echo "📁 位置: $(pwd)/${APP_DIR}"
echo ""
echo "🎯 使用方法："
echo "1. 双击 ${APP_DIR} 运行部署"
echo "2. 或者将应用程序拖到 Dock 中"
echo "3. 每次修改代码后，双击即可自动部署"
echo ""
echo "🔧 如果应用闪退，请尝试："
echo "1. 双击 launch-deployer.sh (备用方案)"
echo "2. 查看日志: cat /tmp/portfolio-deployer.log"
echo "3. 确保在项目根目录运行" 