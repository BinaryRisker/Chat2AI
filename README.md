# Chat2AI
跨平台AI聊天工具，支持多种大模型。目前项目已完成大规模重构，实现了前后端分离的现代化架构，并打通了真实数据链路。

## 项目概述
一个跨平台的AI聊天UI工具，包含前后端完整实现：
- **前端**: Flutter实现，采用分栏式布局，支持iOS/Android/Web/桌面端。
- **后端**: Node.js + Express + Sequelize 实现，提供API服务，使用SQLite数据库。
- **核心功能**:
  - ✅ 真实用户注册与登录 (JWT认证)
  - ✅ 真实会话列表获取与展示
  - ✅ 真实创建会话与发送消息 (后端简单应答)
  - 🚧 (待办) 对接真实AI大模型
  - 🚧 (待办) 完善模型配置与UI细节

## 功能需求

### 核心功能
1. **多AI模型支持**
   - 可配置接入OpenAI、Claude、Gemini等主流大模型
   - 支持自定义API端点
   - 模型参数可调节（温度、top_p等）

2. **用户系统**
   - 邮箱/手机号注册登录
   - JWT身份验证
   - 用户偏好设置存储

3. **聊天功能**
   - 多轮对话上下文管理
   - 消息标记/收藏
   - 对话导出功能

4. **历史记录**
   - 本地存储聊天记录
   - 云端同步（可选）
   - 搜索和过滤功能

### 技术架构

#### 前端架构 (Flutter)
```
lib/
├── models/                # 数据模型
│   ├── chat_model.dart    # 聊天消息模型
│   ├── user_model.dart   # 用户模型
│   └── settings_model.dart # 设置模型
├── services/              # API服务
│   ├── api_service.dart   # 基础API服务
│   ├── chat_service.dart # 聊天服务
│   ├── settings_service.dart
│   └── user_service.dart
├── stores/                # 状态管理 (Riverpod)
│   ├── chat_store.dart    # 聊天状态
│   ├── user_store.dart    # 用户状态
│   └── theme_store.dart   # 主题状态
├── pages/                 # 页面
│   ├── chat_page.dart     # 聊天页面
│   ├── home_page.dart     # 主页
│   ├── login_page.dart    # 登录页
│   ├── register_page.dart # 注册页
│   └── settings_page.dart # 设置页
├── widgets/               # 组件
│   ├── chat_input.dart    # 聊天输入框
│   ├── conversation_list.dart # 会话列表
│   ├── message_bubble.dart # 消息气泡
│   ├── new_chat_button.dart # 新建聊天按钮
│   └── settings_tile.dart # 设置项
├── app.dart               # 应用入口
├── config.dart            # 配置
├── main.dart              # 主文件
├── routes.dart            # 路由配置
└── themes.dart            # 主题配置
```

#### 后端架构 (Node.js - 当前状态)
```
server/
├── src/
│   ├── controllers/       # 业务逻辑层
│   │   ├── auth.js       # 认证控制器
│   │   ├── chat.js       # 聊天控制器
│   │   └── users.js      # 用户控制器
│   ├── middleware/       # 中间件
│   │   ├── auth.js       # 认证中间件
│   │   ├── tracing.js    # 追踪中间件
│   │   └── validation.js # 验证中间件
│   ├── models/           # 数据模型
│   │   ├── conversation.js # 会话模型
│   │   ├── message.js    # 消息模型
│   │   └── user.js       # 用户模型
│   ├── routes/           # API路由
│   │   ├── auth.js       # 认证路由
│   │   ├── chat.js       # 聊天路由
│   │   └── users.js      # 用户路由
│   ├── services/        # 服务层
│   │   ├── ai/          # AI服务
│   │   ├── chat.service.js # 聊天服务
│   │   └── search.service.js # 搜索服务
│   ├── tests/           # 测试
│   │   ├── __mocks__/   # 模拟数据
│   │   ├── ai.service.test.js
│   │   ├── chat.service.test.js
│   │   └── search.service.test.js
│   ├── utils/           # 工具类
│   │   └── trace.js     # 追踪工具
│   ├── validation/      # 验证逻辑
│   │   ├── auth.js     # 认证验证
│   │   ├── chat.js     # 聊天验证
│   │   └── users.js    # 用户验证
│   ├── app.js          # Express应用主文件
│   ├── config.js       # 配置文件
│   ├── db.js          # 数据库连接
│   ├── index.js       # 入口文件
│   └── package.json  # 项目依赖
└── tests/             # 测试
    ├── __mocks__/    # 模拟数据
    ├── ai.service.test.js
    ├── chat.service.test.js
    └── search.service.test.js
```

