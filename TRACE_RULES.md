# 追踪系统规则文档

## 1. 追踪系统概述

### 1.1 目的
- 提供端到端的请求追踪能力
- 支持跨服务调用链分析
- 监控系统性能和异常

### 1.2 核心概念
- **Trace ID**: 全局唯一标识符，贯穿整个请求生命周期
- **Span**: 单个服务或组件的工作单元
- **Parent Span**: 调用方的Span上下文
- **Tags**: 附加的元数据信息

## 2. 追踪规则

### 2.1 Trace ID生成规则
- 格式: `[服务前缀]-[时间戳]-[随机字符串]`
  - 示例: `chat2ai-1698765432100-abc123def456`
- 生成时机: 在请求入口处生成
- 传播方式: 通过HTTP头`X-Trace-ID`传递

### 2.2 Span记录规则

#### 2.2.1 必须记录的Span属性
```json
{
  "traceId": "string",
  "spanId": "string",
  "parentSpanId": "string|null",
  "name": "string",
  "kind": "enum(SERVER|CLIENT|PRODUCER|CONSUMER|INTERNAL)",
  "timestamp": "number",
  "duration": "number",
  "status": {
    "code": "enum(OK|ERROR)",
    "message": "string|null"
  }
}
```

#### 2.2.2 推荐记录的Tags
- `http.method`: HTTP请求方法
- `http.path`: 请求路径
- `http.status_code`: 响应状态码
- `db.system`: 数据库类型
- `db.statement`: SQL语句摘要
- `error.message`: 错误信息

### 2.3 采样规则
- **开发环境**: 100%采样
- **测试环境**: 50%采样
- **生产环境**: 10%采样（可动态调整）

## 3. 实现指南

### 3.1 前端实现
1. 在API请求拦截器中自动添加Trace ID
2. 记录关键用户交互事件
3. 捕获并上报前端错误

### 3.2 后端实现
1. 使用OpenTelemetry SDK
2. 配置自动化的HTTP/RPC拦截
3. 集成数据库查询追踪

## 4. 存储与可视化

### 4.1 存储要求
- 保留期限: 生产环境30天
- 存储格式: JSON/Protobuf

### 4.2 可视化方案
- **Jaeger**: 分布式追踪UI
- **Grafana**: 监控仪表盘
- **Prometheus**: 指标存储

## 5. 性能考虑
- 异步上报机制
- 批量发送策略
- 本地缓存降级方案