# API 模块规范

这个文件会覆盖根目录 CLAUDE.md 中对 `/src/api/` 下所有内容生效的配置。

## API 专属规范

### 请求校验
- 使用 Zod 做 schema 校验
- 所有输入都必须校验
- 校验失败时返回 400
- 返回字段级别的错误详情

### 认证
- 所有 endpoint 都要求 JWT token
- Token 放在 Authorization header 中
- Token 24 小时后过期
- 实现 refresh token 机制

### 响应格式

所有响应都必须遵循以下结构：

```json
{
  "success": true,
  "data": { /* actual data */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

错误响应：
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "User message",
    "details": { /* field errors */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### 分页
- 使用基于 cursor 的分页，而不是 offset
- 返回 `hasMore` 布尔值
- 单页最大大小限制为 100
- 默认分页大小：20

### 限流
- 已认证用户每小时 1000 次请求
- 公开 endpoint 每小时 100 次请求
- 超出限制时返回 429
- 返回 `retry-after` header

### 缓存
- 使用 Redis 做 session 缓存
- 默认缓存时长：5 分钟
- 写操作时主动失效缓存
- 缓存 key 需要带上资源类型标签
