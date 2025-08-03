# Chat2AI 部署指南

本文档详细介绍如何构建和部署 Chat2AI 应用到各个平台。

## 目录

- [构建准备](#构建准备)
- [桌面端部署](#桌面端部署)
- [移动端部署](#移动端部署)
- [Web 端部署](#web-端部署)
- [自动化部署](#自动化部署)
- [发布流程](#发布流程)
- [故障排除](#故障排除)

## 构建准备

### 1. 环境检查

```bash
# 检查 Flutter 环境
flutter doctor -v

# 检查项目状态
flutter analyze
flutter test
```

### 2. 版本管理

更新 `pubspec.yaml` 中的版本号：

```yaml
version: 1.0.0+1
#        ^^^^^ ^
#        |     |
#        |     +-- build number (每次构建递增)
#        +-------- version name (语义化版本)
```

### 3. 代码生成

```bash
# 确保所有生成的代码是最新的
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 4. 清理项目

```bash
flutter clean
flutter pub get
```

## 桌面端部署

### Windows 部署

#### 1. 构建应用

```bash
# 构建 Release 版本
flutter build windows --release

# 构建产物位置
# build/windows/runner/Release/
```

#### 2. 创建安装包

**方法 1: 使用 MSIX (推荐)**

添加依赖到 `pubspec.yaml`：

```yaml
dev_dependencies:
  msix: ^3.16.6
```

配置 MSIX：

```yaml
msix_config:
  display_name: Chat2AI
  publisher_display_name: Your Name
  identity_name: com.yourcompany.chat2ai
  msix_version: 1.0.0.0
  description: A ChatGPT client application
  logo_path: assets/icon/icon.png
  start_menu_icon_path: assets/icon/icon.png
  tile_icon_path: assets/icon/icon.png
  icons_background_color: transparent
  architecture: x64
```

构建 MSIX 包：

```bash
flutter pub get
flutter pub run msix:create
```

**方法 2: 使用 Inno Setup**

1. 下载并安装 [Inno Setup](https://jrsoftware.org/isinfo.php)
2. 创建 `installer.iss` 文件：

```ini
[Setup]
AppName=Chat2AI
AppVersion=1.0.0
DefaultDirName={autopf}\Chat2AI
DefaultGroupName=Chat2AI
OutputDir=dist
OutputBaseFilename=Chat2AI-Setup
SetupIconFile=assets\icon\icon.ico
Compression=lzma2
SolidCompression=yes

[Files]
Source: "build\windows\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\Chat2AI"; Filename: "{app}\chatgpt.exe"
Name: "{autodesktop}\Chat2AI"; Filename: "{app}\chatgpt.exe"

[Run]
Filename: "{app}\chatgpt.exe"; Description: "Launch Chat2AI"; Flags: nowait postinstall skipifsilent
```

编译安装包：

```bash
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" installer.iss
```

### macOS 部署

#### 1. 构建应用

```bash
# 构建 Release 版本
flutter build macos --release

# 构建产物位置
# build/macos/Build/Products/Release/chatgpt.app
```

#### 2. 代码签名 (可选)

```bash
# 查看可用的签名身份
security find-identity -v -p codesigning

# 签名应用
codesign --force --verify --verbose --sign "Developer ID Application: Your Name" build/macos/Build/Products/Release/chatgpt.app

# 验证签名
codesign --verify --verbose build/macos/Build/Products/Release/chatgpt.app
```

#### 3. 创建 DMG 安装包

**方法 1: 使用 create-dmg**

```bash
# 安装 create-dmg
brew install create-dmg

# 创建 DMG
create-dmg \
  --volname "Chat2AI" \
  --volicon "assets/icon/icon.icns" \
  --window-pos 200 120 \
  --window-size 600 300 \
  --icon-size 100 \
  --icon "chatgpt.app" 175 120 \
  --hide-extension "chatgpt.app" \
  --app-drop-link 425 120 \
  "Chat2AI.dmg" \
  "build/macos/Build/Products/Release/"
```

**方法 2: 手动创建**

1. 创建临时文件夹并复制应用
2. 使用磁盘工具创建 DMG
3. 自定义 DMG 外观

### Linux 部署

#### 1. 构建应用

```bash
# 构建 Release 版本
flutter build linux --release

# 构建产物位置
# build/linux/x64/release/bundle/
```

#### 2. 创建 AppImage

**安装 appimagetool:**

```bash
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
```

**创建 AppDir 结构:**

```bash
mkdir -p Chat2AI.AppDir/usr/bin
mkdir -p Chat2AI.AppDir/usr/lib
mkdir -p Chat2AI.AppDir/usr/share/applications
mkdir -p Chat2AI.AppDir/usr/share/icons/hicolor/256x256/apps

# 复制应用文件
cp -r build/linux/x64/release/bundle/* Chat2AI.AppDir/usr/bin/

# 创建桌面文件
cat > Chat2AI.AppDir/usr/share/applications/chat2ai.desktop << EOF
[Desktop Entry]
Type=Application
Name=Chat2AI
Exec=chatgpt
Icon=chat2ai
Categories=Utility;
EOF

# 复制图标
cp assets/icon/icon.png Chat2AI.AppDir/usr/share/icons/hicolor/256x256/apps/chat2ai.png
cp assets/icon/icon.png Chat2AI.AppDir/chat2ai.png

# 创建 AppRun
cat > Chat2AI.AppDir/AppRun << 'EOF'
#!/bin/bash
HERE="$(dirname "$(readlink -f "${0}")")" 
exec "$HERE/usr/bin/chatgpt" "$@"
EOF
chmod +x Chat2AI.AppDir/AppRun

# 构建 AppImage
./appimagetool-x86_64.AppImage Chat2AI.AppDir Chat2AI-x86_64.AppImage
```

#### 3. 创建 DEB 包

```bash
# 创建包结构
mkdir -p chat2ai_1.0.0_amd64/DEBIAN
mkdir -p chat2ai_1.0.0_amd64/usr/bin
mkdir -p chat2ai_1.0.0_amd64/usr/share/applications
mkdir -p chat2ai_1.0.0_amd64/usr/share/icons/hicolor/256x256/apps

# 创建控制文件
cat > chat2ai_1.0.0_amd64/DEBIAN/control << EOF
Package: chat2ai
Version: 1.0.0
Section: utils
Priority: optional
Architecture: amd64
Maintainer: Your Name <your.email@example.com>
Description: A ChatGPT client application
 Built with Flutter for Linux desktop.
EOF

# 复制文件
cp -r build/linux/x64/release/bundle/* chat2ai_1.0.0_amd64/usr/bin/
cp debian/gui/chatgpt.desktop chat2ai_1.0.0_amd64/usr/share/applications/
cp assets/icon/icon.png chat2ai_1.0.0_amd64/usr/share/icons/hicolor/256x256/apps/chat2ai.png

# 构建 DEB 包
dpkg-deb --build chat2ai_1.0.0_amd64
```

## 移动端部署

### Android 部署

#### 1. 配置签名

**生成签名密钥:**

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**配置签名文件 `android/key.properties`:**

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

**更新 `android/app/build.gradle`:**

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

#### 2. 构建 APK

```bash
# 构建 Release APK
flutter build apk --release

# 构建分架构 APK (减小包大小)
flutter build apk --split-per-abi --release

# 构建产物位置
# build/app/outputs/flutter-apk/app-release.apk
```

#### 3. 构建 App Bundle (推荐)

```bash
# 构建 App Bundle
flutter build appbundle --release

# 构建产物位置
# build/app/outputs/bundle/release/app-release.aab
```

#### 4. 发布到 Google Play

1. 登录 [Google Play Console](https://play.google.com/console)
2. 创建新应用或选择现有应用
3. 上传 App Bundle 文件
4. 填写应用信息、截图等
5. 提交审核

### iOS 部署

#### 1. 配置 Xcode 项目

```bash
# 打开 Xcode 项目
open ios/Runner.xcworkspace
```

在 Xcode 中配置：
- Bundle Identifier
- Team (开发者账号)
- Signing Certificate
- Provisioning Profile

#### 2. 构建应用

```bash
# 构建 Release 版本
flutter build ios --release

# 或者在 Xcode 中构建
# Product -> Archive
```

#### 3. 发布到 App Store

1. 在 Xcode 中选择 Product -> Archive
2. 在 Organizer 中选择 Distribute App
3. 选择 App Store Connect
4. 上传到 App Store Connect
5. 在 App Store Connect 中提交审核

## Web 端部署

### 1. 构建 Web 应用

```bash
# 构建 Release 版本
flutter build web --release

# 构建产物位置
# build/web/
```

### 2. 部署到静态托管

#### GitHub Pages

```bash
# 安装 gh-pages
npm install -g gh-pages

# 部署到 GitHub Pages
gh-pages -d build/web
```

#### Netlify

1. 将 `build/web` 文件夹拖拽到 Netlify
2. 或者连接 GitHub 仓库自动部署

#### Vercel

```bash
# 安装 Vercel CLI
npm install -g vercel

# 部署
cd build/web
vercel
```

#### Firebase Hosting

```bash
# 安装 Firebase CLI
npm install -g firebase-tools

# 初始化 Firebase
firebase init hosting

# 部署
firebase deploy
```

### 3. 配置 Web 服务器

**Nginx 配置:**

```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /path/to/build/web;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # 启用 gzip 压缩
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
```

**Apache 配置:**

```apache
<VirtualHost *:80>
    ServerName your-domain.com
    DocumentRoot /path/to/build/web
    
    <Directory /path/to/build/web>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        
        # 启用 HTML5 路由
        RewriteEngine On
        RewriteBase /
        RewriteRule ^index\.html$ - [L]
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule . /index.html [L]
    </Directory>
</VirtualHost>
```

## 自动化部署

### GitHub Actions

创建 `.github/workflows/deploy.yml`：

```yaml
name: Build and Deploy

on:
  push:
    tags:
      - 'v*'
  workflow_dispatch:

jobs:
  build-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter packages pub run build_runner build
      - run: flutter build windows --release
      - uses: actions/upload-artifact@v3
        with:
          name: windows-build
          path: build/windows/runner/Release/

  build-macos:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter packages pub run build_runner build
      - run: flutter build macos --release
      - uses: actions/upload-artifact@v3
        with:
          name: macos-build
          path: build/macos/Build/Products/Release/

  build-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: |
          sudo apt-get update -y
          sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev
      - run: flutter pub get
      - run: flutter packages pub run build_runner build
      - run: flutter build linux --release
      - uses: actions/upload-artifact@v3
        with:
          name: linux-build
          path: build/linux/x64/release/bundle/

  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '11'
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter packages pub run build_runner build
      - run: flutter build apk --release
      - run: flutter build appbundle --release
      - uses: actions/upload-artifact@v3
        with:
          name: android-build
          path: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab

  build-web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter packages pub run build_runner build
      - run: flutter build web --release
      - uses: actions/upload-artifact@v3
        with:
          name: web-build
          path: build/web/

  release:
    needs: [build-windows, build-macos, build-linux, build-android, build-web]
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/')
    steps:
      - uses: actions/download-artifact@v3
      - name: Create Release
        uses: softprops/action-gh-release@v1
        with:
          files: |
            windows-build/**/*
            macos-build/**/*
            linux-build/**/*
            android-build/**/*
            web-build/**/*
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## 发布流程

### 1. 版本发布检查清单

- [ ] 更新版本号
- [ ] 更新 CHANGELOG.md
- [ ] 运行所有测试
- [ ] 检查代码质量
- [ ] 更新文档
- [ ] 创建发布标签

### 2. 发布脚本

创建 `scripts/release.sh`：

```bash
#!/bin/bash

set -e

# 获取版本号
VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.0.0"
    exit 1
fi

echo "🚀 Preparing release $VERSION"

# 检查工作目录是否干净
if [ -n "$(git status --porcelain)" ]; then
    echo "❌ Working directory is not clean"
    exit 1
fi

# 更新版本号
echo "📝 Updating version to $VERSION"
sed -i "s/^version: .*/version: $VERSION+$(date +%s)/" pubspec.yaml

# 运行测试
echo "🧪 Running tests"
flutter test

# 代码检查
echo "🔍 Running code analysis"
flutter analyze

# 生成代码
echo "⚙️ Generating code"
flutter packages pub run build_runner build --delete-conflicting-outputs

# 提交更改
echo "💾 Committing changes"
git add .
git commit -m "chore: bump version to $VERSION"

# 创建标签
echo "🏷️ Creating tag"
git tag -a "v$VERSION" -m "Release $VERSION"

# 推送到远程
echo "📤 Pushing to remote"
git push origin main
git push origin "v$VERSION"

echo "✅ Release $VERSION prepared successfully!"
echo "📋 Next steps:"
echo "   1. Wait for CI/CD to build artifacts"
echo "   2. Create GitHub release with changelog"
echo "   3. Publish to app stores if needed"
```

使用脚本：

```bash
chmod +x scripts/release.sh
./scripts/release.sh 1.0.0
```

## 故障排除

### 构建问题

**问题**: 构建失败
```bash
# 清理并重新构建
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**问题**: 依赖冲突
```bash
# 更新依赖
flutter pub upgrade
```

### 签名问题

**Android**: 签名配置错误
- 检查 `key.properties` 文件路径
- 验证密钥库密码
- 确保密钥别名正确

**iOS**: 证书问题
- 检查开发者账号状态
- 更新 Provisioning Profile
- 验证 Bundle Identifier

### 部署问题

**Web**: 路由问题
- 配置服务器支持 HTML5 路由
- 检查 base href 设置

**桌面**: 依赖缺失
- 确保目标系统安装了必要的运行时
- 检查动态库依赖

---

完成部署后，记得测试所有平台的功能是否正常工作！