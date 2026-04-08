# 检查点示例

下面是一些在 Claude Code 中高效使用检查点的真实场景示例。

注意：每次用户输入时都会自动创建检查点。你不需要手动保存。要执行回退，请连续按两次 `Esc`（`Esc+Esc`），或使用 `/rewind` 打开检查点浏览器。

## 示例 1：数据库迁移

### 场景
你需要从 MySQL 迁移到 PostgreSQL，但希望同时探索“直接迁移”和“逐步双写”两种方案。

### 工作流

```
User: Let's implement a direct migration from MySQL to PostgreSQL
      [自动创建检查点 A]

Claude: 我来实现直接迁移……
[切换数据库驱动、更新查询、修改 schema]

User: Run the tests
      [自动创建检查点 B]

Claude: 正在运行测试……
❌ 15 个测试失败 - 连接池有问题

User: This approach has issues. Let's try the dual-write pattern instead.
[用户按下 Esc+Esc，选择检查点 A，并选择 "Restore code and conversation"]

User: Now implement a dual-write pattern where we write to both databases

Claude: 我来实现双写迁移……
[实现双写层和渐进式迁移策略]

User: Run the tests

Claude: 正在运行测试……
✅ 所有测试通过

User: The dual-write approach is clearly safer. Let's commit this.
```

## 示例 2：性能优化

### 场景
你有多种性能优化策略想分别试一遍。

### 工作流

```
User: Let's optimize the API response time. Current: 450ms
      [自动创建名为 "Baseline" 的检查点]

Claude: 我来加入数据库查询缓存……
[实现 Redis 缓存]

User: Run performance tests

Claude: 结果：平均响应时间 280ms（提升 38%）

User: Let me try a different approach.
[用户按下 Esc+Esc，选择 "Baseline" 检查点，并选择 "Restore code and conversation"]

User: Try database query optimization instead

Claude: 我来优化数据库查询……
[添加索引，优化 N+1 查询]

User: Run performance tests

Claude: 结果：平均响应时间 180ms（提升 60%）

User: Let me also try a third approach.
[用户按下 Esc+Esc，选择 "Baseline" 检查点，并选择 "Restore code and conversation"]

User: Try response compression and CDN

Claude: 我来加入压缩和 CDN……
[实现 gzip，配置 CDN]

User: Run performance tests

Claude: 结果：平均响应时间 320ms（提升 29%）

User: Query optimization was the best. Let me go back and combine it with caching.
[用户按下 Esc+Esc，选择查询优化之后的检查点，并选择 "Restore code and conversation"]

User: Now add Redis caching on top of these optimized queries

Claude: [在已优化的查询基础上加入 Redis 缓存]

User: Run performance tests

Claude: 结果：平均响应时间 95ms（提升 79%）🎉

User: Perfect! This is the winner. Let's commit this.
```

## 示例 3：UI/UX 迭代

### 场景
你正在为仪表盘尝试不同的布局方案。

### 工作流

```
User: Let's redesign the dashboard with a sidebar layout
      [自动创建名为 "Start" 的检查点]

Claude: [实现侧边栏布局]

User: Show me a screenshot

Claude: [展示截图]

User: The sidebar feels cramped. Let's try a top navigation instead.
[用户按下 Esc+Esc，选择 "Start" 检查点，并选择 "Restore code and conversation"]

User: Try a top navigation layout

Claude: [实现顶部导航布局]

User: Show me a screenshot

Claude: [展示截图]

User: Better, but let's try a card-based grid layout
[用户按下 Esc+Esc，选择 "Start" 检查点，并选择 "Restore code and conversation"]

User: Try a card-based grid layout

Claude: [实现卡片式网格布局]

User: Show me a screenshot

Claude: [展示截图]

User: This is great! But can we combine the top nav with the card grid?
[用户按下 Esc+Esc，选择卡片网格布局后的检查点，并选择 "Restore code and conversation"]

User: Add top navigation to the card grid layout

Claude: [给卡片网格布局加入顶部导航]

User: Perfect! This is the final design.
```

## 示例 4：调试会话

### 场景
你正在追查一个棘手的 bug，并且手上有多个可能的假设。

### 工作流

```
User: There's a memory leak in the application
      [自动创建名为 "Before debugging" 的检查点]

Claude: 让我先调查一下……
[分析代码]

User: I think it's in the event listeners. Let's fix those.

Claude: [修复事件监听器的清理逻辑]

User: Run memory profiler

Claude: 还是有内存泄漏 - 问题不在事件监听器

User: Let me go back and try a different hypothesis.
[用户按下 Esc+Esc，选择 "Before debugging" 检查点，并选择 "Restore code and conversation"]

User: Maybe it's the database connections?

Claude: [实现数据库连接池修复]

User: Run memory profiler

Claude: 还是泄漏 - 也不是数据库连接的问题

User: Let me go back and try another angle.
[用户按下 Esc+Esc，选择 "Before debugging" 检查点，并选择 "Restore code and conversation"]

User: Let's check for circular references

Claude: [找到并修复缓存层中的循环引用]

User: Run memory profiler

Claude: ✅ 内存泄漏已修复！罪魁祸首是缓存层中的循环引用。

User: Excellent! Let's commit this fix.
```

## 示例 5：API 设计演进

### 场景
你要为一个博客平台设计 REST API，并希望通过多轮迭代比较方案。

### 工作流

```
User: Create a REST API for our blog platform
      [自动创建名为 "Before API design" 的检查点]

Claude: [创建基础 CRUD API]

User: This is too simple. Let's add pagination and filtering

Claude: [加入分页和过滤]

User: We need better resource relationships

Claude: [实现 HATEOAS 链接]

User: Actually, let's try GraphQL instead of REST
[用户按下 Esc+Esc，选择 "Before API design" 检查点，并选择 "Restore code and conversation"]

User: Implement a GraphQL API for our blog platform instead

Claude: [实现 GraphQL API]

User: I think REST is better for our use case.
[用户按下 Esc+Esc，选择 HATEOAS 之后的检查点，并选择 "Restore code and conversation"]

User: Let's finalize the REST approach.
```

## 示例 6：配置管理

### 场景
你要测试不同的配置管理方案。

### 工作流

```
User: Move configuration to environment variables
      [自动创建名为 "Original config" 的检查点]

Claude: [实现基于环境变量的配置]

User: Test in development

Claude: 本地运行正常，但生产部署出现问题

User: Let me try a different approach.
[用户按下 Esc+Esc，选择 "Original config" 检查点，并选择 "Restore code and conversation"]

User: Try a config file approach with validation

Claude: [实现带 JSON schema 校验的 YAML 配置]

User: Test in development

Claude: ✅ 效果很好，校验错误也很清晰

User: Can we also support env vars for sensitive values?

Claude: [为敏感配置加入环境变量覆盖能力]
```
