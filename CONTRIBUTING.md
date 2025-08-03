# 贡献指南

感谢您对 Chat2AI 项目的关注！我们欢迎所有形式的贡献，包括但不限于代码、文档、测试、反馈和建议。

## 目录

- [行为准则](#行为准则)
- [如何贡献](#如何贡献)
- [开发环境搭建](#开发环境搭建)
- [代码规范](#代码规范)
- [提交规范](#提交规范)
- [Pull Request 流程](#pull-request-流程)
- [问题报告](#问题报告)
- [功能请求](#功能请求)
- [文档贡献](#文档贡献)
- [测试指南](#测试指南)

## 行为准则

### 我们的承诺

为了营造一个开放和友好的环境，我们作为贡献者和维护者承诺，无论年龄、体型、残疾、种族、性别认同和表达、经验水平、国籍、个人形象、种族、宗教或性取向如何，参与我们项目和社区的每个人都能享受无骚扰的体验。

### 我们的标准

**积极行为包括：**
- 使用友好和包容的语言
- 尊重不同的观点和经验
- 优雅地接受建设性批评
- 关注对社区最有利的事情
- 对其他社区成员表示同理心

**不可接受的行为包括：**
- 使用性化的语言或图像
- 恶意评论、人身攻击或政治攻击
- 公开或私下骚扰
- 未经明确许可发布他人的私人信息
- 其他在专业环境中可能被认为不当的行为

## 如何贡献

### 贡献类型

1. **代码贡献**
   - 修复 Bug
   - 添加新功能
   - 性能优化
   - 重构代码

2. **文档贡献**
   - 改进现有文档
   - 添加新的文档
   - 翻译文档
   - 修复文档中的错误

3. **测试贡献**
   - 编写单元测试
   - 编写集成测试
   - 改进测试覆盖率
   - 性能测试

4. **设计贡献**
   - UI/UX 设计
   - 图标设计
   - 用户体验改进

5. **其他贡献**
   - 报告 Bug
   - 提出功能请求
   - 代码审查
   - 社区支持

## 开发环境搭建

### 1. 前置要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 2.19.6
- Git
- IDE (VS Code 或 Android Studio)

### 2. 克隆项目

```bash
# Fork 项目到您的 GitHub 账号
# 然后克隆您的 Fork
git clone https://github.com/YOUR_USERNAME/Chat2AI.git
cd Chat2AI

# 添加上游仓库
git remote add upstream https://github.com/original-owner/Chat2AI.git
```

### 3. 安装依赖

```bash
flutter pub get
```

### 4. 环境配置

```bash
# 复制环境变量模板
cp .env.example .env

# 编辑 .env 文件，添加您的 API Key
```

### 5. 生成代码

```bash
flutter packages pub run build_runner build
```

### 6. 运行项目

```bash
flutter run
```

详细的开发环境搭建请参考 [DEVELOPMENT.md](DEVELOPMENT.md)。

## 代码规范

### 1. Dart 代码规范

我们遵循 [Dart 官方代码规范](https://dart.dev/guides/language/effective-dart)。

**基本规则：**

```dart
// ✅ 好的示例
class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });

  /// Creates a copy of this message with the given fields replaced
  ChatMessage copyWith({
    String? id,
    String? content,
    bool? isUser,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

// ❌ 不好的示例
class chatmessage {
  var id;
  var content;
  var isuser;
  var timestamp;
  
  chatmessage(this.id, this.content, this.isuser, this.timestamp);
}
```

### 2. 命名规范

- **类名**: PascalCase (`ChatMessage`, `UserService`)
- **变量名**: camelCase (`userName`, `messageList`)
- **常量**: lowerCamelCase (`defaultTimeout`, `maxRetries`)
- **文件名**: snake_case (`chat_message.dart`, `user_service.dart`)
- **文件夹名**: snake_case (`chat_ui`, `user_management`)

### 3. 注释规范

```dart
/// Service for handling ChatGPT API interactions
/// 
/// This service provides methods to send messages to ChatGPT
/// and receive streaming responses.
class ChatGPTService {
  /// Sends a chat message and returns a streaming response
  /// 
  /// [messages] - List of messages in the conversation
  /// [model] - The GPT model to use (default: gpt-3.5-turbo)
  /// [onSuccess] - Callback for successful response chunks
  /// [cancellationToken] - Token to cancel the request
  /// 
  /// Returns a [Future] that completes when the stream ends
  Future<void> streamChat(
    List<Message> messages, {
    String model = Models.gpt3_5Turbo,
    Function(String text)? onSuccess,
    CancellationToken? cancellationToken,
  }) async {
    // Implementation
  }
}
```

### 4. 代码组织

```dart
// 导入顺序：
// 1. Dart 核心库
import 'dart:async';
import 'dart:convert';

// 2. Flutter 库
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. 第三方包
import 'package:riverpod/riverpod.dart';
import 'package:openai_api/openai_api.dart';

// 4. 项目内部导入
import '../models/message.dart';
import '../services/chatgpt.dart';
import 'chat_input.dart';
```

### 5. Widget 规范

```dart
/// A widget that displays a chat message
class ChatMessageWidget extends StatelessWidget {
  /// The message to display
  final Message message;
  
  /// Callback when the message is tapped
  final VoidCallback? onTap;
  
  /// Creates a chat message widget
  const ChatMessageWidget({
    super.key,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 8),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          message.isUser ? Icons.person : Icons.smart_toy,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          message.isUser ? 'You' : 'AI',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Text(message.content);
  }
}
```

### 6. 代码检查

提交前请运行：

```bash
# 代码分析
flutter analyze

# 代码格式化
flutter format .

# 运行测试
flutter test
```

## 提交规范

我们使用 [Conventional Commits](https://www.conventionalcommits.org/) 规范。

### 提交消息格式

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### 提交类型

- **feat**: 新功能
- **fix**: Bug 修复
- **docs**: 文档更改
- **style**: 代码格式更改（不影响代码逻辑）
- **refactor**: 代码重构
- **perf**: 性能优化
- **test**: 添加或修改测试
- **chore**: 构建过程或辅助工具的变动
- **ci**: CI/CD 相关更改
- **build**: 构建系统或外部依赖的更改

### 提交示例

```bash
# 新功能
git commit -m "feat(chat): add voice input support"

# Bug 修复
git commit -m "fix(api): handle network timeout errors"

# 文档更新
git commit -m "docs: update installation guide"

# 重构
git commit -m "refactor(ui): extract chat message component"

# 性能优化
git commit -m "perf(rendering): optimize message list rendering"

# 测试
git commit -m "test(chat): add unit tests for message service"

# 构建相关
git commit -m "chore: update dependencies"
```

### 详细提交示例

```
feat(chat): add real-time message streaming

Implement WebSocket-based streaming for real-time chat responses.
This improves user experience by showing responses as they are generated.

- Add WebSocket connection management
- Implement message streaming protocol
- Add error handling for connection failures
- Update UI to display streaming messages

Closes #123
```

## Pull Request 流程

### 1. 创建分支

```bash
# 确保主分支是最新的
git checkout main
git pull upstream main

# 创建新分支
git checkout -b feature/your-feature-name
# 或
git checkout -b fix/bug-description
```

### 2. 开发和测试

```bash
# 进行开发
# ...

# 运行测试
flutter test

# 代码检查
flutter analyze

# 格式化代码
flutter format .
```

### 3. 提交更改

```bash
git add .
git commit -m "feat: add new feature"
```

### 4. 推送分支

```bash
git push origin feature/your-feature-name
```

### 5. 创建 Pull Request

1. 访问您的 GitHub Fork
2. 点击 "Compare & pull request"
3. 填写 PR 模板
4. 提交 Pull Request

### 6. PR 模板

```markdown
## 描述

简要描述此 PR 的更改内容。

## 更改类型

- [ ] Bug 修复
- [ ] 新功能
- [ ] 重构
- [ ] 文档更新
- [ ] 性能优化
- [ ] 测试
- [ ] 其他（请说明）

## 测试

- [ ] 单元测试通过
- [ ] 集成测试通过
- [ ] 手动测试完成
- [ ] 添加了新的测试

## 检查清单

- [ ] 代码遵循项目规范
- [ ] 自我审查了代码
- [ ] 添加了必要的注释
- [ ] 更新了相关文档
- [ ] 没有引入新的警告
- [ ] 添加了测试覆盖新功能
- [ ] 所有测试都通过

## 相关 Issue

Closes #(issue number)

## 截图（如适用）

添加截图来展示更改效果。

## 额外说明

添加任何其他相关信息。
```

### 7. 代码审查

- 维护者会审查您的代码
- 根据反馈进行修改
- 所有检查通过后会合并

## 问题报告

### 报告 Bug

使用 [Bug 报告模板](https://github.com/your-username/Chat2AI/issues/new?template=bug_report.md)：

```markdown
**Bug 描述**
简要描述 Bug 的现象。

**重现步骤**
1. 进入 '...'
2. 点击 '....'
3. 滚动到 '....'
4. 看到错误

**期望行为**
描述您期望发生的行为。

**实际行为**
描述实际发生的行为。

**截图**
如果适用，添加截图来帮助解释问题。

**环境信息**
- 操作系统: [例如 Windows 11]
- Flutter 版本: [例如 3.16.0]
- 应用版本: [例如 1.0.0]

**额外信息**
添加任何其他相关信息。
```

### 报告安全问题

如果您发现安全漏洞，请不要在公开的 Issue 中报告。请发送邮件到 security@example.com。

## 功能请求

使用 [功能请求模板](https://github.com/your-username/Chat2AI/issues/new?template=feature_request.md)：

```markdown
**功能描述**
简要描述您希望添加的功能。

**问题背景**
描述这个功能要解决的问题。

**解决方案**
描述您希望的解决方案。

**替代方案**
描述您考虑过的其他解决方案。

**额外信息**
添加任何其他相关信息或截图。
```

## 文档贡献

### 文档类型

- **README.md**: 项目概述和快速开始
- **DEVELOPMENT.md**: 开发指南
- **DEPLOYMENT.md**: 部署指南
- **API 文档**: 代码注释生成的 API 文档
- **用户指南**: 用户使用说明

### 文档规范

1. **使用 Markdown 格式**
2. **保持简洁明了**
3. **添加代码示例**
4. **包含截图（如适用）**
5. **保持更新**

### 文档结构

```markdown
# 标题

简要描述文档内容。

## 目录

- [章节1](#章节1)
- [章节2](#章节2)

## 章节1

内容...

### 子章节

内容...

```bash
# 代码示例
command example
```

## 章节2

内容...
```

## 测试指南

### 测试类型

1. **单元测试**: 测试单个函数或类
2. **Widget 测试**: 测试 UI 组件
3. **集成测试**: 测试完整的用户流程

### 编写测试

```dart
// test/services/chatgpt_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:chatgpt/services/chatgpt.dart';

void main() {
  group('ChatGPTService', () {
    late ChatGPTService service;
    
    setUp(() {
      service = ChatGPTService();
    });
    
    test('should send chat message successfully', () async {
      // Arrange
      const message = 'Hello, world!';
      
      // Act
      final response = await service.sendChat(message);
      
      // Assert
      expect(response, isNotNull);
      expect(response.choices, isNotEmpty);
    });
    
    test('should handle API errors gracefully', () async {
      // Test error handling
    });
  });
}
```

### 运行测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/services/chatgpt_service_test.dart

# 运行测试并生成覆盖率报告
flutter test --coverage

# 查看覆盖率报告
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 测试最佳实践

1. **测试命名要清晰**
2. **使用 AAA 模式** (Arrange, Act, Assert)
3. **每个测试只测试一个功能点**
4. **使用 Mock 隔离依赖**
5. **保持测试简单**
6. **添加边界条件测试**

## 发布流程

### 版本号规范

我们使用 [语义化版本](https://semver.org/)：

- **主版本号**: 不兼容的 API 修改
- **次版本号**: 向下兼容的功能性新增
- **修订号**: 向下兼容的问题修正

### 发布检查清单

- [ ] 所有测试通过
- [ ] 代码审查完成
- [ ] 文档更新
- [ ] CHANGELOG.md 更新
- [ ] 版本号更新
- [ ] 创建发布标签
- [ ] 构建和测试所有平台
- [ ] 发布到应用商店（如适用）

## 社区

### 沟通渠道

- **GitHub Issues**: 报告问题和功能请求
- **GitHub Discussions**: 一般讨论和问答
- **Discord**: 实时聊天（如果有）
- **邮件**: 重要通知和安全问题

### 获得帮助

1. **查看文档**: 首先查看项目文档
2. **搜索 Issues**: 看看是否有人遇到过类似问题
3. **创建 Issue**: 如果找不到答案，创建新的 Issue
4. **参与讨论**: 在 GitHub Discussions 中提问

## 致谢

感谢所有为 Chat2AI 项目做出贡献的开发者！

### 贡献者

- [贡献者列表](https://github.com/your-username/Chat2AI/graphs/contributors)

### 特别感谢

- Flutter 团队
- OpenAI
- 所有开源库的维护者
- 社区成员的反馈和建议

---

再次感谢您的贡献！如果您有任何问题，请随时联系我们。