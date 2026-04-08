# 项目配置

## 项目概览
- **名称**：电商平台
- **技术栈**：Node.js、PostgreSQL、React 18、Docker
- **团队规模**：5 名开发者
- **截止时间**：2025 年 Q4

## 架构
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## 开发规范

### 代码风格
- 使用 Prettier 进行格式化
- 使用 ESLint（airbnb 配置）
- 最大行长度：100 字符
- 使用 2 空格缩进

### 命名规范
- **文件**：kebab-case（user-controller.js）
- **类**：PascalCase（UserService）
- **函数/变量**：camelCase（getUserById）
- **常量**：UPPER_SNAKE_CASE（API_BASE_URL）
- **数据库表**：snake_case（user_accounts）

### Git 工作流
- 分支命名：`feature/description` 或 `fix/description`
- 提交信息：遵循 conventional commits 规范
- 合并前必须创建 PR
- 所有 CI/CD 检查必须通过
- 至少需要 1 个审批

### 测试要求
- 最低 80% 代码覆盖率
- 所有关键路径必须有测试
- 单元测试使用 Jest
- E2E 测试使用 Cypress
- 测试文件命名：`*.test.ts` 或 `*.spec.ts`

### API 规范
- 仅使用 RESTful 接口
- 使用 JSON 进行请求/响应
- 正确使用 HTTP 状态码
- API 版本化：`/api/v1/`
- 为所有接口提供示例文档

### 数据库
- 使用迁移（migration）进行 schema 变更
- 不得硬编码凭据
- 使用连接池
- 在开发环境启用查询日志
- 需要定期备份

### 部署
- 基于 Docker 的部署
- 使用 Kubernetes 进行编排
- 蓝绿部署策略
- 失败时自动回滚
- 部署前执行数据库迁移

## 常用命令

| 命令 | 用途 |
|------|------|
| `npm run dev` | 启动开发服务器 |
| `npm test` | 运行测试套件 |
| `npm run lint` | 检查代码风格 |
| `npm run build` | 构建生产版本 |
| `npm run migrate` | 执行数据库迁移 |

## 团队联系人
- 技术负责人：Sarah Chen (@sarah.chen)
- 产品经理：Mike Johnson (@mike.j)
- DevOps：Alex Kim (@alex.k)

## 已知问题与解决方案
- PostgreSQL 在高峰时段连接池限制为 20
- 解决方案：实现查询队列
- Safari 14 对 async generators 存在兼容性问题
- 解决方案：使用 Babel 转译

## 相关项目
- 数据分析看板：`/projects/analytics`
- 移动应用：`/projects/mobile`
- 管理后台：`/projects/admin`
