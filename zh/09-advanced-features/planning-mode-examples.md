# Planning Mode 示例

下面是一些真实场景示例，用来展示如何在 Claude Code 中高效使用 Planning Mode。

## 示例 1：构建 REST API

### 不使用 Planning Mode

```
User: Build a REST API for a blog

Claude: 我来创建这个 API……
[立刻开始写代码，可能会遗漏需求]
```

### 使用 Planning Mode

```
User: /plan Build a REST API for a blog

Claude: 我先为这个博客 API 制定一份完整计划。

## 博客 REST API 实施计划

### Phase 1: Project Setup (15 min)
1. 用 Express 初始化 Node.js 项目
2. 配置 TypeScript
3. 安装依赖（express, pg, jwt, joi）
4. 配置环境变量
5. 建立项目目录结构

### Phase 2: Database Layer (30 min)
6. 设计数据库 schema
   - users 表（id, email, password_hash, created_at）
   - posts 表（id, user_id, title, content, published, created_at, updated_at）
   - comments 表（id, post_id, user_id, content, created_at）
7. 创建迁移文件
8. 建立数据库连接池
9. 实现数据库模型

### Phase 3: Authentication (45 min)
10. 实现用户注册端点
11. 实现带 JWT 的登录端点
12. 创建认证中间件
13. 使用 bcrypt 加入密码哈希
14. 实现 token 刷新逻辑

### Phase 4: Posts API (40 min)
15. GET /api/posts - 列出所有已发布文章（含分页）
16. GET /api/posts/:id - 获取单篇文章
17. POST /api/posts - 创建新文章（需要认证）
18. PUT /api/posts/:id - 更新文章（需要认证，并检查归属）
19. DELETE /api/posts/:id - 删除文章（需要认证，并检查归属）
20. GET /api/users/:id/posts - 获取某个用户的文章

### Phase 5: Comments API (30 min)
21. GET /api/posts/:id/comments - 获取文章评论
22. POST /api/posts/:id/comments - 添加评论（需要认证）
23. DELETE /api/comments/:id - 删除评论（需要认证，并检查归属）

### Phase 6: Validation & Error Handling (30 min)
24. 使用 Joi 加入请求校验
25. 实现全局错误处理器
26. 加入输入清洗
27. 实现限流

### Phase 7: Testing (60 min)
28. 为模型编写单元测试
29. 为认证端点编写集成测试
30. 为文章端点编写集成测试
31. 为评论端点编写集成测试
32. 达到 80% 以上代码覆盖率

### Phase 8: Documentation & Deployment (30 min)
33. 使用 Swagger 生成 API 文档
34. 编写包含安装说明的 README
35. 添加 Docker 配置
36. 配置 CI/CD 流水线

**Estimated Time**: 4.5 小时
**Files to Create**: 约 25 个
**Key Technologies**: Express、PostgreSQL、JWT、TypeScript

**API Endpoints Summary**:
- Authentication: 2 个端点
- Posts: 6 个端点
- Comments: 3 个端点
- Total: 11 个端点

Ready to proceed? (yes/no/modify)

User: yes

Claude: 开始 Phase 1：Project Setup……
[按阶段系统化实现]
```

## 示例 2：数据库迁移

### 使用 Planning Mode

