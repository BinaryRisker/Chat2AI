# Chat2AI 快速启动指南

这是一个简化的启动指南，帮助您在 5 分钟内运行 Chat2AI 应用。

## 🚀 快速开始

### 前提条件

- ✅ 已安装 [Flutter SDK](https://flutter.dev/docs/get-started/install) (>= 3.0.0)
- ✅ 已安装 [Git](https://git-scm.com/)
- ✅ 拥有 [OpenAI API Key](https://platform.openai.com/api-keys)

### 1️⃣ 克隆项目

```bash
git clone https://github.com/your-username/Chat2AI.git
cd Chat2AI
```

### 2️⃣ 安装依赖

```bash
flutter pub get
```

### 3️⃣ 配置 API Key

创建 `.env` 文件：

```bash
# Windows PowerShell
echo "OPENAI_API_KEY=your_api_key_here" > .env

# macOS/Linux
echo "OPENAI_API_KEY=your_api_key_here" > .env
```

将 `your_api_key_here` 替换为您的实际 OpenAI API Key。

### 4️⃣ 生成代码

```bash
flutter packages pub run build_runner build
```

### 5️⃣ 运行应用

#### 桌面端 (推荐)
```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

#### 移动端
```bash
# Android (需要连接设备或启动模拟器)
flutter run -d android

# iOS (仅 macOS，需要 Xcode)
flutter run -d ios
```

#### Web 端
```bash
flutter run -d chrome
```

## 🎉 完成！

应用启动后，您可以：

1. **开始聊天**: 在输入框中输入消息
2. **切换模型**: 点击模型选择器选择不同的 GPT 模型
3. **查看历史**: 查看之前的对话记录
4. **调整设置**: 配置主题、语言等选项

## ⚡ 一键启动脚本

### Windows (PowerShell)

创建 `start.ps1` 文件：

```powershell
# start.ps1
Write-Host "Starting Chat2AI..." -ForegroundColor Green

# 检查 Flutter
if (!(Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Flutter not found. Please install Flutter first." -ForegroundColor Red
    exit 1
}

# 检查 .env 文件
if (!(Test-Path ".env")) {
    Write-Host "Creating .env file..." -ForegroundColor Yellow
    $apiKey = Read-Host "Please enter your OpenAI API Key"
    "OPENAI_API_KEY=$apiKey" | Out-File -FilePath ".env" -Encoding UTF8
}

# 安装依赖
Write-Host "Installing dependencies..." -ForegroundColor Yellow
flutter pub get

# 生成代码
Write-Host "Generating code..." -ForegroundColor Yellow
flutter packages pub run build_runner build --delete-conflicting-outputs

# 启动应用
Write-Host "Starting application..." -ForegroundColor Green
flutter run -d windows
```

运行脚本：
```powershell
.\start.ps1
```

### macOS/Linux (Bash)

创建 `start.sh` 文件：

```bash
#!/bin/bash
# start.sh

echo "🚀 Starting Chat2AI..."

# 检查 Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter not found. Please install Flutter first."
    exit 1
fi

# 检查 .env 文件
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file..."
    read -p "Please enter your OpenAI API Key: " api_key
    echo "OPENAI_API_KEY=$api_key" > .env
fi

# 安装依赖
echo "📦 Installing dependencies..."
flutter pub get

# 生成代码
echo "⚙️ Generating code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# 启动应用
echo "🎉 Starting application..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    flutter run -d macos
else
    flutter run -d linux
fi
```

运行脚本：
```bash
chmod +x start.sh
./start.sh
```

## 🔧 常见问题快速解决

### 问题 1: 构建失败
```bash
# 清理并重新构建
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 问题 2: API 连接失败
- 检查 `.env` 文件中的 API Key 是否正确
- 确保网络连接正常
- 尝试在应用设置中重新输入 API Key

### 问题 3: 找不到设备
```bash
# 查看可用设备
flutter devices

# 如果没有设备，启动模拟器或连接物理设备
```

### 问题 4: 权限错误 (Linux)
```bash
# 安装必需的依赖
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

## 📱 支持的平台

| 平台 | 状态 | 命令 |
|------|------|------|
| Windows | ✅ 完全支持 | `flutter run -d windows` |
| macOS | ✅ 完全支持 | `flutter run -d macos` |
| Linux | ✅ 完全支持 | `flutter run -d linux` |
| Android | ✅ 完全支持 | `flutter run -d android` |
| iOS | ✅ 完全支持 | `flutter run -d ios` |
| Web | ✅ 完全支持 | `flutter run -d chrome` |

## 🎯 下一步

启动成功后，您可以：

1. 📖 阅读完整的 [README.md](README.md) 了解所有功能
2. 🛠️ 查看 [DEVELOPMENT.md](DEVELOPMENT.md) 学习开发指南
3. ⚙️ 在应用设置中配置更多选项
4. 🤝 加入社区讨论和贡献代码

## 💡 提示

- **首次启动**: 代码生成可能需要几分钟时间
- **热重载**: 开发时使用 `r` 键进行热重载
- **调试**: 使用 `flutter run --debug` 启用调试模式
- **性能**: 使用 `flutter run --release` 获得最佳性能

## 🆘 需要帮助？

- 📋 查看 [Issues](https://github.com/your-username/Chat2AI/issues)
- 💬 加入讨论群
- 📧 发送邮件: your-email@example.com

---

**享受使用 Chat2AI！** 🎉