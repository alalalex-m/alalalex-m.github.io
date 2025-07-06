# 🚀 自动化部署指南

## 概述

本项目提供了多种自动化部署方式，让你可以轻松地将网站更新推送到 GitHub Pages。

## 📁 部署工具

### 1. Deploy.command (推荐 - 最稳定)
- **位置**: `Deploy.command`
- **使用方法**: 双击运行
- **特点**: 
  - 自动打开终端
  - 显示详细进度
  - 自动显示通知
  - 执行完成后保持窗口打开

### 2. launch-deployer.sh (备用方案)
- **位置**: `launch-deployer.sh`
- **使用方法**: 双击运行
- **特点**: 
  - 简单的备用方案
  - 显示完成通知

### 3. Portfolio Deployer.app (实验性)
- **位置**: `Portfolio Deployer.app`
- **使用方法**: 双击运行
- **特点**: 
  - 无需打开终端
  - 自动显示通知
  - 可以拖到 Dock 中
- **注意**: 如果闪退，请使用其他方案

### 2. quick-deploy.sh (快速部署)
- **位置**: `quick-deploy.sh`
- **使用方法**: 
  ```bash
  ./quick-deploy.sh
  ```
- **特点**: 
  - 快速执行，无交互
  - 适合命令行用户

### 3. deploy.sh (完整部署)
- **位置**: `deploy.sh`
- **使用方法**: 
  ```bash
  ./deploy.sh
  ```
- **特点**: 
  - 包含本地构建测试
  - 交互式操作
  - 详细的状态显示

### 4. deploy.command (macOS 双击运行)
- **位置**: `deploy.command`
- **使用方法**: 双击运行
- **特点**: 
  - 自动打开终端
  - 执行完成后保持窗口打开

## 🎯 推荐工作流程

### 日常更新 (推荐使用 Deploy.command)
1. 修改你的代码
2. 双击 `Deploy.command`
3. 等待部署完成通知
4. 访问 https://alalalex-m.github.io/ 查看更新

### 开发测试 (推荐使用 deploy.sh)
1. 修改代码
2. 运行 `./deploy.sh`
3. 选择是否进行本地构建测试
4. 推送到 GitHub
5. 等待 GitHub Actions 构建完成

## ⚙️ 自动化流程说明

所有部署工具都会自动执行以下步骤：

1. **检查环境**
   - 确保在项目根目录
   - 确保在 main 分支

2. **代码管理**
   - 检查是否有未提交的更改
   - 添加所有更改到暂存区
   - 生成带时间戳的提交信息
   - 提交更改

3. **推送部署**
   - 推送到 GitHub main 分支
   - 触发 GitHub Actions 自动构建
   - 自动部署到 GitHub Pages

4. **状态反馈**
   - 显示部署状态
   - 提供相关链接
   - 显示完成通知

## 🔧 故障排除

### 常见问题

**Q: 双击应用没有反应？**
A: 确保在项目根目录运行，检查是否有 `package.json` 文件

**Q: 推送失败？**
A: 检查网络连接和 GitHub 认证状态

**Q: 网站没有更新？**
A: 
- 等待 2-5 分钟让 GitHub Pages 更新
- 检查 GitHub Actions 构建状态
- 清除浏览器缓存

**Q: 构建失败？**
A: 
- 查看 GitHub Actions 日志
- 检查代码是否有语法错误
- 确保所有依赖都正确安装

### 手动检查步骤

1. **检查 GitHub Actions**
   ```
   https://github.com/alalalex-m/alalalex-m.github.io/actions
   ```

2. **检查 GitHub Pages 设置**
   - 进入仓库 Settings → Pages
   - 确保 Source 设置为 "Deploy from a branch"
   - 确保分支设置为 "gh-pages"

3. **检查网站状态**
   ```
   https://alalalex-m.github.io/
   ```

## 📝 自定义配置

### 修改提交信息格式
编辑 `deploy.sh` 或 `quick-deploy.sh` 中的 `commit_message` 变量：

```bash
commit_message="你的自定义格式: $timestamp"
```

### 添加部署前检查
在脚本中添加自定义检查逻辑：

```bash
# 在 git add . 之前添加
echo "运行自定义检查..."
# 你的检查逻辑
```

### 修改通知消息
编辑 `Portfolio Deployer.app` 中的通知文本：

```bash
osascript -e 'display notification "你的自定义消息" with title "你的标题"'
```

## 🎉 开始使用

现在你可以：
1. 修改任何代码文件
2. 双击 `Portfolio Deployer.app`
3. 等待部署完成
4. 享受自动化的部署体验！

---

**提示**: 建议将 `Deploy.command` 拖到 Dock 中，这样每次更新都会更方便！

## 🔧 故障排除

### 应用闪退问题

**Q: Portfolio Deployer.app 闪退？**
A: 这是已知问题，请使用以下替代方案：
- 双击 `Deploy.command` (推荐)
- 双击 `launch-deployer.sh`
- 使用命令行: `./quick-deploy.sh`

**Q: 如何创建更稳定的应用程序？**
A: 使用 Automator 工作流：
1. 双击 `Portfolio Deployer.workflow`
2. 在 Automator 中点击 "运行" 测试
3. 选择 "文件" → "存储为..." → "应用程序"
4. 保存为新的应用程序 