```
User: /plan Migrate from MongoDB to PostgreSQL

Claude: 这是一次复杂迁移。我先制定一份详细计划。

## MongoDB 到 PostgreSQL 迁移计划

### Phase 1: Analysis & Preparation (Day 1)
1. 分析当前 MongoDB schema
2. 识别数据关系和约束
3. 记录当前数据量和增长速率
4. 设计等价的 PostgreSQL schema
5. 规划数据类型映射
6. 识别潜在迁移难点

### Phase 2: PostgreSQL Setup (Day 1)
7. 搭建 PostgreSQL 数据库
8. 创建包含表、索引和约束的 schema
9. 配置连接池
10. 制定备份策略

### Phase 3: Dual-Write Implementation (Day 2-3)
11. 创建数据库抽象层
12. 同时向两个数据库进行双写
13. 加入数据一致性检查
14. 将双写先部署到 staging
15. 监控问题

### Phase 4: Data Migration (Day 4)
16. 创建 MongoDB 数据导出脚本
17. 创建 PostgreSQL 数据导入脚本
18. 实现数据转换逻辑
19. 在生产数据副本上执行首次迁移
20. 校验迁移后数据完整性

### Phase 5: Gradual Cutover (Day 5-7)
21. 在生产环境启用双写
22. 分批迁移历史数据
23. 持续校验数据一致性
24. 同时监控两个数据库
25. 修复所有数据同步问题

### Phase 6: PostgreSQL Primary (Day 8)
26. 将读流量切到 PostgreSQL
27. 监控查询性能
28. 优化慢查询
29. 为安全起见继续保留双写

### Phase 7: MongoDB Retirement (Day 9-10)
30. 停止写入 MongoDB
31. MongoDB 作为备份保留 2 周
32. 从代码中移除 MongoDB 依赖
33. 归档 MongoDB 数据
34. 下线 MongoDB 实例

**Estimated Time**: 10 天
**Risk Level**: 高
**Rollback Strategy**: 保持 MongoDB 运行并继续双写
**Success Criteria**:
- 零数据丢失
- 性能回退小于 5%
- 所有测试通过

**Key Risks**:
1. 迁移过程中的数据不一致
2. 查询性能下降
3. 应用停机
4. 数据丢失

**Mitigation**:
- 通过双写模式确保安全
- 渐进式切换
- 持续监控
- 保留快速回滚能力

Proceed with this plan? (yes/no/modify)

User: Modify - let's add a rollback plan for each phase

Claude: 已更新计划，为每个阶段补充回滚流程……
```

## 示例 3：前端重构

```
User: /plan Refactor our React app from class components to hooks

Claude: 我来制定一份系统化的重构计划。

## React Class to Hooks Migration Plan

### Phase 1: Preparation & Analysis (2 hours)
1. 审计所有 class 组件（找出全部 .jsx/.tsx 文件）
2. 按复杂度分类：
   - 简单（仅 state）：约 15 个组件
   - 中等（有生命周期方法）：约 23 个组件
   - 复杂（多个生命周期、refs）：约 8 个组件
3. 识别需要升级的第三方库
4. 创建组件依赖图
5. 规划迁移顺序（先迁移叶子节点）

### Phase 2: Setup & Tooling (1 hour)
6. 将 React 升级到 v18+
7. 配置 hooks 的 ESLint 规则
8. 创建转换模板
9. 配置自动化测试
10. 开始前创建检查点

### Phase 3: Migrate Simple Components (4 hours)
11. 转换简单的有状态组件（15 个组件）
12. 用 useState 替换 this.state
13. 用 state setter 替换 this.setState
14. 每转换一个组件就测试一次
15. 更新测试

### Phase 4: Migrate Medium Components (8 hours)
16. 转换带生命周期方法的组件（23 个组件）
17. 用 useEffect 替换 componentDidMount
18. 用 useEffect 替换 componentDidUpdate
19. 用 useEffect cleanup 替换 componentWillUnmount
20. 充分测试

### Phase 5: Migrate Complex Components (12 hours)
21. 转换复杂组件（8 个组件）
22. 用 useRef 替换 refs
23. 抽取共享逻辑为自定义 hooks
24. 处理边界情况（多个 useEffect）
25. 做深入测试

### Phase 6: Shared Logic Extraction (6 hours)
26. 找出组件间重复逻辑
27. 创建自定义 hooks：
    - useAuth
    - useFetch
    - useLocalStorage
    - useDebounce
28. 将组件重构为使用这些自定义 hooks
29. 独立测试这些自定义 hooks

### Phase 7: Performance Optimization (4 hours)
30. 在合适的位置加入 React.memo
31. 使用 useCallback 做优化
32. 使用 useMemo 做优化
33. 做性能剖析并修复回退

### Phase 8: Cleanup & Documentation (2 hours)
34. 移除未使用的 class 组件工具代码
35. 更新文档
36. 更新编码规范
37. 为团队编写迁移指南

**Estimated Time**: 5 天（39 小时）
**Files to Modify**: 46 个组件
**Risk Level**: 中

**Migration Order**:
1. 叶子组件（无依赖）
2. 中层组件
3. 顶层容器组件
```