## 技术选型 (当前实现)

### 前端技术栈
- **框架**: Flutter 3.x
- **状态管理**: Riverpod (`flutter_riverpod`)
- **UI组件**: Material Design
- **网络请求**: `dio` 包

### 后端技术栈
- **运行时**: Node.js 18+
- **框架**: Express.js
- **数据库交互**: Sequelize (多方言 ORM)
- **认证**: JWT (`jsonwebtoken`)
- **密码哈希**: `bcrypt`
- **验证**: `express-validator`
- **主要依赖**: `cors`, `helmet`, `morgan`

### 数据库
- **当前使用**: SQLite (通过 `better-sqlite3` 驱动)

### DevOps
- **容器化**: Docker + Docker Compose
- **CI/CD**: GitHub Actions
- **监控**: Prometheus + Grafana (可选)

## 后续计划 (Next Steps)

当前项目的基础架构和核心数据链路已经搭建完成。接下来的开发重点是实现核心的AI功能并优化用户体验。

### 1. 对接真实AI大模型
- **任务**: 修改后端服务，将当前的消息简单应答逻辑替换为对真实AI模型（如OpenAI, Gemini等）的API调用。
- **步骤**:
  - 在后端 `config.js` 中添加API Key配置。
  - 创建一个 `AIService`，用于封装对不同大模型API的调用。
  - 在 `chat.controller.js` 中调用 `AIService` 获取模型回复。

### 2. 完善前端UI与状态管理
- **任务**: 让前端的UI组件（如模型选择、设置等）与状态和后端真实交互。
- **步骤**:
  - 在 `chat_store.dart` 中添加管理当前AI模型、温度等参数的状态。
  - 实现 `ChatPage` 顶部的模型下拉菜单，使其能动态改变 `chat_store` 中的模型状态。
  - 恢复并完善 `SettingsPage` 的功能，例如主题切换。

### 3. 错误处理与用户反馈
- **任务**: 在前后端增加全面的错误处理机制。
- **步骤**:
  - 在后端API中，为无效请求、数据库错误等增加统一的错误响应。
  - 在前端 `ApiService` 中，使用 `try-catch` 捕获Dio异常。
  - 在UI层，通过 `AsyncValue` 的 `error` 状态或 `Snackbar` 向用户展示清晰的错误信息。

### 4. 代码清理与优化
- **任务**: 移除项目中临时的解决方案和模拟数据。
- **步骤**:
  - 将在 `chat_store.dart` 中临时定义的 `Message` 和 `Conversation` 模型移动到独立的 `models` 文件中。
  - 移除所有剩余的模拟数据和 `print` 语句。

## 环境要求

### 开发环境
- Flutter SDK 3.0+
- Node.js 18+
- Android Studio/Xcode (移动端开发)
- VS Code (推荐IDE)

### 生产环境
- Linux服务器 (推荐Ubuntu 22.04)
- Docker Engine 20.10+
- PostgreSQL 14+
- Nginx (反向代理)

### 本地开发指南

#### 环境准备
1. 安装Node.js 18+和Flutter 3.0+
2. (可选) 安装VS Code等IDE
3. **前端配置**: 修改 `lib/config.dart` 文件中的 `baseUrl`，使其指向你的后端服务器地址。

### 启动后端服务
```bash
cd server
npm install
npm run dev
```

### 启动前端应用
```bash
# 确保在项目根目录
flutter pub get
flutter run
```

### 运行后端测试
``````bash
cd server
npm install
npm test
```

### 运行后端测试
```bash
# 确保在项目根目录
flutter pub get
flutter test
```