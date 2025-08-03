# Chat2AI

一个基于 Flutter 开发的跨平台 ChatGPT 客户端应用，支持桌面端和移动端，提供现代化的聊天界面和丰富的功能。

## 功能特性

### 🚀 核心功能
- **多平台支持**: 支持 Windows、macOS、Linux、iOS、Android 和 Web
- **ChatGPT 集成**: 完整的 OpenAI API 集成，支持多种 GPT 模型
- **流式对话**: 实时流式响应，提供流畅的对话体验
- **会话管理**: 支持多会话管理，历史记录保存
- **Markdown 渲染**: 完整的 Markdown 支持，包括 LaTeX 数学公式渲染

### 🎨 用户体验
- **响应式设计**: 桌面端和移动端优化的不同界面布局
- **主题切换**: 支持明亮、暗黑和跟随系统主题
- **国际化**: 支持中文和英文界面
- **语音输入**: 集成语音识别功能
- **消息导出**: 支持聊天记录导出和分享

### ⚙️ 高级配置
- **自定义 API 端点**: 支持自定义 OpenAI API 服务器地址
- **代理支持**: 支持 HTTP 代理配置
- **模型选择**: 支持多种 GPT 模型切换
- **本地数据库**: 使用 Floor 数据库本地存储聊天记录

## 技术栈

### 前端框架
- **Flutter**: 跨平台 UI 框架
- **Hooks Riverpod**: 状态管理和依赖注入
- **Go Router**: 路由管理
- **Floor**: 本地数据库 ORM

### 核心依赖
- **openai_api**: OpenAI API 客户端
- **markdown_widget**: Markdown 渲染
- **flutter_math_fork**: LaTeX 数学公式渲染
- **flutter_tiktoken**: Token 计算
- **record**: 语音录制
- **bitsdojo_window**: 桌面端窗口管理

### 开发工具
- **Freezed**: 数据类生成
- **Riverpod Generator**: 状态管理代码生成
- **Floor Generator**: 数据库代码生成
- **Envied**: 环境变量管理

## 项目结构

```
lib/
├── data/                   # 数据层
│   ├── converter/         # 数据转换器
│   ├── dao/              # 数据访问对象
│   └── database.dart     # 数据库配置
├── l10n/                  # 国际化文件
│   ├── app_en.arb        # 英文语言包
│   └── app_zh.arb        # 中文语言包
├── markdown/              # Markdown 相关
│   ├── code_wrapper.dart # 代码块包装器
│   └── latex.dart        # LaTeX 渲染
├── models/                # 数据模型
│   ├── message.dart      # 消息模型
│   └── session.dart      # 会话模型
├── services/              # 服务层
│   ├── chatgpt.dart      # ChatGPT 服务
│   ├── export.dart       # 导出服务
│   ├── local_store.dart  # 本地存储服务
│   └── record.dart       # 录音服务
├── shortcuts/             # 快捷键
│   ├── actions.dart      # 快捷键动作
│   └── intents.dart      # 快捷键意图
├── states/                # 状态管理
│   ├── chat_ui_state.dart    # 聊天界面状态
│   ├── message_state.dart    # 消息状态
│   ├── session_state.dart    # 会话状态
│   └── settings_state.dart   # 设置状态
├── tools/                 # 工具类
│   ├── error.dart        # 错误处理
│   ├── files.dart        # 文件操作
│   └── share.dart        # 分享功能
├── widgets/               # UI 组件
│   ├── chat_gpt_model_widget.dart  # 模型选择组件
│   ├── chat_history.dart           # 聊天历史组件
│   ├── chat_input.dart             # 聊天输入组件
│   ├── chat_message_list.dart      # 消息列表组件
│   ├── chat_screen.dart            # 聊天界面
│   ├── desktop.dart               # 桌面端组件
│   ├── home_screen.dart           # 主界面
│   ├── settings_screen.dart       # 设置界面
│   └── typing_cursor.dart         # 打字光标效果
├── colors.dart            # 颜色定义
├── env.dart              # 环境变量
├── injection.dart        # 依赖注入
├── intl.dart            # 国际化配置
├── main.dart            # 应用入口
├── router.dart          # 路由配置
├── theme.dart           # 主题配置
└── utils.dart           # 工具函数
```

## 开发环境要求

### 系统要求
- **Flutter SDK**: >= 3.0.0
- **Dart SDK**: >= 2.19.6 < 3.0.0
- **操作系统**: Windows 10+, macOS 10.14+, Linux (Ubuntu 18.04+)

### 开发工具
- **IDE**: VS Code 或 Android Studio (推荐安装 Flutter 插件)
- **Git**: 版本控制
- **Node.js**: (可选，用于某些构建工具)

