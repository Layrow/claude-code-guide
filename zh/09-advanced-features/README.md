<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-code-guide-logo-dark.svg">
  <img alt="Claude Code Guide" src="../resources/logos/claude-code-guide-logo.svg">
</picture>

# 高级特性

这是一份关于 Claude Code 高级能力的完整指南，涵盖 planning mode、extended thinking、auto mode、background tasks、permission modes、print mode（非交互式）、session management、interactive features、channels、voice dictation、remote control、web sessions、desktop app、task list、prompt suggestions、git worktrees、sandboxing、managed settings 和配置。

## 目录

1. [概览](#概览)
2. [规划模式](#规划模式)
3. [扩展思考](#扩展思考)
4. [自动模式](#自动模式)
5. [后台任务](#后台任务)
6. [定时任务](#定时任务)
7. [权限模式](#权限模式)
8. [无头模式](#无头模式)
9. [会话管理](#会话管理)
10. [交互特性](#交互特性)
11. [语音听写](#语音听写)
12. [Channels](#channels)
13. [Chrome 集成](#chrome-集成)
14. [远程控制](#远程控制)
15. [Web 会话](#web-会话)
16. [桌面应用](#桌面应用)
17. [任务列表](#任务列表)
18. [提示建议](#提示建议)
19. [Git Worktrees](#git-worktrees)
20. [沙箱](#沙箱)
21. [托管设置（企业版）](#托管设置企业版)
22. [配置与设置](#配置与设置)
23. [最佳实践](#最佳实践)
24. [更多资源](#更多资源)

---

## 概览

Claude Code 的高级特性是在核心能力之上，进一步扩展出规划、推理、自动化和控制能力。这些特性可以支持更复杂的开发工作流，例如复杂开发任务、代码评审、自动化执行和多会话管理。

**关键高级特性包括：**
- **Planning Mode**：编码前先生成详细实施计划
- **Extended Thinking**：针对复杂问题进行更深入的推理
- **Auto Mode**：在执行每一步前由后台安全分类器进行审查（Research Preview）
- **Background Tasks**：运行长耗时操作而不阻塞当前对话
- **Permission Modes**：控制 Claude 能执行哪些操作（`default`、`acceptEdits`、`plan`、`auto`、`dontAsk`、`bypassPermissions`）
- **Print Mode**：让 Claude Code 以非交互方式运行，适用于自动化和 CI/CD（`claude -p`）
- **Session Management**：管理多个工作会话
- **Interactive Features**：快捷键、多行输入和命令历史
- **Voice Dictation**：按住说话的语音输入，支持 20 种语言的 STT
- **Channels**：MCP 服务器可以向正在运行的会话推送消息（Research Preview）
- **Remote Control**：从 Claude.ai 或 Claude App 控制 Claude Code
- **Web Sessions**：在浏览器中通过 `claude.ai/code` 运行 Claude Code
- **Desktop App**：支持可视化 diff 评审和多会话的独立桌面应用
- **Task List**：在上下文压缩后仍可保留的任务追踪能力
- **Prompt Suggestions**：基于上下文的智能命令建议
- **Git Worktrees**：通过隔离 worktree 在并行分支中工作
- **Sandboxing**：操作系统级别的文件系统和网络隔离
- **Managed Settings**：通过 plist、Registry 或托管文件进行企业部署
- **Configuration**：通过 JSON 配置文件自定义行为

---

## 规划模式

规划模式允许 Claude 在实际实现之前，先把复杂任务想清楚，并生成一份你可以查看和批准的详细计划。

### 什么是规划模式？

规划模式采用两阶段方式：
1. **规划阶段**：Claude 分析任务并创建详细实施计划
2. **执行阶段**：在计划获得批准后，Claude 再按计划实施

### 什么时候该使用规划模式

✅ 适合用于：
- 跨多个文件的复杂重构
- 新功能实现
- 架构调整
- 数据库迁移
- 大型 API 重设计

❌ 不适合用于：
- 简单 bug 修复
- 格式调整
- 单文件编辑
- 快速查询

### 启用规划模式

**Slash command**：
```bash
/plan Implement user authentication system
```

**CLI flag**：
```bash
claude --permission-mode plan
```

**设为默认值**：
```json
{
  "permissions": {
    "defaultMode": "plan"
  }
}
```

**快捷键**：
- `Shift + Tab` - 切换权限模式（包括 plan）
- `Alt + M` - 切换权限模式（Windows/Linux）

### 规划模式的价值

- **结构化实施路径**：详细拆解实施步骤
- **可审阅与批准**：执行前先确认或调整计划
- **提前识别风险**：在动手前发现潜在问题
- **阶段清晰**：按里程碑推进，更容易管理

### 示例：功能实现

```
User: /plan Add a real-time notification system

Claude: 我来为实时通知系统制定一份计划。

## Implementation Plan

### Phase 1: Infrastructure Setup
1. 安装 WebSocket 相关库（socket.io）
2. 搭建 WebSocket 服务端
3. 配置连接管理

### Phase 2: Backend Implementation
4. 创建通知服务
5. 实现通知队列
6. 添加通知数据库 schema
7. 创建 API 端点

### Phase 3: Frontend Integration
8. 配置 WebSocket 客户端
9. 创建通知 UI 组件
10. 实现通知状态管理
11. 增加通知权限控制

### Phase 4: Testing & Deployment
12. 编写单元测试
13. 编写集成测试
14. 更新文档
15. 部署到 staging

Estimated time: 3-4 hours
Files to modify: 12
New files to create: 8

Ready to proceed? (yes/no/modify plan)

User: yes

Claude: [开始按计划实施]
```

### 修改计划

```
User: Modify the plan - skip the queue for now, we'll add it later

Claude: 更新后的计划：
[展示移除 queue 后的计划]

User: Looks good, proceed

Claude: [实现修改后的计划]
```

### 规划模式配置

规划模式可以通过 CLI 参数或 slash command 启用：

```bash
# 通过 CLI 启用 plan mode
claude --permission-mode plan

# 或在 REPL 内使用 /plan
/plan Implement user authentication system
```

**用于规划的模型别名**：可以使用 `opusplan` 这个模型别名，让 Opus 负责规划，Sonnet 负责执行：

```bash
claude --model opusplan "design and implement the new API"
```

**在外部编辑计划**：按 `Ctrl+G` 可以在外部编辑器里打开当前计划，进行更细致的修改。

---

## 扩展思考

扩展思考允许 Claude 在给出答案前，花更多时间对复杂问题进行推理。

### 什么是扩展思考？

扩展思考是一种更有意识、分步骤的推理过程。在这个过程中，Claude 会：
- 拆解复杂问题
- 比较多种方案
- 评估权衡
- 推演边界情况

### 启用扩展思考

**快捷键**：
- `Option + T`（macOS）/ `Alt + T`（Windows/Linux）- 切换扩展思考

**自动启用**：
- 默认对所有模型启用（Opus 4.6、Sonnet 4.6、Haiku 4.5）
- Opus 4.6：支持自适应推理，强度等级为 `low`（○）、`medium`（◐）、`high`（●）、`max`（仅 Opus 4.6）
- 其他模型：固定预算，上限为 31,999 tokens

**配置方式**：
- 切换：`Alt+T` / `Option+T`，或通过 `/config`
- 查看推理过程：`Ctrl+O`（verbose mode）
- 设置强度：`/effort` 命令或 `--effort` 参数

**自定义预算**：
```bash
export MAX_THINKING_TOKENS=1024
```

**强度等级**（仅 Opus 4.6）：
```bash
export CLAUDE_CODE_EFFORT_LEVEL=high   # low (○), medium (◐), high (●), or max (Opus 4.6 only)
```

**CLI flag**：
```bash
claude --effort high "complex architectural review"
```

**Slash command**：
```
/effort high
```

> **Note:** 在提示词中使用关键字 “ultrathink” 会激活深度推理模式。`low`、`medium`、`high` 和 `max`（仅 Opus 4.6）这些 effort 等级控制 Claude 会进行多少推理。

### 扩展思考的价值

- **更深入的推理**：针对复杂问题花更多时间思考
- **更好的架构决策**：在全面评估后做出更稳妥的选择
- **考虑边界情况**：提前想到潜在问题和场景
- **更完整的分析**：用结构化方式处理复杂问题

### 示例：架构决策

```
User: /think Should we use microservices or a monolith for our e-commerce platform?

Claude: 让我认真推演一下这个架构决策……

<extended_thinking>
## Context Analysis
- 团队规模：5 名开发者
- 初始预期流量：日活 1 万
- 需要扩展到 10 万+ 用户
- DevOps 资源有限
- 距离 MVP 截止还有 6 个月

## Approach 1: Microservices
Pros:
+ 独立扩缩容
+ 技术栈灵活
+ 团队可独立推进
+ 故障隔离更好

Cons:
- 运维复杂度高
- 网络开销更大
- 需要分布式追踪
- 依赖 DevOps 能力
- 初期开发更慢

## Approach 2: Monolith
Pros:
+ 部署更简单
+ 初期开发更快
+ 调试更容易
+ 运维负担更低
+ 单一代码库

Cons:
- 后期扩展更有挑战
- 部署是全量式的
- 技术栈容易被锁定
- 可能形成紧耦合

## Decision Factors
1. 团队规模（5 人）→ 更倾向 monolith
2. DevOps 资源（有限）→ 更倾向 monolith
3. 时间线（6 个月）→ 更倾向 monolith
4. 未来规模（10 万用户）→ 借助 monolith + caching 仍可实现
5. 可承受复杂度预算 → 有限

## Recommendation
从 **模块化单体（modular monolith）** 开始：
- 单一部署单元
- 明确的模块边界
- 模块间使用干净接口
- 未来如果需要，可再拆为微服务

这会给你：
✓ 初期开发更快
✓ 运维复杂度更低
✓ 未来仍能拆服务
✓ 架构边界清晰

迁移路径：当用户规模超过 5 万，或某些模块需要独立扩缩容时，再把这些模块拆成微服务。
</extended_thinking>

**Recommendation**: 采用模块化单体，并保持清晰的模块边界。

这能在你当前的约束条件（团队规模、时间线、DevOps 资源）和未来扩展需求之间取得更好平衡。之后如果出现明确业务需求，你仍然可以把特定模块逐步迁移为微服务。
```

### 扩展思考配置

扩展思考可以通过环境变量、快捷键和 CLI 参数进行控制：

```bash
# 设置 thinking token 预算
export MAX_THINKING_TOKENS=16000

# 设置 effort level（仅 Opus 4.6）：low (○), medium (◐), high (●), or max (Opus 4.6 only)
export CLAUDE_CODE_EFFORT_LEVEL=high
```

你也可以在会话中用 `Alt+T` / `Option+T` 切换，用 `/effort` 设置强度，或通过 `/config` 配置。

---

## 自动模式

Auto Mode 是一个处于 Research Preview 的权限模式（2026 年 3 月），它会使用后台安全分类器在每个动作执行前进行审查。这样 Claude 可以在保持较高自主性的同时，拦截危险操作。

### 前置条件

- **Plan**：Team plan（Enterprise 和 API 正在逐步开放）
- **Model**：Claude Sonnet 4.6 或 Opus 4.6
- **Classifier**：运行在 Claude Sonnet 4.6 上（会增加额外 token 成本）

### 启用自动模式

```bash
# 通过 CLI 参数解锁 auto mode
claude --enable-auto-mode

# 然后在 REPL 中用 Shift+Tab 切换到它
```

或者直接将其设为默认权限模式：

```bash
claude --permission-mode auto
```

通过配置设置：
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### 分类器如何工作

后台分类器按以下顺序评估每一个动作：

1. **Allow/deny rules** -- 先检查显式权限规则
2. **Read-only/edits auto-approved** -- 文件读取和编辑会自动放行
3. **Classifier** -- 后台分类器审查动作
4. **Fallback** -- 连续 3 次或累计 20 次被拦截后，回退为提示用户确认

### 默认拦截的动作

Auto mode 默认会拦截以下操作：

| Blocked Action | Example |
|----------------|---------|
| 管道安装脚本 | `curl \| bash` |
| 向外发送敏感数据 | 通过网络发送 API key、凭据等 |
| 生产环境部署 | 指向生产环境的 deploy 命令 |
| 大规模删除 | 对大目录执行 `rm -rf` |
| IAM 变更 | 权限和角色修改 |
| 强推到 main | `git push --force origin main` |

### 默认允许的动作

| Allowed Action | Example |
|----------------|---------|
| 本地文件操作 | 读取、写入、编辑项目文件 |
| 已声明依赖的安装 | 从 manifest 发起 `npm install`、`pip install` |
| 只读 HTTP | 用 `curl` 获取文档 |
| 推送到当前分支 | `git push origin feature-branch` |

### 配置自动模式

**以 JSON 形式输出默认规则**：
```bash
claude auto-mode defaults
```

可以通过 `autoMode.environment` 这个托管设置，为企业部署配置**可信基础设施**。管理员可以借此定义受信任的 CI/CD 环境、部署目标和基础设施模式。

### 回退行为

当分类器无法确定是否安全时，auto mode 会回退为向用户询问：
- 连续 **3 次** 被分类器拦截后
- 或一个会话中累计 **20 次** 被拦截后

这可以确保当分类器无法有把握地批准某个动作时，用户始终保有最终控制权。

### 预置与 Auto Mode 等价的权限规则（无需 Team Plan）

如果你没有 Team plan，或者只是想采用一种更简单、无需后台分类器的方式，你可以先往 `~/.claude/settings.json` 写入一套保守的安全权限基线。这个脚本会从只读和本地检查类规则开始，再让你按需逐步开启 edits、tests、本地 git 写操作、包管理器安装以及 GitHub 写操作。

**文件：** `09-advanced-features/setup-auto-mode-permissions.py`

```bash
# 预览会新增什么（不真正写入）
python3 09-advanced-features/setup-auto-mode-permissions.py --dry-run

# 应用保守基线
python3 09-advanced-features/setup-auto-mode-permissions.py

# 按需逐步放开更多能力
python3 09-advanced-features/setup-auto-mode-permissions.py --include-edits --include-tests
python3 09-advanced-features/setup-auto-mode-permissions.py --include-git-write --include-packages
```

这个脚本会按以下类别添加规则：

| Category | Examples |
|----------|---------|
| 核心只读工具 | `Read(*)`, `Glob(*)`, `Grep(*)`, `Agent(*)`, `WebSearch(*)`, `WebFetch(*)` |
| 本地检查 | `Bash(git status:*)`, `Bash(git log:*)`, `Bash(git diff:*)`, `Bash(cat:*)` |
| 可选编辑能力 | `Edit(*)`, `Write(*)`, `NotebookEdit(*)` |
| 可选测试/构建 | `Bash(pytest:*)`, `Bash(python3 -m pytest:*)`, `Bash(cargo test:*)` |
| 可选 git 写操作 | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git stash:*)` |
| Git（本地写操作） | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git checkout:*)` |
| 包管理器 | `Bash(npm install:*)`, `Bash(pip install:*)`, `Bash(cargo build:*)` |
| 构建与测试 | `Bash(make:*)`, `Bash(pytest:*)`, `Bash(go test:*)` |
| 常用 shell | `Bash(ls:*)`, `Bash(cat:*)`, `Bash(find:*)`, `Bash(cp:*)`, `Bash(mv:*)` |
| GitHub CLI | `Bash(gh pr view:*)`, `Bash(gh pr create:*)`, `Bash(gh issue list:*)` |

危险操作（`rm -rf`、`sudo`、强推、`DROP TABLE`、`terraform destroy` 等）会被刻意排除。这个脚本具有幂等性，重复运行也不会插入重复规则。

---

## 后台任务

后台任务允许长时间运行的操作在不阻塞当前对话的前提下执行。

### 什么是后台任务？

后台任务会异步执行，而你可以继续当前工作：
- 长时间运行的测试套件
- 构建流程
- 数据库迁移
- 部署脚本
- 分析工具

**基本用法：**
```bash
User: Run tests in background

Claude: Started task bg-1234

/task list           # 列出所有任务
/task status bg-1234 # 查看进度
/task show bg-1234   # 查看输出
/task cancel bg-1234 # 取消任务
```

### 启动后台任务

```
User: Run the full test suite in the background

Claude: 正在后台启动测试（task-id: bg-1234）
你可以在测试运行期间继续做别的工作。

[你可以继续对话]

User: Meanwhile, let's refactor the auth module

Claude: [在测试后台运行时继续处理 auth 模块]

[稍后，测试完成]

Claude: 📢 后台任务 bg-1234 已完成：
✅ 245 个测试通过
❌ 3 个测试失败
查看结果：/task show bg-1234
```

### 管理后台任务

**列出活动任务**：
```
User: /task list

Active background tasks:
1. [bg-1234] Running tests (50% complete, 2min remaining)
2. [bg-1235] Building Docker image (25% complete, 8min remaining)
3. [bg-1236] Deploying to staging (90% complete, 30sec remaining)
```

**检查任务状态**：
```
User: /task status bg-1234

Task bg-1234: Running tests
Status: In progress
Progress: 120/245 tests (49%)
Started: 2025-11-08 10:30:15
Estimated completion: 2025-11-08 10:34:22
```

**查看任务输出**：
```
User: /task show bg-1234

[显示测试运行的实时输出]
```

**取消任务**：
```
User: /task cancel bg-1234

Cancelled background task bg-1234
```

### 示例：并行开发

```
User: Run the build in the background

Claude: 开始构建……（task-id: bg-5001）

User: Also run the linter in background

Claude: 开始运行 linter……（task-id: bg-5002）

User: While those run, let's implement the new API endpoint

Claude: [在构建和 linter 后台运行时实现新 API 端点]

[10 分钟后]

Claude: 📢 构建成功完成（bg-5001）
📢 Linter 发现 12 个问题（bg-5002）

User: Show me the linter issues

Claude: [展示 bg-5002 的 linter 输出]
```

### 配置

```json
{
  "backgroundTasks": {
    "enabled": true,
    "maxConcurrentTasks": 5,
    "notifyOnCompletion": true,
    "autoCleanup": true,
    "logOutput": true
  }
}
```

---

## 定时任务

Scheduled Tasks 让你可以按周期自动运行提示词，或者创建一次性的提醒。任务是会话级别的，也就是说它们只会在 Claude Code 正在运行时生效，并在会话结束时清除。自 v2.1.72+ 起可用。

### `/loop` 命令

```bash
# 显式间隔
/loop 5m check if the deployment finished

# 自然语言
/loop check build status every 30 minutes
```

也支持标准的 5 段 cron 表达式，以便更精确地调度。

### 一次性提醒

设置会在某个时间只触发一次的提醒：

```
remind me at 3pm to push the release branch
in 45 minutes, run the integration tests
```

### 管理定时任务

| Tool | Description |
|------|-------------|
| `CronCreate` | 创建新的定时任务 |
| `CronList` | 列出所有活动中的定时任务 |
| `CronDelete` | 删除一个定时任务 |

**限制与行为**：
- 每个会话最多 **50 个定时任务**
- 仅限当前会话，结束即清除
- 周期性任务会在 **3 天** 后自动过期
- 任务只会在 Claude Code 正在运行时触发，错过不会补跑

### 行为细节

| Aspect | Detail |
|--------|--------|
| **Recurring jitter** | 最多为间隔的 10%（上限 15 分钟） |
| **One-shot jitter** | 在 :00/:30 边界上最多有 90 秒抖动 |
| **Missed fires** | 不会补跑；如果当时 Claude Code 未运行就直接跳过 |
| **Persistence** | 重启后不会保留 |

### 云端定时任务

可以使用 `/schedule` 创建运行在 Anthropic 基础设施上的云端定时任务：

```
/schedule daily at 9am run the test suite and report failures
```

云端定时任务可以跨重启保留，而且不要求 Claude Code 在本地运行。

### 关闭定时任务

```bash
export CLAUDE_CODE_DISABLE_CRON=1
```

### 示例：监控部署

```
/loop 5m check the deployment status of the staging environment.
        If the deploy succeeded, notify me and stop looping.
        If it failed, show the error logs.
```

> **Tip**: 定时任务是会话级的。如果你需要跨重启保留的自动化，请改用 CI/CD 流水线、GitHub Actions 或 Desktop App 的定时任务。

---

## 权限模式

权限模式决定 Claude 在不显式征求你确认的情况下，能执行哪些动作。

### 可用权限模式

| Mode | Behavior |
|---|---|
| `default` | 仅可读文件；其他所有操作都需要确认 |
| `acceptEdits` | 可读写文件；执行命令前仍会提示 |
| `plan` | 仅可读文件（研究模式，不做修改） |
| `auto` | 所有动作都可执行，但会经过后台安全分类器检查（Research Preview） |
| `bypassPermissions` | 所有动作都可执行，且不做权限检查（危险） |
| `dontAsk` | 只有预先批准的工具可以执行，其他一律拒绝 |

可以在 CLI 里用 `Shift+Tab` 循环切换模式，也可以通过 `--permission-mode` 参数或 `permissions.defaultMode` 设置默认模式。

### 启用方式

**快捷键**：
```bash
Shift + Tab  # 在 6 种模式中循环切换
```

**Slash command**：
```bash
/plan                  # 进入 plan mode
```

**CLI flag**：
```bash
claude --permission-mode plan
claude --permission-mode auto
```

**设置**：
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### 权限模式示例

#### Default Mode
Claude 会在执行重要操作前请求确认：

```
User: Fix the bug in auth.ts

Claude: 我需要修改 src/auth.ts 来修复这个 bug。
这次改动会更新密码校验逻辑。

Approve this change? (yes/no/show)
```

#### Plan Mode
在真正执行前先审查计划：

```
User: /plan Implement user authentication system

Claude: 我来为这个认证系统制定一份计划。

## Implementation Plan
[包含阶段和步骤的详细计划]

Ready to proceed? (yes/no/modify)
```

#### Accept Edits Mode
自动接受文件修改：

```
User: acceptEdits
User: Fix the bug in auth.ts

Claude: [直接修改，不再逐次询问]
```

### 使用场景

**代码评审**：
```
User: claude --permission-mode plan
User: Review this PR and suggest improvements

Claude: [读取代码、给出反馈，但不会修改]
```

**结对编程**：
```
User: claude --permission-mode default
User: Let's implement the feature together

Claude: [每次改动前先请求批准]
```

**自动化任务**：
```
User: claude --permission-mode acceptEdits
User: Fix all linting issues in the codebase

Claude: [自动接受文件编辑，不再逐次询问]
```

---

## 无头模式

Print mode（`claude -p`）允许 Claude Code 在无需交互输入的情况下运行，非常适合自动化和 CI/CD。这就是当前的非交互模式，用来替代旧的 `--headless` 参数。

### 什么是 Print Mode？

Print mode 支持：
- 自动化脚本执行
- CI/CD 集成
- 批处理
- 定时任务

### 以 Print Mode 运行（非交互）

```bash
# 运行特定任务
claude -p "Run all tests"

# 处理管道输入
cat error.log | claude -p "Analyze these errors"

# CI/CD 集成（GitHub Actions）
- name: AI Code Review
  run: claude -p "Review PR"
```

### 更多 Print Mode 用法示例

```bash
# 执行特定任务并获取输出
claude -p "Run all tests and generate coverage report"

# 结构化输出
claude -p --output-format json "Analyze code quality"

# 从 stdin 输入
echo "Analyze code quality" | claude -p "explain this"
```

### 示例：CI/CD 集成

**GitHub Actions**：
```yaml
# .github/workflows/code-review.yml
name: AI Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: Run Claude Code Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude -p --output-format json \
            --max-turns 3 \
            "Review this PR for:
            - Code quality issues
            - Security vulnerabilities
            - Performance concerns
            - Test coverage
            Output results as JSON" > review.json

      - name: Post Review Comment
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const review = JSON.parse(fs.readFileSync('review.json', 'utf8'));
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: JSON.stringify(review, null, 2)
            });
```

### Print Mode 配置

Print mode（`claude -p`）支持多种适合自动化的参数：

```bash
# 限制自主轮次
claude -p --max-turns 5 "refactor this module"

# 结构化 JSON 输出
claude -p --output-format json "analyze this codebase"

# 加入 schema 校验
claude -p --json-schema '{"type":"object","properties":{"issues":{"type":"array"}}}' \
  "find bugs in this code"

# 禁用会话持久化
claude -p --no-session-persistence "one-off analysis"
```

---

## 会话管理

有效管理多个 Claude Code 会话。

### 会话管理命令

| Command | Description |
|---------|-------------|
| `/resume` | 按 ID 或名称恢复某个会话 |
| `/rename` | 为当前会话命名 |
| `/fork` | 把当前会话 fork 成一个新分支 |
| `claude -c` | 继续最近一次会话 |
| `claude -r "session"` | 按名称或 ID 恢复会话 |

### 恢复会话

**继续最近一次会话**：
```bash
claude -c
```

**恢复具名会话**：
```bash
claude -r "auth-refactor" "finish this PR"
```

**重命名当前会话**（在 REPL 内）：
```
/rename auth-refactor
```

### Fork 会话

在不丢失原会话的前提下 fork 出一个分支，尝试另一种实现路径：

```
/fork
```

或者通过 CLI：
```bash
claude --resume auth-refactor --fork-session "try OAuth instead"
```

### 会话持久化

会话会自动保存，之后可以恢复：

```bash
# 继续上次对话
claude -c

# 按名称或 ID 恢复指定会话
claude -r "auth-refactor"

# 恢复并 fork，用于试验其他方案
claude --resume auth-refactor --fork-session "alternative approach"
```

---

## 交互特性

### 快捷键

Claude Code 支持一组提升效率的快捷键。下面是来自官方文档的完整参考：

| Shortcut | Description |
|----------|-------------|
| `Ctrl+C` | 取消当前输入/生成 |
| `Ctrl+D` | 退出 Claude Code |
| `Ctrl+G` | 在外部编辑器中编辑计划 |
| `Ctrl+L` | 清空终端屏幕 |
| `Ctrl+O` | 切换 verbose 输出（查看推理过程） |
| `Ctrl+R` | 反向搜索历史 |
| `Ctrl+T` | 切换任务列表视图 |
| `Ctrl+B` | 查看后台运行任务 |
| `Esc+Esc` | 回退代码/对话 |
| `Shift+Tab` / `Alt+M` | 切换权限模式 |
| `Option+P` / `Alt+P` | 切换模型 |
| `Option+T` / `Alt+T` | 切换扩展思考 |

**行编辑（标准 readline 快捷键）：**

| Shortcut | Action |
|----------|--------|
| `Ctrl + A` | 移动到行首 |
| `Ctrl + E` | 移动到行尾 |
| `Ctrl + K` | 剪切到行尾 |
| `Ctrl + U` | 剪切到行首 |
| `Ctrl + W` | 向后删除一个单词 |
| `Ctrl + Y` | 粘贴（yank） |
| `Tab` | 自动补全 |
| `↑ / ↓` | 命令历史 |

### 自定义快捷键

运行 `/keybindings` 可以创建自定义快捷键，它会打开 `~/.claude/keybindings.json` 供你编辑（v2.1.18+）。

**配置格式**：

```json
{
  "$schema": "https://www.schemastore.org/claude-code-keybindings.json",
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+u": null,
        "ctrl+k ctrl+s": "chat:stash"
      }
    },
    {
      "context": "Confirmation",
      "bindings": {
        "ctrl+a": "confirmation:yes"
      }
    }
  ]
}
```

把某个绑定设成 `null`，就表示解除默认快捷键绑定。

### 可用上下文

快捷键会作用于特定 UI 上下文：

| Context | Key Actions |
|---------|-------------|
| **Chat** | `submit`, `cancel`, `cycleMode`, `modelPicker`, `thinkingToggle`, `undo`, `externalEditor`, `stash`, `imagePaste` |
| **Confirmation** | `yes`, `no`, `previous`, `next`, `nextField`, `cycleMode`, `toggleExplanation` |
| **Global** | `interrupt`, `exit`, `toggleTodos`, `toggleTranscript` |
| **Autocomplete** | `accept`, `dismiss`, `next`, `previous` |
| **HistorySearch** | `search`, `previous`, `next` |
| **Settings** | 与 settings 相关的上下文导航 |
| **Tabs** | Tab 切换与管理 |
| **Help** | Help 面板导航 |

总共有 18 个上下文，还包括 `Transcript`、`Task`、`ThemePicker`、`Attachments`、`Footer`、`MessageSelector`、`DiffDialog`、`ModelPicker` 和 `Select`。

### 支持按键序列（Chord）

快捷键支持 chord sequence（多键组合）：

```
"ctrl+k ctrl+s"   → 两段式组合：先按 ctrl+k，再按 ctrl+s
"ctrl+shift+p"    → 同时按下多个修饰键
```

**按键语法**：
- **修饰键**：`ctrl`、`alt`（或 `opt`）、`shift`、`meta`（或 `cmd`）
- **大写隐含 Shift**：`K` 等价于 `shift+k`
- **特殊按键**：`escape`、`enter`、`return`、`tab`、`space`、`backspace`、`delete`、方向键

### 保留键与冲突键

| Key | Status | Notes |
|-----|--------|-------|
| `Ctrl+C` | 保留 | 不可重绑定（中断） |
| `Ctrl+D` | 保留 | 不可重绑定（退出） |
| `Ctrl+B` | 终端冲突 | tmux 前缀键 |
| `Ctrl+A` | 终端冲突 | GNU Screen 前缀键 |
| `Ctrl+Z` | 终端冲突 | 挂起进程 |

> **Tip**: 如果某个快捷键不起作用，先检查是否和你的终端模拟器或多路复用器冲突。

### Tab 补全

Claude Code 提供智能 Tab 补全：

```
User: /rew<TAB>
→ /rewind

User: /plu<TAB>
→ /plugin

User: /plugin <TAB>
→ /plugin install
→ /plugin enable
→ /plugin disable
```

### 命令历史

访问之前的命令：

```
User: <↑>  # 上一条命令
User: <↓>  # 下一条命令
User: Ctrl+R  # 搜索历史

(reverse-i-search)`test': run all tests
```

### 多行输入

对于复杂请求，可以使用多行模式：

```bash
User: \
> Long complex prompt
> spanning multiple lines
> \end
```

**示例：**

```
User: \
> Implement a user authentication system
> with the following requirements:
> - JWT tokens
> - Email verification
> - Password reset
> - 2FA support
> \end

Claude: [处理这条多行请求]
```

### 行内编辑

在发送之前先编辑命令：

```
User: Deploy to prodcution<Backspace><Backspace>uction

[发送前原地修改]
```

### Vim Mode

为文本编辑启用 Vi/Vim 键位：

**启用方式**：
- 使用 `/vim` 命令或 `/config` 开启
- 用 `Esc` 切到 NORMAL，用 `i/a/o` 切到 INSERT

**导航键**：
- `h` / `l` - 左/右移动
- `j` / `k` - 下/上移动
- `w` / `b` / `e` - 按单词移动
- `0` / `$` - 移到行首/行尾
- `gg` / `G` - 跳到文本开头/末尾

**文本对象**：
- `iw` / `aw` - 单词内部/单词周围
- `i"` / `a"` - 引号内部/引号周围
- `i(` / `a(` - 括号内部/括号周围

### Bash Mode

使用 `!` 前缀可直接执行 shell 命令：

```bash
! npm test
! git status
! cat src/index.js
```

适合快速执行命令，而无需切换上下文。

---

## 语音听写

Voice Dictation 提供按住说话的语音输入能力，让你可以直接说出提示词，而不是手动输入。

### 启用语音听写

```
/voice
```

### 功能

| Feature | Description |
|---------|-------------|
| **Push-to-talk** | 按住录音，松开后发送 |
| **20 languages** | 语音转文字支持 20 种语言 |
| **Custom keybinding** | 可通过 `/keybindings` 配置按住说话的快捷键 |
| **Account requirement** | 需要 Claude.ai 账号来完成 STT 处理 |

### 配置

可以在快捷键配置文件（`/keybindings`）中自定义按住说话按键。语音听写会使用你的 Claude.ai 账号来完成语音转文字。

---

## Channels

Channels（Research Preview）允许 MCP 服务器向正在运行的 Claude Code 会话主动推送消息，从而支持与外部服务的实时集成。

### 订阅 Channels

```bash
# 启动时订阅 channel plugins
claude --channels discord,telegram
```

### 支持的集成

| Integration | Description |
|-------------|-------------|
| **Discord** | 在当前会话中接收并响应 Discord 消息 |
| **Telegram** | 在当前会话中接收并响应 Telegram 消息 |

### 配置

**企业部署中的托管设置**：

```json
{
  "allowedChannelPlugins": ["discord", "telegram"]
}
```

`allowedChannelPlugins` 这个托管设置用来控制组织范围内允许哪些 channel plugin。

### 工作方式

1. MCP 服务器作为 channel plugin 连接外部服务
2. 收到的消息会被推送到当前激活的 Claude Code 会话
3. Claude 能在当前会话上下文中读取并响应这些消息
4. Channel plugin 必须先通过 `allowedChannelPlugins` 托管设置批准

---

## Chrome 集成

Chrome Integration 可把 Claude Code 连接到你的 Chrome 或 Microsoft Edge 浏览器，用于实时 Web 自动化与调试。这是一个 beta 功能，自 v2.0.73+ 起可用（Edge 支持自 v1.0.36+ 起加入）。

### 启用 Chrome 集成

**启动时启用**：

```bash
claude --chrome      # 启用 Chrome 连接
claude --no-chrome   # 禁用 Chrome 连接
```

**在会话中启用**：

```
/chrome
```

选择 “Enabled by default” 后，就会为后续所有会话默认启用 Chrome Integration。Claude Code 会共享你浏览器中的登录状态，因此可以与已登录的 Web 应用交互。

### 能力

| Capability | Description |
|------------|-------------|
| **Live debugging** | 读取控制台日志、检查 DOM 元素、实时调试 JavaScript |
| **Design verification** | 将页面实际渲染效果与设计稿进行比对 |
| **Form validation** | 测试表单提交、输入校验和错误处理 |
| **Web app testing** | 与已登录应用交互（Gmail、Google Docs、Notion 等） |
| **Data extraction** | 抓取并处理网页内容 |
| **Session recording** | 将浏览器交互过程录制为 GIF 文件 |

### 站点级权限

Chrome 扩展会管理每个站点的访问权限。你可以随时通过扩展弹窗，为特定站点授予或撤销权限。Claude Code 只会与你明确允许的网站交互。

### 工作方式

Claude Code 会在一个可见的浏览器窗口中控制浏览器，你可以实时看到操作过程。如果浏览器遇到登录页或 CAPTCHA，Claude 会暂停，并等待你手动处理后再继续。

### 已知限制

- **浏览器支持**：仅支持 Chrome 和 Edge，不支持 Brave、Arc 等其他 Chromium 浏览器
- **WSL**：Windows Subsystem for Linux 中不可用
- **第三方提供商**：不支持 Bedrock、Vertex 或 Foundry API provider
- **Service worker idle**：Chrome 扩展的 service worker 在长会话中可能进入空闲状态

> **Tip**: Chrome Integration 仍属于 beta 功能，未来版本可能会支持更多浏览器。

---

## 远程控制

Remote Control 让你可以在本地运行 Claude Code 的同时，从手机、平板或任意浏览器继续控制这个会话。你的本地会话仍然运行在自己的机器上，不会迁移到云端。适用于 Pro、Max、Team 和 Enterprise plan（v2.1.51+）。

### 启动 Remote Control

**通过 CLI**：

```bash
# 使用默认会话名启动
claude remote-control

# 使用自定义名称启动
claude remote-control --name "Auth Refactor"
```

**在会话内启动**：

```
/remote-control
/remote-control "Auth Refactor"
```

**可用参数**：

| Flag | Description |
|------|-------------|
| `--name "title"` | 自定义会话标题，便于识别 |
| `--verbose` | 显示详细连接日志 |
| `--sandbox` | 启用文件系统和网络隔离 |
| `--no-sandbox` | 禁用沙箱（默认） |

### 从其他设备连接

有三种方式可以从其他设备接入：

1. **Session URL** — 会话启动时打印在终端中，可在任意浏览器打开
2. **QR code** — 启动后按 `spacebar` 显示可扫描二维码
3. **Find by name** — 在 `claude.ai/code` 或 Claude 移动端 App（iOS/Android）中按名称查找会话

### 安全性

- **不会在本机开放入站端口**
- **仅使用出站 HTTPS**，并通过 TLS 传输
- **Scoped credentials** — 使用多个短期、细粒度范围的 token
- **Session isolation** — 每个远程会话彼此独立

### Remote Control 与网页版 Claude Code 的区别

| Aspect | Remote Control | Claude Code on Web |
|--------|---------------|-------------------|
| **Execution** | 在你的机器上运行 | 在 Anthropic 云端运行 |
| **Local tools** | 完整访问本地 MCP 服务器、文件和 CLI | 没有本地依赖 |
| **Use case** | 从别的设备继续本地工作 | 从任意浏览器开始新的工作 |

### 限制

- 每个 Claude Code 实例只支持一个 remote session
- 宿主机上的终端必须保持打开
- 如果网络不可达，约 10 分钟后会话超时

### 使用场景

- 离开工位时，用手机或平板继续控制 Claude Code
- 使用更丰富的 claude.ai UI，同时保留本地工具执行能力
- 在移动状态下也能借助本地完整开发环境做快速代码评审

---

## Web 会话

Web Sessions 允许你直接在 `claude.ai/code` 的浏览器界面中运行 Claude Code，也可以从 CLI 主动创建 Web 会话。

### 创建 Web 会话

```bash
# 通过 CLI 创建新的 Web 会话
claude --remote "implement the new API endpoints"
```

这会在 claude.ai 上启动一个 Claude Code 会话，你可以从任意浏览器访问它。

### 在本地恢复 Web 会话

如果你先在 Web 上启动了一个会话，想切回本地终端继续：

```bash
# 在本地终端恢复一个 Web 会话
claude --teleport
```

或者在交互式 REPL 中：
```
/teleport
```

### 使用场景

- 在一台机器上开始工作，再切到另一台机器继续
- 与团队成员共享会话链接
- 用 Web UI 做可视化 diff 评审，再切回终端执行

---

## 桌面应用

Claude Code Desktop App 提供独立桌面应用，支持可视化 diff 评审、并行会话和集成 connector。适用于 macOS 和 Windows（Pro、Max、Team、Enterprise）。

### 安装

前往 [claude.ai](https://claude.ai) 下载对应平台版本：
- **macOS**：Universal build（Apple Silicon 和 Intel）
- **Windows**：提供 x64 和 ARM64 安装包

安装与配置可参考 [Desktop Quickstart](https://code.claude.com/docs/en/desktop-quickstart)。

### 从 CLI 交接到 Desktop App

把你当前的 CLI 会话转交给 Desktop App：

```
/desktop
```

### 核心功能

| Feature | Description |
|---------|-------------|
| **Diff view** | 按文件可视化审阅 diff，并支持行内评论；Claude 会读取评论并调整修改 |
| **App preview** | 自动启动 dev server，并在内嵌浏览器里进行实时验证 |
| **PR monitoring** | 集成 GitHub CLI，可自动修复 CI 失败并在检查通过后自动合并 |
| **Parallel sessions** | 侧边栏支持多个会话，并自动借助 Git worktree 进行隔离 |
| **Scheduled tasks** | 在应用打开时运行定期任务（每小时、每天、工作日、每周） |
| **Rich rendering** | 支持代码、Markdown、图表的富渲染和语法高亮 |

### App preview 配置

在 `.claude/launch.json` 中配置 dev server 行为：

```json
{
  "command": "npm run dev",
  "port": 3000,
  "readyPattern": "ready on",
  "persistCookies": true
}
```

### Connectors

连接外部服务以获得更丰富的上下文：

| Connector | Capability |
|-----------|------------|
| **GitHub** | PR 监控、Issue 跟踪、代码评审 |
| **Slack** | 通知、频道上下文 |
| **Linear** | Issue 跟踪、Sprint 管理 |
| **Notion** | 文档与知识库访问 |
| **Asana** | 任务管理、项目跟踪 |
| **Calendar** | 日程感知、会议上下文 |

> **Note**: Connectors 在 remote（云端）会话中不可用。

### Remote 和 SSH 会话

- **Remote sessions**：运行在 Anthropic 云端基础设施中，即使应用关闭也能继续；可通过 `claude.ai/code` 或 Claude 移动端 App 访问
- **SSH sessions**：通过 SSH 连接远程机器，并可完整访问远程文件系统和工具。远程机器上需要已安装 Claude Code

### Desktop 中的权限模式

Desktop App 支持与 CLI 相同的 4 种权限模式：

| Mode | Behavior |
|------|----------|
| **Ask permissions**（默认） | 所有编辑和命令都逐个审核批准 |
| **Auto accept edits** | 文件编辑自动批准；命令仍需手动批准 |
| **Plan mode** | 在任何修改发生前先审查方案 |
| **Bypass permissions** | 自动执行（仅沙箱内，且由管理员控制） |

### 企业能力

- **Admin console**：控制组织内 Code tab 的访问与权限设置
- **MDM deployment**：可通过 macOS 的 MDM 或 Windows 的 MSIX 进行部署
- **SSO integration**：要求组织成员使用单点登录
- **Managed settings**：集中管理团队配置和模型可用性

---

## 任务列表

Task List 功能提供可跨上下文压缩保留的任务追踪能力。当对话历史为了适配上下文窗口而被裁剪时，任务仍然能够保留下来。

### 切换任务列表

在会话中按 `Ctrl+T` 可以打开或关闭任务列表视图。

### 持久化任务

任务会在上下文压缩后依然保留，这能确保那些长时间运行、多步骤的工作不会因为上下文被裁掉而丢失。对于复杂、多阶段实现来说尤其有用。

### 命名任务目录

可以用 `CLAUDE_CODE_TASK_LIST_ID` 环境变量创建跨会话共享的命名任务目录：

```bash
export CLAUDE_CODE_TASK_LIST_ID=my-project-sprint-3
```

这样多个会话就能共享同一个任务列表，适合团队协作或多会话项目。

---

## 提示建议

Prompt Suggestions 会根据你的 git 历史和当前会话上下文，在输入框下方显示灰色的示例命令建议。

### 工作方式

- 建议会以灰色文本显示在输入框下方
- 按 `Tab` 接受建议
- 按 `Enter` 接受并立即提交
- 建议会结合 git 历史和当前对话状态进行上下文感知

### 关闭提示建议

```bash
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
```

---

## Git Worktrees

Git Worktrees 允许你在隔离的 worktree 中启动 Claude Code，这样就可以在不同分支上并行工作，而不需要 stash 或频繁切换。

### 在 Worktree 中启动

```bash
# 在隔离的 worktree 中启动 Claude Code
claude --worktree
# 或
claude -w
```

### Worktree 位置

Worktree 会创建在：
```
<repo>/.claude/worktrees/<name>
```

### Monorepo 的 Sparse Checkout

可通过 `worktree.sparsePaths` 设置，在 monorepo 中执行 sparse-checkout，以减少磁盘占用和 clone 时间：

```json
{
  "worktree": {
    "sparsePaths": ["packages/my-package", "shared/"]
  }
}
```

### Worktree 工具与 Hooks

| Item | Description |
|------|-------------|
| `ExitWorktree` | 退出并清理当前 worktree 的工具 |
| `WorktreeCreate` | 创建 worktree 时触发的 hook 事件 |
| `WorktreeRemove` | 移除 worktree 时触发的 hook 事件 |

### 自动清理

如果在 worktree 中没有做任何修改，那么会在会话结束时自动清理。

### 使用场景

- 在主分支保持不动的同时，去 feature branch 上工作
- 在隔离环境中运行测试，不影响当前工作目录
- 在可丢弃环境里尝试试验性修改
- 在 monorepo 中只 sparse-checkout 特定包，以更快启动

---

## 沙箱

Sandboxing 为 Claude Code 执行的 Bash 命令提供操作系统级别的文件系统和网络隔离。这是对权限规则的补充，提供额外一层安全防护。

### 启用沙箱

**Slash command**：
```
/sandbox
```

**CLI flags**：
```bash
claude --sandbox       # 启用沙箱
claude --no-sandbox    # 禁用沙箱
```

### 配置项

| Setting | Description |
|---------|-------------|
| `sandbox.enabled` | 启用或禁用沙箱 |
| `sandbox.failIfUnavailable` | 如果无法启用沙箱则直接失败 |
| `sandbox.filesystem.allowWrite` | 允许写入的路径 |
| `sandbox.filesystem.allowRead` | 允许读取的路径 |
| `sandbox.filesystem.denyRead` | 禁止读取的路径 |
| `sandbox.enableWeakerNetworkIsolation` | 在 macOS 上启用较弱的网络隔离 |

### 配置示例

```json
{
  "sandbox": {
    "enabled": true,
    "failIfUnavailable": true,
    "filesystem": {
      "allowWrite": ["/Users/me/project"],
      "allowRead": ["/Users/me/project", "/usr/local/lib"],
      "denyRead": ["/Users/me/.ssh", "/Users/me/.aws"]
    },
    "enableWeakerNetworkIsolation": true
  }
}
```

### 工作方式

- Bash 命令会在沙箱环境中执行，并受到文件系统访问限制
- 网络访问也可以隔离，以避免意外的外部连接
- 它与权限规则配合使用，形成纵深防御
- 在 macOS 上，可通过 `sandbox.enableWeakerNetworkIsolation` 启用网络限制（macOS 不支持完整网络隔离）

### 使用场景

- 安全运行不受信任或自动生成的代码
- 防止误修改项目外部文件
- 在自动化任务中限制网络访问

---

## 托管设置（企业版）

Managed Settings 允许企业管理员使用平台原生管理工具，将 Claude Code 配置部署到整个组织范围内。

### 部署方式

| Platform | Method | Since |
|----------|--------|-------|
| macOS | 托管 plist 文件（MDM） | v2.1.51+ |
| Windows | Windows Registry | v2.1.51+ |
| Cross-platform | 托管配置文件 | v2.1.51+ |
| Cross-platform | 托管 drop-ins（`managed-settings.d/` 目录） | v2.1.83+ |

### Managed Drop-ins

从 v2.1.83 起，管理员可以在 `managed-settings.d/` 目录中部署多个托管设置文件。系统会按字母顺序合并这些文件，从而支持在组织内按模块管理配置：

```
~/.claude/managed-settings.d/
  00-org-defaults.json
  10-team-policies.json
  20-project-overrides.json
```

### 可用托管设置

| Setting | Description |
|---------|-------------|
| `disableBypassPermissionsMode` | 禁止用户启用 bypass permissions |
| `availableModels` | 限制用户可选模型 |
| `allowedChannelPlugins` | 控制允许哪些 channel plugin |
| `autoMode.environment` | 配置 auto mode 的可信基础设施 |
| Custom policies | 组织自定义的权限与工具策略 |

### 示例：macOS Plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>disableBypassPermissionsMode</key>
  <true/>
  <key>availableModels</key>
  <array>
    <string>claude-sonnet-4-6</string>
    <string>claude-haiku-4-5</string>
  </array>
</dict>
</plist>
```

---

## 配置与设置

### 配置文件位置

1. **全局配置**：`~/.claude/config.json`
2. **项目配置**：`./.claude/config.json`
3. **用户配置**：`~/.config/claude-code/settings.json`

### 完整配置示例

**核心高级特性配置：**

```json
{
  "permissions": {
    "mode": "default"
  },
  "hooks": {
    "PreToolUse:Edit": "eslint --fix ${file_path}",
    "PostToolUse:Write": "~/.claude/hooks/security-scan.sh"
  },
  "mcp": {
    "enabled": true,
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"]
      }
    }
  }
}
```

**扩展示例配置：**

```json
{
  "permissions": {
    "mode": "default",
    "allowedTools": ["Bash(git log:*)", "Read"],
    "disallowedTools": ["Bash(rm -rf:*)"]
  },

  "hooks": {
    "PreToolUse": [{ "matcher": "Edit", "hooks": ["eslint --fix ${file_path}"] }],
    "PostToolUse": [{ "matcher": "Write", "hooks": ["~/.claude/hooks/security-scan.sh"] }],
    "Stop": [{ "hooks": ["~/.claude/hooks/notify.sh"] }]
  },

  "mcp": {
    "enabled": true,
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"],
        "env": {
          "GITHUB_TOKEN": "${GITHUB_TOKEN}"
        }
      }
    }
  }
}
```

### 环境变量

用环境变量覆盖配置：

```bash
# 模型选择
export ANTHROPIC_MODEL=claude-opus-4-6
export ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-6
export ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-6
export ANTHROPIC_DEFAULT_HAIKU_MODEL=claude-haiku-4-5

# API 配置
export ANTHROPIC_API_KEY=sk-ant-...

# Thinking 配置
export MAX_THINKING_TOKENS=16000
export CLAUDE_CODE_EFFORT_LEVEL=high

# 功能开关
export CLAUDE_CODE_DISABLE_AUTO_MEMORY=true
export CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=true
export CLAUDE_CODE_DISABLE_CRON=1
export CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS=true
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=true
export CLAUDE_CODE_DISABLE_1M_CONTEXT=true
export CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=true
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
export CLAUDE_CODE_ENABLE_TASKS=true
export CLAUDE_CODE_SIMPLE=true              # 由 --bare 参数设置

# MCP 配置
export MAX_MCP_OUTPUT_TOKENS=50000
export ENABLE_TOOL_SEARCH=true

# 任务管理
export CLAUDE_CODE_TASK_LIST_ID=my-project-tasks

# Agent teams（实验性）
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true

# Subagent 和 plugin 配置
export CLAUDE_CODE_SUBAGENT_MODEL=sonnet
export CLAUDE_CODE_PLUGIN_SEED_DIR=./my-plugins
export CLAUDE_CODE_NEW_INIT=true

# 子进程与流式输出
export CLAUDE_CODE_SUBPROCESS_ENV_SCRUB="SECRET_KEY,DB_PASSWORD"
export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=80
export CLAUDE_STREAM_IDLE_TIMEOUT_MS=30000
export ANTHROPIC_CUSTOM_MODEL_OPTION=my-custom-model
export SLASH_COMMAND_TOOL_CHAR_BUDGET=50000
```

### 配置管理命令

```
User: /config
[打开交互式配置菜单]
```

`/config` 命令会提供一个交互式菜单，用来切换以下设置：
- 扩展思考开/关
- Verbose 输出
- 权限模式
- 模型选择

### 项目级配置

在项目中创建 `.claude/config.json`：

```json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": ["npm test && npm run lint"] }]
  },
  "permissions": {
    "mode": "default"
  },
  "mcp": {
    "servers": {
      "project-db": {
        "command": "mcp-postgres",
        "env": {
          "DATABASE_URL": "${PROJECT_DB_URL}"
        }
      }
    }
  }
}
```

---

## 最佳实践

### 规划模式
- ✅ 用于复杂、多步骤任务
- ✅ 在批准前先审查计划
- ✅ 需要时修改计划
- ❌ 不要用于简单任务

### 扩展思考
- ✅ 用于架构决策
- ✅ 用于复杂问题求解
- ✅ 查看推理过程
- ❌ 不要用于简单查询

### 后台任务
- ✅ 用于长时间运行的操作
- ✅ 监控任务进度
- ✅ 优雅处理任务失败
- ❌ 不要启动过多并发任务

### 权限
- ✅ 代码评审用 `plan`（只读）
- ✅ 交互式开发用 `default`
- ✅ 自动化工作流可用 `acceptEdits`
- ✅ 需要安全护栏的自主工作可用 `auto`
- ❌ 除非绝对必要，否则不要用 `bypassPermissions`

### 会话
- ✅ 不同任务使用不同会话
- ✅ 保存重要会话状态
- ✅ 清理旧会话
- ❌ 不要把不相关工作混在同一个会话里

---

## 更多资源

如果你想进一步了解 Claude Code 及相关特性：

- [Official Interactive Mode Documentation](https://code.claude.com/docs/en/interactive-mode)
- [Official Headless Mode Documentation](https://code.claude.com/docs/en/headless)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Checkpoints Guide](../08-checkpoints/) - 会话管理与回退
- [Slash Commands](../01-slash-commands/) - 命令参考
- [Memory Guide](../02-memory/) - 持久上下文
- [Skills Guide](../03-skills/) - 自主能力
- [Subagents Guide](../04-subagents/) - 委派式任务执行
- [MCP Guide](../05-mcp/) - 外部数据接入
- [Hooks Guide](../06-hooks/) - 事件驱动自动化
- [Plugins Guide](../07-plugins/) - 打包式扩展
- [Official Scheduled Tasks Documentation](https://code.claude.com/docs/en/scheduled-tasks)
- [Official Chrome Integration Documentation](https://code.claude.com/docs/en/chrome)
- [Official Remote Control Documentation](https://code.claude.com/docs/en/remote-control)
- [Official Keybindings Documentation](https://code.claude.com/docs/en/keybindings)
- [Official Desktop App Documentation](https://code.claude.com/docs/en/desktop)
