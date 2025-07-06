#!/bin/bash

# 创建 Automator 应用程序
APP_NAME="Portfolio Deployer"
WORKFLOW_FILE="${APP_NAME}.workflow"

# 创建 Automator 工作流文件
cat > "$WORKFLOW_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>AMApplicationBuild</key>
	<string>512</string>
	<key>AMApplicationVersion</key>
	<string>2.10</string>
	<key>AMDocumentVersion</key>
	<string>2</string>
	<key>actions</key>
	<array>
		<dict>
			<key>action</key>
			<dict>
				<key>CFBundleIdentifier</key>
				<string>com.apple.Automator.RunShellScript</string>
				<key>WorkflowActionIdentifier</key>
				<string>com.apple.Automator.RunShellScript</string>
			</dict>
			<key>actionParameters</key>
			<dict>
				<key>source</key>
				<string>#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 切换到项目目录
cd "$SCRIPT_DIR"

echo "🚀 Portfolio Deployer 启动..."
echo "📁 当前目录: $(pwd)"

# 检查是否在正确的项目目录
if [ ! -f "package.json" ]; then
    osascript -e 'display alert "错误" message "请在项目根目录运行此应用程序"'
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

# 显示完成通知
osascript -e 'display notification "部署完成！" with title "Portfolio Deployer"'

echo ""
echo "📋 下一步："
echo "1. 查看构建状态: https://github.com/alalalex-m/alalalex-m.github.io/actions"
echo "2. 访问网站: https://alalalex-m.github.io/"
echo ""
echo "⏱️  等待 2-5 分钟让 GitHub Pages 更新..."</string>
			</dict>
			<key>isViewVisible</key>
			<true/>
			<key>location</key>
			<dict>
				<key>x</key>
				<integer>100</integer>
				<key>y</key>
				<integer>100</integer>
			</dict>
			<key>uuid</key>
			<string>12345678-1234-1234-1234-123456789012</string>
		</dict>
	</array>
	<key>connectors</key>
	<dict/>
	<key>workflowType</key>
	<string>Application</string>
</dict>
</plist>
EOF

echo "✅ Automator 工作流文件已创建: $WORKFLOW_FILE"
echo ""
echo "🎯 使用方法："
echo "1. 双击 $WORKFLOW_FILE 打开 Automator"
echo "2. 点击 '运行' 按钮测试"
echo "3. 选择 '文件' → '存储为...' → 选择 '应用程序'"
echo "4. 保存为 'Portfolio Deployer.app'"
echo ""
echo "🔧 或者直接使用现有的 .command 文件："
echo "- 双击 Deploy.command"
echo "- 双击 launch-deployer.sh" 