## 快速开始

### 1. 克隆项目

```bash
git clone https://github.com/your-username/Chat2AI.git
cd Chat2AI
```

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 环境配置

在项目根目录创建 `.env` 文件：

```env
# OpenAI API 密钥 (必需)
OPENAI_API_KEY=your_openai_api_key_here

# HTTP 代理 (可选)
HTTP_PROXY=

# 自定义 API 基础 URL (可选)
BASE_URL=
```

### 4. 生成代码

```bash
# 生成数据库、状态管理和序列化代码
flutter packages pub run build_runner build

# 如果需要清理后重新生成
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 5. 运行应用

#### 桌面端 (Windows/macOS/Linux)
```bash
flutter run -d windows  # Windows
flutter run -d macos    # macOS
flutter run -d linux    # Linux
```

#### 移动端
```bash
flutter run -d android  # Android
flutter run -d ios      # iOS (需要 macOS 和 Xcode)
```

#### Web 端
```bash
flutter run -d chrome
```

## 构建发布版本

### 桌面端

#### Windows
```bash
flutter build windows --release
```
构建产物位于: `build/windows/runner/Release/`

#### macOS
```bash
flutter build macos --release
```
构建产物位于: `build/macos/Build/Products/Release/`

#### Linux
```bash
flutter build linux --release
```
构建产物位于: `build/linux/x64/release/bundle/`

### 移动端

#### Android APK
```bash
flutter build apk --release
```
构建产物位于: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle
```bash
flutter build appbundle --release
```
构建产物位于: `build/app/outputs/bundle/release/app-release.aab`

#### iOS
```bash
flutter build ios --release
```
需要在 Xcode 中进一步配置和构建

### Web 端
```bash
flutter build web --release
```
构建产物位于: `build/web/`

## 开发指南

### 代码生成

项目使用多个代码生成器，开发时需要运行：

```bash
# 监听文件变化并自动生成代码
flutter packages pub run build_runner watch

# 一次性生成所有代码
flutter packages pub run build_runner build
```

### 国际化

添加新的翻译文本：

1. 在 `lib/l10n/app_en.arb` 和 `lib/l10n/app_zh.arb` 中添加新的键值对
2. 运行 `flutter gen-l10n` 生成国际化代码
3. 在代码中使用 `AppIntl.of(context).yourKey`

### 数据库迁移

修改数据模型后：

1. 更新 `lib/models/` 中的模型文件
2. 在 `lib/data/database.dart` 中添加新的迁移
3. 增加数据库版本号
4. 运行代码生成

### 状态管理

使用 Riverpod 进行状态管理：

```dart
// 创建状态提供者
@riverpod
class ExampleState extends _$ExampleState {
  @override
  FutureOr<ExampleModel> build() async {
    // 初始化逻辑
  }
  
  // 状态更新方法
}

// 在组件中使用
class ExampleWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exampleStateProvider);
    // 使用状态
  }
}
```

## 配置说明

### API 配置

应用支持以下 API 配置：

- **API Key**: OpenAI API 密钥
- **Base URL**: 自定义 API 服务器地址（支持第三方 API 服务）
- **HTTP Proxy**: 代理服务器配置

### 支持的模型

- GPT-3.5 Turbo
- GPT-4
- GPT-4 Turbo
- GPT-4 Vision Preview

## 故障排除

### 常见问题

1. **构建失败**
   ```bash
   flutter clean
   flutter pub get
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

2. **API 连接问题**
   - 检查 API Key 是否正确
   - 确认网络连接正常
   - 检查代理设置

3. **桌面端窗口问题**
   - 确保安装了必要的系统依赖
   - 检查 `bitsdojo_window` 配置

4. **数据库问题**
   ```bash
   # 重新生成数据库代码
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

### 调试模式

启用详细日志：

```dart
// 在 injection.dart 中
final logger = Logger(level: Level.verbose);
```

## 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

### 代码规范

- 遵循 Dart 官方代码规范
- 使用 `flutter analyze` 检查代码质量
- 添加适当的注释和文档
- 确保所有测试通过

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 致谢

- [Flutter](https://flutter.dev/) - 跨平台 UI 框架
- [OpenAI](https://openai.com/) - AI 模型提供商
- [Riverpod](https://riverpod.dev/) - 状态管理解决方案
- 所有贡献者和开源社区

## 联系方式

如有问题或建议，请通过以下方式联系：

- 创建 [Issue](https://github.com/your-username/Chat2AI/issues)
- 发送邮件至: your-email@example.com
- 加入讨论群: [链接]

---

**注意**: 使用本应用需要有效的 OpenAI API 密钥。请确保遵守 OpenAI 的使用条款和政策。