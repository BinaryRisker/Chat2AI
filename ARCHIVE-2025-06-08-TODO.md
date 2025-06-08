# 项目改进待办事项 (归档于 2025-06-08)

## 优先级 1: 文档与代码同步

- [x] **更新 `README.md`**: 重写后端相关的 "技术架构" 和 "技术选型" 部分，使其与当前基于 JavaScript, Express.js 和 Mongoose 的实现保持一致。

## 优先级 2: 后端重构

- [x] **引入 `src` 目录**: 在 `server` 目录下创建 `src` 目录，并将所有应用源代码（routes, models, services, middleware 等）移入其中。
- [x] **创建 Controller 层**: 将 Express 路由处理函数中的业务逻辑（如数据库查询）抽离到独立的 Controller 文件中。
- [x] **修复模块导入**: 确保所有文件都显式 `require` 导入所依赖的模块（例如在 `routes/chat.js` 中导入 `Conversation` 模型）。
- [x] **完善数据库连接**: 在 `server/app.js` 或一个专门的配置文件中，添加并管理 Mongoose 的数据库连接逻辑。

## 优先级 3: 前端改进

- [x] **升级 HTTP 客户端**: 在 `pubspec.yaml` 中将 `http` 包替换为 `dio` 包。
- [x] **重构 `ApiService`**: 使用 `Dio` 及其拦截器（Interceptor）重写 `ApiService`，以自动处理认证 Token 和其他公共请求头，简化代码。

## 优先级 4: 战略规划

- [x] **明确并记录长期技术栈**: 决策项目后端是继续使用 JavaScript/Mongoose，还是逐步演进到 `README.md` 中最初设想的 TypeScript/Prisma 架构，并在文档中明确记录此决策。 