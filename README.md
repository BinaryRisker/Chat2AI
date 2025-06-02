# Chat2AI
跨平台AI聊天工具，支持多种大模型

## 项目概述
一个跨平台的AI聊天UI工具，包含前后端完整实现：
- 前端：Flutter实现，支持iOS/Android/Web/桌面端
- 后端：Node.js实现，提供API服务
- 核心功能：多模型支持、用户管理、聊天历史记录

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
│   ├── api_service.dart  # 基础API服务
│   ├── chat_service.dart # 聊天服务
│   └── auth_service.dart # 认证服务
├── stores/                # 状态管理
│   ├── chat_store.dart   # 聊天状态
│   ├── user_store.dart   # 用户状态
│   └── theme_store.dart  # 主题状态
├── utils/                 # 工具类
│   ├── constants.dart   # 常量定义
│   ├── extensions.dart  # 扩展方法
│   └── logger.dart      # 日志工具
└── views/                 # 页面组件
    ├── screens/         # 页面
    │   ├── chat_screen.dart
    │   ├── auth_screen.dart
    │   └── settings_screen.dart
    └── widgets/         # 组件
        ├── message_bubble.dart
        └── model_selector.dart
```

#### 后端架构 (Node.js)
```
src/
├── config/                # 配置文件
│   ├── app.config.ts     # 应用配置
│   └── db.config.ts     # 数据库配置
├── controllers/           # 业务逻辑
│   ├── chat.controller.ts
│   ├── auth.controller.ts
│   └── user.controller.ts
├── middleware/            # 中间件
│   ├── auth.middleware.ts
│   └── error.middleware.ts
├── models/                # 数据库模型
│   ├── chat.model.ts
│   ├── user.model.ts
│   └── index.ts
├── routes/                # API路由
│   ├── chat.routes.ts
│   ├── auth.routes.ts
│   └── index.ts
└── services/              # 核心服务
    ├── ai/               # AI服务
    │   ├── openai.service.ts
    │   └── claude.service.ts
    ├── chat.service.ts   # 聊天服务
    └── auth.service.ts   # 认证服务
```

## 技术选型

### 前端技术栈
- **框架**: Flutter 3.x (跨平台支持)
- **状态管理**: Riverpod (轻量级响应式状态管理)
- **UI组件**: 官方Material/Cupertino组件 + 自定义主题
- **网络请求**: Dio (支持拦截器和缓存)
- **本地存储**: Hive (高性能NoSQL数据库)

### 后端技术栈
- **运行时**: Node.js 18+ LTS
- **框架**: Express.js (轻量级Web框架)
- **ORM**: Prisma (类型安全的数据库访问)
- **认证**: JWT + OAuth2.0
- **API文档**: Swagger UI

### 数据库
- **开发环境**: SQLite (嵌入式数据库)
- **生产环境**: PostgreSQL (关系型数据库)
- **缓存**: Redis (可选，用于会话管理)

### DevOps
- **容器化**: Docker + Docker Compose
- **CI/CD**: GitHub Actions
- **监控**: Prometheus + Grafana (可选)

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

## 开发计划

### 第一阶段：基础架构 (2周)
1. **前端基础**
   - 搭建Flutter项目结构
   - 实现基础路由和导航
   - 创建核心UI组件库

2. **后端基础**
   - 初始化Node.js项目
   - 配置Express基础路由
   - 设置Prisma数据库连接

3. **基础功能**
   - 实现简单聊天界面
   - 完成基础API通信
   - 配置开发环境

### 第二阶段：核心功能 (4周)
1. **多模型支持**
   - OpenAI API集成
   - Claude API集成
   - 可扩展的模型接口设计

2. **用户系统**
   - JWT认证实现
   - 用户注册/登录流程
   - 权限管理系统

3. **数据管理**
   - 本地聊天记录存储
   - 消息标记/收藏功能
   - 数据导出功能

### 第三阶段：高级功能 (4周)
1. **搜索与组织**
   - 全文搜索实现
   - 对话分类和标签
   - 智能消息过滤

2. **个性化**
   - 多主题支持
   - 用户偏好设置
   - 自定义模型参数

3. **同步与部署**
   - 跨设备同步功能
   - CI/CD流水线
   - 生产环境部署

### 第四阶段：测试与优化 (2周)
1. 单元测试和集成测试
2. 性能优化
3. 用户体验改进
4. 文档完善
