#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 切换到项目目录
cd "$SCRIPT_DIR"

# 运行部署脚本
./deploy.sh

# 保持终端窗口打开
echo ""
echo "按任意键关闭窗口..."
read -n 1 