# Chat2AI 开发指南

本文档提供了 Chat2AI 项目的详细开发指南，包括环境搭建、开发流程、调试技巧和最佳实践。

## 目录

- [开发环境搭建](#开发环境搭建)
- [项目初始化](#项目初始化)
- [开发流程](#开发流程)
- [代码生成详解](#代码生成详解)
- [调试指南](#调试指南)
- [测试指南](#测试指南)
- [性能优化](#性能优化)
- [部署指南](#部署指南)
- [常见问题](#常见问题)

## 开发环境搭建

### 1. 安装 Flutter SDK

#### Windows
```powershell
# 使用 Chocolatey 安装 (推荐)
choco install flutter

# 或者手动下载安装
# 1. 从 https://flutter.dev/docs/get-started/install/windows 下载
# 2. 解压到 C:\flutter
# 3. 添加 C:\flutter\bin 到 PATH 环境变量
```

#### macOS
```bash
# 使用 Homebrew 安装 (推荐)
brew install --cask flutter

# 或者手动下载安装
# 从 https://flutter.dev/docs/get-started/install/macos 下载
```

#### Linux
```bash
# 下载并解压
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.x.x-stable.tar.xz
tar xf flutter_linux_3.x.x-stable.tar.xz

# 添加到 PATH
echo 'export PATH="$PATH:`pwd`/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

### 2. 验证安装

```bash
flutter doctor
```

确保所有检查项都通过，如有问题按提示解决。

### 3. 配置 IDE

#### VS Code (推荐)
安装以下插件：
- Flutter
- Dart
- Flutter Widget Snippets
- Bracket Pair Colorizer
- GitLens

#### Android Studio
安装 Flutter 和 Dart 插件。

### 4. 平台特定配置

#### Android 开发
```bash
# 安装 Android Studio 和 Android SDK
# 配置 ANDROID_HOME 环境变量
flutter doctor --android-licenses
```

#### iOS 开发 (仅 macOS)
```bash
# 安装 Xcode
# 安装 CocoaPods
sudo gem install cocoapods
```

#### 桌面开发

**Windows:**
```powershell
# 启用 Windows 桌面支持
flutter config --enable-windows-desktop

# 安装 Visual Studio 2022 (包含 C++ 工具)
```

**macOS:**
```bash
# 启用 macOS 桌面支持
flutter config --enable-macos-desktop
```

**Linux:**
```bash
# 启用 Linux 桌面支持
flutter config --enable-linux-desktop

# 安装依赖
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

## 项目初始化

### 1. 克隆项目

```bash
git clone https://github.com/your-username/Chat2AI.git
cd Chat2AI
```

### 2. 安装依赖

```bash
# 安装 Flutter 依赖
flutter pub get

# 安装 iOS 依赖 (仅 macOS)
cd ios && pod install && cd ..

# 安装 macOS 依赖 (仅 macOS)
cd macos && pod install && cd ..
```

### 3. 环境变量配置

创建 `.env` 文件：

```bash
cp .env.example .env
```

编辑 `.env` 文件：

```env
# 必需配置
OPENAI_API_KEY=sk-your-openai-api-key-here

# 可选配置
HTTP_PROXY=http://proxy.example.com:8080
BASE_URL=https://api.openai.com/v1
```

### 4. 代码生成

```bash
# 生成所有必需的代码
flutter packages pub run build_runner build

# 如果遇到冲突，强制重新生成
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 5. 验证安装

```bash
# 检查项目状态
flutter analyze

# 运行测试
flutter test

# 启动应用 (选择目标平台)
flutter run -d windows  # Windows
flutter run -d chrome   # Web
flutter run -d android  # Android
```

## 开发流程

### 1. 分支管理

```bash
# 创建功能分支
git checkout -b feature/new-feature

# 创建修复分支
git checkout -b fix/bug-description

# 创建发布分支
git checkout -b release/v1.0.0
```

### 2. 开发循环

1. **编写代码**
2. **运行代码生成** (如果修改了模型或状态)
   ```bash
   flutter packages pub run build_runner watch
   ```
3. **测试功能**
   ```bash
   flutter run
   ```
4. **代码检查**
   ```bash
   flutter analyze
   flutter test
   ```
5. **提交代码**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

### 3. 热重载开发

```bash
# 启动热重载模式
flutter run

# 在应用运行时:
# r - 热重载
# R - 热重启
# q - 退出
# h - 帮助
```

## 代码生成详解

### 1. 数据库代码生成 (Floor)

当修改数据模型时：

```bash
# 生成数据库相关代码
flutter packages pub run build_runner build --build-filter="lib/data/database.g.dart"
```

相关文件：
- `lib/models/*.dart` - 数据模型
- `lib/data/dao/*.dart` - 数据访问对象
- `lib/data/database.dart` - 数据库配置

### 2. 状态管理代码生成 (Riverpod)

当修改状态提供者时：

```bash
# 生成状态管理代码
flutter packages pub run build_runner build --build-filter="lib/states/*.g.dart"
```

相关文件：
- `lib/states/*.dart` - 状态提供者

### 3. 序列化代码生成 (Freezed + JSON)

当修改数据类时：

```bash
# 生成序列化代码
flutter packages pub run build_runner build --build-filter="lib/models/*.freezed.dart"
flutter packages pub run build_runner build --build-filter="lib/models/*.g.dart"
```

### 4. 环境变量代码生成 (Envied)

当修改环境变量时：

```bash
# 生成环境变量代码
flutter packages pub run build_runner build --build-filter="lib/env.g.dart"
```

### 5. 国际化代码生成

当修改翻译文件时：

```bash
# 生成国际化代码
flutter gen-l10n
```

## 调试指南

### 1. 日志调试

```dart
// 使用项目内置的 logger
import '../injection.dart';

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

### 2. 断点调试

#### VS Code
1. 在代码行号左侧点击设置断点
2. 按 F5 启动调试模式
3. 使用调试控制台查看变量

#### Android Studio
1. 点击行号左侧设置断点
2. 点击调试按钮启动
3. 使用调试窗口查看调用栈和变量

### 3. 网络调试

```dart
// 启用网络日志
import 'package:dio/dio.dart';

final dio = Dio();
dio.interceptors.add(LogInterceptor(
  requestBody: true,
  responseBody: true,
));
```

### 4. 性能调试

```bash
# 启用性能分析
flutter run --profile

# 在应用中按 'P' 打开性能面板
```

### 5. 内存调试

```bash
# 启用内存分析
flutter run --debug

# 使用 Flutter Inspector 查看 Widget 树
```

## 测试指南

### 1. 单元测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/db_test.dart

# 运行测试并生成覆盖率报告
flutter test --coverage
```

### 2. 集成测试

```bash
# 运行集成测试
flutter drive --target=test_driver/app.dart
```

### 3. Widget 测试

```dart
// 示例 Widget 测试
testWidgets('Chat input widget test', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // 查找输入框
  expect(find.byType(TextField), findsOneWidget);
  
  // 输入文本
  await tester.enterText(find.byType(TextField), 'Hello');
  await tester.pump();
  
  // 验证结果
  expect(find.text('Hello'), findsOneWidget);
});
```

## 性能优化

### 1. 构建优化

```bash
# 分析包大小
flutter build apk --analyze-size
flutter build appbundle --analyze-size

# 启用代码压缩
flutter build apk --obfuscate --split-debug-info=debug-info/
```

### 2. 运行时优化

```dart
// 使用 const 构造函数
const Text('Hello World')

// 避免在 build 方法中创建对象
class MyWidget extends StatelessWidget {
  static const _textStyle = TextStyle(fontSize: 16);
  
  @override
  Widget build(BuildContext context) {
    return Text('Hello', style: _textStyle);
  }
}

// 使用 ListView.builder 处理长列表
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(
    title: Text(items[index]),
  ),
)
```

### 3. 内存优化

```dart
// 及时释放资源
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late StreamSubscription _subscription;
  
  @override
  void initState() {
    super.initState();
    _subscription = stream.listen(...);
  }
  
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
```

## 部署指南

### 1. 版本管理

```yaml
# pubspec.yaml
version: 1.0.0+1
#        ^^^^^ ^
#        |     |
#        |     +-- build number
#        +-------- version name
```

### 2. 构建配置

#### Android
```bash
# 生成签名密钥
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

# 配置 android/key.properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=key
storeFile=../key.jks
```

#### iOS
```bash
# 配置 Xcode 项目
open ios/Runner.xcworkspace

# 设置 Bundle Identifier
# 配置签名证书
# 设置版本号
```

### 3. 自动化构建

创建 GitHub Actions 工作流：

```yaml
# .github/workflows/build.yml
name: Build and Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x.x'
      - run: flutter pub get
      - run: flutter packages pub run build_runner build
      - run: flutter test
      - run: flutter build apk --release
      - uses: actions/upload-artifact@v2
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

## 常见问题

### 1. 构建问题

**问题**: `build_runner` 构建失败
```bash
# 解决方案
flutter clean
flutter pub get
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**问题**: 依赖冲突
```bash
# 解决方案
flutter pub deps
flutter pub upgrade
```

### 2. 平台特定问题

**Windows**: 构建失败
```powershell
# 确保安装了 Visual Studio 2022
# 启用 Windows 桌面支持
flutter config --enable-windows-desktop
```

**macOS**: CocoaPods 问题
```bash
# 更新 CocoaPods
sudo gem install cocoapods
cd ios && pod repo update && pod install
```

**Linux**: 缺少依赖
```bash
# 安装必需的系统依赖
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

### 3. 运行时问题

**问题**: API 连接失败
- 检查 `.env` 文件中的 API Key
- 验证网络连接
- 检查代理设置

**问题**: 数据库错误
```bash
# 重新生成数据库代码
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**问题**: 状态管理错误
- 检查 Riverpod 提供者是否正确注册
- 确保在 ProviderScope 内使用
- 重新生成状态管理代码

### 4. 调试技巧

```bash
# 启用详细日志
flutter run --verbose

# 检查设备连接
flutter devices

# 清理并重新构建
flutter clean && flutter pub get && flutter run

# 检查 Flutter 环境
flutter doctor -v
```

### 5. 性能问题

```bash
# 分析性能
flutter run --profile

# 检查包大小
flutter build apk --analyze-size

# 启用性能监控
flutter run --trace-startup
```

## 最佳实践

### 1. 代码组织
- 按功能模块组织代码
- 使用 barrel exports
- 保持文件大小适中 (< 500 行)

### 2. 状态管理
- 使用 Riverpod 进行状态管理
- 避免过度使用全局状态
- 合理使用 Provider 作用域

### 3. 性能
- 使用 const 构造函数
- 避免不必要的重建
- 合理使用 ListView.builder

### 4. 测试
- 编写单元测试
- 使用 Widget 测试验证 UI
- 保持测试覆盖率 > 80%

### 5. 文档
- 为公共 API 编写文档注释
- 保持 README 更新
- 记录重要的设计决策

---

如有其他问题，请查看项目 [Issues](https://github.com/your-username/Chat2AI/issues) 或创建新的问题报告。