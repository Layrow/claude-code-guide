<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-code-guide-logo-dark.svg">
  <img alt="Claude Code Guide" src="resources/logos/claude-code-guide-logo.svg">
</picture>

# Claude Code 示例完整索引

本文档按功能类别整理了所有示例文件的完整索引。

## 汇总统计

- **Total Files**：100+ 个文件
- **Categories**：10 个功能分类
- **Plugins**：3 个完整 plugins
- **Skills**：6 个完整 skills
- **Hooks**：8 个 hook 示例
- **Ready to Use**：全部示例均可直接使用

---

## 01. Slash Commands（10 个文件）

由用户手动调用的快捷命令，用于处理常见工作流。

| File | Description | Use Case |
|------|-------------|----------|
| `optimize.md` | 代码优化分析器 | 发现性能问题 |
| `pr.md` | Pull request 准备 | PR 工作流自动化 |
| `generate-api-docs.md` | API 文档生成器 | 生成 API 文档 |
| `commit.md` | Commit message 辅助 | 规范化提交 |
| `setup-ci-cd.md` | CI/CD 流水线搭建 | DevOps 自动化 |
| `push-all.md` | 推送所有变更 | 快速推送流程 |
| `unit-test-expand.md` | 扩展单元测试覆盖率 | 测试自动化 |
| `doc-refactor.md` | 文档重构 | 文档改进 |
| `pr-slash-command.png` | 截图示例 | 可视化参考 |
| `README.md` | 文档 | 配置与使用指南 |

**Installation Path**：`.claude/commands/`

**Usage**：`/optimize`、`/pr`、`/generate-api-docs`、`/commit`、`/setup-ci-cd`、`/push-all`、`/unit-test-expand`、`/doc-refactor`

---

## 02. Memory（6 个文件）

持久上下文与项目规范。

| File | Description | Scope | Location |
|------|-------------|-------|----------|
| `project-CLAUDE.md` | 团队项目规范 | Project-wide | `./CLAUDE.md` |
| `directory-api-CLAUDE.md` | API 专属规则 | Directory | `./src/api/CLAUDE.md` |
| `personal-CLAUDE.md` | 个人偏好 | User | `~/.claude/CLAUDE.md` |
| `memory-saved.png` | 截图：memory 已保存 | - | 可视化参考 |
| `memory-ask-claude.png` | 截图：向 Claude 提问 | - | 可视化参考 |
| `README.md` | 文档 | - | 参考说明 |

**Installation**：复制到对应位置

**Usage**：Claude 自动加载

---

## 03. Skills（28 个文件）

带脚本与模板、会自动调用的能力模块。

### Code Review Skill（5 个文件）
```
code-review/
├── SKILL.md                          # Skill 定义
├── scripts/
│   ├── analyze-metrics.py            # 代码指标分析器
│   └── compare-complexity.py         # 复杂度对比
└── templates/
    ├── review-checklist.md           # Review 清单
    └── finding-template.md           # Finding 文档模板
```

**Purpose**：提供包含安全、性能与质量分析的综合代码评审能力

**Auto-invoked**：在执行代码评审时自动调用

---

### Brand Voice Skill（4 个文件）
```
brand-voice/
├── SKILL.md                          # Skill 定义
├── templates/
│   ├── email-template.txt            # 邮件模板
│   └── social-post-template.txt      # 社交媒体模板
└── tone-examples.md                  # 示例文案
```

**Purpose**：确保沟通内容中的品牌语气保持一致

**Auto-invoked**：在撰写营销文案时自动调用

---

### Documentation Generator Skill（2 个文件）
```
doc-generator/
├── SKILL.md                          # Skill 定义
└── generate-docs.py                  # Python 文档提取器
```

**Purpose**：从源代码中生成完整 API 文档

**Auto-invoked**：在创建或更新 API 文档时自动调用

---

### Refactor Skill（5 个文件）
```
refactor/
├── SKILL.md                          # Skill 定义
├── scripts/
│   ├── analyze-complexity.py         # 复杂度分析器
│   └── detect-smells.py              # Code smell 检测器
├── references/
│   ├── code-smells.md                # Code smells 目录
│   └── refactoring-catalog.md        # 重构模式目录
└── templates/
    └── refactoring-plan.md           # 重构计划模板
```

**Purpose**：基于复杂度分析进行系统化代码重构

**Auto-invoked**：在进行代码重构时自动调用

---

### Claude MD Skill（1 个文件）
```
claude-md/
└── SKILL.md                          # Skill 定义
```

**Purpose**：管理并优化 CLAUDE.md 文件

---

### Blog Draft Skill（3 个文件）
```
blog-draft/
├── SKILL.md                          # Skill 定义
└── templates/
    ├── draft-template.md             # 博客草稿模板
    └── outline-template.md           # 博客提纲模板
```

**Purpose**：使用统一结构起草博客文章

**Plus**：`README.md` - Skills 总览与使用指南

**Installation Path**：`~/.claude/skills/` 或 `.claude/skills/`

---

## 04. Subagents（9 个文件）

具备专用能力的 AI 助手。

| File | Description | Tools | Use Case |
|------|-------------|-------|----------|
| `code-reviewer.md` | 代码质量分析 | read、grep、diff、lint_runner | 综合评审 |
| `test-engineer.md` | 测试覆盖率分析 | read、write、bash、grep | 测试自动化 |
| `documentation-writer.md` | 文档编写 | read、write、grep | 文档生成 |
| `secure-reviewer.md` | 安全评审（只读） | read、grep | 安全审计 |
| `implementation-agent.md` | 完整实现 | read、write、bash、grep、edit、glob | 功能开发 |
| `debugger.md` | 调试专家 | read、bash、grep | Bug 调查 |
| `data-scientist.md` | 数据分析专家 | read、write、bash | 数据工作流 |
| `clean-code-reviewer.md` | Clean Code 标准审查 | read、grep | 代码质量 |
| `README.md` | 文档 | - | 配置与使用指南 |

**Installation Path**：`.claude/agents/`

**Usage**：由主 agent 自动委派

---

## 05. MCP Protocol（5 个文件）

外部工具与 API 集成。

| File | Description | Integrates With | Use Case |
|------|-------------|-----------------|----------|
| `github-mcp.json` | GitHub 集成 | GitHub API | PR / issue 管理 |
| `database-mcp.json` | 数据库查询 | PostgreSQL / MySQL | 实时数据查询 |
| `filesystem-mcp.json` | 文件操作 | 本地文件系统 | 文件管理 |
| `multi-mcp.json` | 多服务器配置 | GitHub + DB + Slack | 完整集成 |
| `README.md` | 文档 | - | 配置与使用指南 |

**Installation Path**：`.mcp.json`（项目级）或 `~/.claude.json`（用户级）

**Usage**：`/mcp__github__list_prs` 等

---

## 06. Hooks（9 个文件）

会自动执行的事件驱动自动化脚本。

| File | Description | Event | Use Case |
|------|-------------|-------|----------|
| `format-code.sh` | 自动格式化代码 | PreToolUse:Write | 代码格式化 |
| `pre-commit.sh` | 提交前运行测试 | PreToolUse:Bash | 测试自动化 |
| `security-scan.sh` | 安全扫描 | PostToolUse:Write | 安全检查 |
| `log-bash.sh` | 记录 bash 命令 | PostToolUse:Bash | 命令日志 |
| `validate-prompt.sh` | 校验 prompts | PreToolUse | 输入校验 |
| `notify-team.sh` | 发送通知 | Notification | 团队通知 |
| `context-tracker.py` | 追踪上下文窗口使用 | PostToolUse | 上下文监控 |
| `context-tracker-tiktoken.py` | 基于 token 的上下文追踪 | PostToolUse | 精确 token 统计 |
| `README.md` | 文档 | - | 配置与使用指南 |

**Installation Path**：在 `~/.claude/settings.json` 中配置

**Usage**：在 settings 中配置后自动执行

**Hook Types**（4 类，25 个事件）：
- Tool Hooks：PreToolUse、PostToolUse、PostToolUseFailure、PermissionRequest
- Session Hooks：SessionStart、SessionEnd、Stop、StopFailure、SubagentStart、SubagentStop
- Task Hooks：UserPromptSubmit、TaskCompleted、TaskCreated、TeammateIdle
- Lifecycle Hooks：ConfigChange、CwdChanged、FileChanged、PreCompact、PostCompact、WorktreeCreate、WorktreeRemove、Notification、InstructionsLoaded、Elicitation、ElicitationResult

---

## 07. Plugins（3 个完整插件，40 个文件）

打包好的功能集合。

### PR Review Plugin（10 个文件）
```
pr-review/
├── .claude-plugin/
│   └── plugin.json                   # Plugin manifest
├── commands/
│   ├── review-pr.md                  # 全面评审
│   ├── check-security.md             # 安全检查
│   └── check-tests.md                # 测试覆盖率检查
├── agents/
│   ├── security-reviewer.md          # 安全专家
│   ├── test-checker.md               # 测试专家
│   └── performance-analyzer.md       # 性能专家
├── mcp/
│   └── github-config.json            # GitHub 集成
├── hooks/
│   └── pre-review.js                 # 评审前校验
└── README.md                         # Plugin 文档
```

**Features**：安全分析、测试覆盖率、性能影响分析

**Commands**：`/review-pr`、`/check-security`、`/check-tests`

**Installation**：`/plugin install pr-review`

---

### DevOps Automation Plugin（15 个文件）
```
devops-automation/
├── .claude-plugin/
│   └── plugin.json                   # Plugin manifest
├── commands/
│   ├── deploy.md                     # 部署
│   ├── rollback.md                   # 回滚
│   ├── status.md                     # 系统状态
│   └── incident.md                   # 事故响应
├── agents/
│   ├── deployment-specialist.md      # 部署专家
│   ├── incident-commander.md         # 事故协调者
│   └── alert-analyzer.md             # 告警分析器
├── mcp/
│   └── kubernetes-config.json        # Kubernetes 集成
├── hooks/
│   ├── pre-deploy.js                 # 部署前检查
│   └── post-deploy.js                # 部署后任务
├── scripts/
│   ├── deploy.sh                     # 部署自动化
│   ├── rollback.sh                   # 回滚自动化
│   └── health-check.sh               # 健康检查
└── README.md                         # Plugin 文档
```

**Features**：Kubernetes 部署、回滚、监控、事故响应

**Commands**：`/deploy`、`/rollback`、`/status`、`/incident`

**Installation**：`/plugin install devops-automation`

---

### Documentation Plugin（14 个文件）
```
documentation/
├── .claude-plugin/
│   └── plugin.json                   # Plugin manifest
├── commands/
│   ├── generate-api-docs.md          # API 文档生成
│   ├── generate-readme.md            # README 创建
│   ├── sync-docs.md                  # 文档同步
│   └── validate-docs.md              # 文档校验
├── agents/
│   ├── api-documenter.md             # API 文档专家
│   ├── code-commentator.md           # 代码注释专家
│   └── example-generator.md          # 示例生成器
├── mcp/
│   └── github-docs-config.json       # GitHub 集成
├── templates/
│   ├── api-endpoint.md               # API endpoint 模板
│   ├── function-docs.md              # 函数文档模板
│   └── adr-template.md               # ADR 模板
└── README.md                         # Plugin 文档
```

**Features**：API 文档、README 生成、文档同步与校验

**Commands**：`/generate-api-docs`、`/generate-readme`、`/sync-docs`、`/validate-docs`

**Installation**：`/plugin install documentation`

**Plus**：`README.md` - Plugins 总览与使用指南

---

## 08. Checkpoints and Rewind（2 个文件）

保存对话状态，并探索备选方案。

| File | Description | Content |
|------|-------------|---------|
| `README.md` | 文档 | 完整 checkpoint 指南 |
| `checkpoint-examples.md` | 真实案例 | 数据库迁移、性能优化、UI 迭代、调试 |
| | | |

**Key Concepts**：
- **Checkpoint**：对话状态快照
- **Rewind**：返回到之前的 checkpoint
- **Branch Point**：探索多种方案

**Usage**：
```
# 每次用户输入时都会自动创建 checkpoint
# 要回退，请按两次 Esc 或使用：
/rewind
# 然后选择：Restore code and conversation、Restore conversation、
# Restore code、Summarize from here，或 Never mind
```

**Use Cases**：
- 尝试不同实现方式
- 从错误中恢复
- 安全试验
- 对比不同方案
- A/B 测试

---

## 09. Advanced Features（3 个文件）

面向复杂工作流的高级能力。

| File | Description | Features |
|------|-------------|----------|
| `README.md` | 完整指南 | 全部高级能力文档 |
| `config-examples.json` | 配置示例 | 10+ 个场景化配置 |
| `planning-mode-examples.md` | Planning 示例 | REST API、数据库迁移、重构 |
| Scheduled Tasks | 通过 `/loop` 和 cron 工具实现周期任务 | 自动化周期工作流 |
| Chrome Integration | 基于 headless Chromium 的浏览器自动化 | Web 测试与抓取 |
| Remote Control (expanded) | 连接方式、安全性、对比表 | 远程会话管理 |
| Keyboard Customization | 自定义快捷键、chord 支持、上下文模式 | 个性化快捷操作 |
| Desktop App (expanded) | Connectors、launch.json、企业能力 | 桌面集成 |
| | | |

**Advanced Features Covered**：

### Planning Mode
- 创建详细实施计划
- 时间预估与风险评估
- 系统化任务拆解

### Extended Thinking
- 针对复杂问题进行深度推理
- 架构决策分析
- 权衡取舍评估

### Background Tasks
- 在不阻塞当前会话的情况下运行长任务
- 支持并行开发工作流
- 任务管理与监控

### Permission Modes
- **default**：高风险动作前请求批准
- **acceptEdits**：自动接受文件编辑，其余仍会询问
- **plan**：只读分析，不做修改
- **auto**：自动放行安全操作，对高风险动作进行提示
- **dontAsk**：接受所有非高风险操作
- **bypassPermissions**：全部接受（需要 `--dangerously-skip-permissions`）

### Headless Mode（`claude -p`）
- CI/CD 集成
- 自动化任务执行
- 批处理

### Session Management
- 多工作会话
- 会话切换与保存
- 会话持久化

### Interactive Features
- 快捷键
- 命令历史
- Tab 补全
- 多行输入

### Configuration
- 完整的设置管理
- 环境级配置
- 项目级自定义

### Scheduled Tasks
- 使用 `/loop` 配置周期任务
- Cron 工具：CronCreate、CronList、CronDelete
- 自动化的重复性工作流

### Chrome Integration
- 基于 headless Chromium 的浏览器自动化
- Web 测试与抓取能力
- 页面交互与数据提取

### Remote Control（扩展）
- 连接方式与协议
- 安全考虑与最佳实践
- 远程访问方案对比表

### Keyboard Customization
- 自定义快捷键配置
- 多键组合（chord）支持
- 上下文感知的快捷键激活

### Desktop App（扩展）
- IDE 集成 connectors
- launch.json 配置
- 企业部署能力

---

## 10. CLI Usage（1 个文件）

命令行界面的使用模式与参考。

| File | Description | Content |
|------|-------------|---------|
| `README.md` | CLI 文档 | 参数、选项与使用模式 |

**Key CLI Features**：
- `claude` - 启动交互式会话
- `claude -p "prompt"` - Headless / 非交互模式
- `claude web` - 启动 web session
- `claude --model` - 选择模型（Sonnet 4.6、Opus 4.6）
- `claude --permission-mode` - 设置 permission mode
- `claude --remote` - 通过 WebSocket 启用 remote control

---

## Documentation Files（13 个文件）

| File | Location | Description |
|------|----------|-------------|
| `README.md` | `/` | 主入口总览 |
| `INDEX.md` | `/` | 当前这份完整索引 |
| `QUICK_REFERENCE.md` | `/` | 速查卡 |
| `README.md` | `/01-slash-commands/` | Slash commands 指南 |
| `README.md` | `/02-memory/` | Memory 指南 |
| `README.md` | `/03-skills/` | Skills 指南 |
| `README.md` | `/04-subagents/` | Subagents 指南 |
| `README.md` | `/05-mcp/` | MCP 指南 |
| `README.md` | `/06-hooks/` | Hooks 指南 |
| `README.md` | `/07-plugins/` | Plugins 指南 |
| `README.md` | `/08-checkpoints/` | Checkpoints 指南 |
| `README.md` | `/09-advanced-features/` | Advanced Features 指南 |
| `README.md` | `/10-cli/` | CLI 指南 |

---

## Complete File Tree

```text
claude-code-guide/
├── README.md                                    # 主入口总览
├── INDEX.md                                     # 当前文件
├── QUICK_REFERENCE.md                           # 速查卡
├── claude_concepts_guide.md                     # 原始指南
│
├── 01-slash-commands/                           # Slash Commands
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   ├── commit.md
│   ├── setup-ci-cd.md
│   ├── push-all.md
│   ├── unit-test-expand.md
│   ├── doc-refactor.md
│   ├── pr-slash-command.png
│   └── README.md
│
├── 02-memory/                                   # Memory
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   ├── memory-saved.png
│   ├── memory-ask-claude.png
│   └── README.md
│
├── 03-skills/                                   # Skills
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-metrics.py
│   │   │   └── compare-complexity.py
│   │   └── templates/
│   │       ├── review-checklist.md
│   │       └── finding-template.md
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   ├── templates/
│   │   │   ├── email-template.txt
│   │   │   └── social-post-template.txt
│   │   └── tone-examples.md
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   ├── refactor/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-complexity.py
│   │   │   └── detect-smells.py
│   │   ├── references/
│   │   │   ├── code-smells.md
│   │   │   └── refactoring-catalog.md
│   │   └── templates/
│   │       └── refactoring-plan.md
│   ├── claude-md/
│   │   └── SKILL.md
│   ├── blog-draft/
│   │   ├── SKILL.md
│   │   └── templates/
│   │       ├── draft-template.md
│   │       └── outline-template.md
│   └── README.md
│
├── 04-subagents/                                # Subagents
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   ├── debugger.md
│   ├── data-scientist.md
│   ├── clean-code-reviewer.md
│   └── README.md
│
├── 05-mcp/                                      # MCP Protocol
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
│
├── 06-hooks/                                    # Hooks
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   ├── context-tracker.py
│   ├── context-tracker-tiktoken.py
│   └── README.md
│
├── 07-plugins/                                  # Plugins
│   ├── pr-review/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── review-pr.md
│   │   │   ├── check-security.md
│   │   │   └── check-tests.md
│   │   ├── agents/
│   │   │   ├── security-reviewer.md
│   │   │   ├── test-checker.md
│   │   │   └── performance-analyzer.md
│   │   ├── mcp/
│   │   │   └── github-config.json
│   │   ├── hooks/
│   │   │   └── pre-review.js
│   │   └── README.md
│   ├── devops-automation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── deploy.md
│   │   │   ├── rollback.md
│   │   │   ├── status.md
│   │   │   └── incident.md
│   │   ├── agents/
│   │   │   ├── deployment-specialist.md
│   │   │   ├── incident-commander.md
│   │   │   └── alert-analyzer.md
│   │   ├── mcp/
│   │   │   └── kubernetes-config.json
│   │   ├── hooks/
│   │   │   ├── pre-deploy.js
│   │   │   └── post-deploy.js
│   │   ├── scripts/
│   │   │   ├── deploy.sh
│   │   │   ├── rollback.sh
│   │   │   └── health-check.sh
│   │   └── README.md
│   ├── documentation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── generate-api-docs.md
│   │   │   ├── generate-readme.md
│   │   │   ├── sync-docs.md
│   │   │   └── validate-docs.md
│   │   ├── agents/
│   │   │   ├── api-documenter.md
│   │   │   ├── code-commentator.md
│   │   │   └── example-generator.md
│   │   ├── mcp/
│   │   │   └── github-docs-config.json
│   │   ├── templates/
│   │   │   ├── api-endpoint.md
│   │   │   ├── function-docs.md
│   │   │   └── adr-template.md
│   │   └── README.md
│   └── README.md
│
├── 08-checkpoints/                              # Checkpoints
│   ├── checkpoint-examples.md
│   └── README.md
│
├── 09-advanced-features/                        # Advanced Features
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
│
└── 10-cli/                                      # CLI Usage
    └── README.md
```

---

## 按使用场景快速开始

### 代码质量与评审
```bash
# 安装 slash command
cp 01-slash-commands/optimize.md .claude/commands/

# 安装 subagent
cp 04-subagents/code-reviewer.md .claude/agents/

# 安装 skill
cp -r 03-skills/code-review ~/.claude/skills/

# 或安装完整 plugin
/plugin install pr-review
```

### DevOps 与部署
```bash
# 安装 plugin（已包含所需全部能力）
/plugin install devops-automation
```

### 文档工作流
```bash
# 安装 slash command
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# 安装 subagent
cp 04-subagents/documentation-writer.md .claude/agents/

# 安装 skill
cp -r 03-skills/doc-generator ~/.claude/skills/

# 或安装完整 plugin
/plugin install documentation
```

### 团队规范
```bash
# 配置项目 memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 再根据团队规范进行编辑
```

### 外部集成
```bash
# 设置环境变量
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# 安装 MCP 配置（项目级）
cp 05-mcp/multi-mcp.json .mcp.json
```

### 自动化与校验
```bash
# 安装 hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 然后在 settings 中配置 hooks（~/.claude/settings.json）
# 见 06-hooks/README.md
```

### 安全试验
```bash
# 每次用户输入时都会自动创建 checkpoint
# 要回退：按 Esc+Esc 或使用 /rewind
# 然后在回退菜单中选择要恢复的内容

# 示例见 08-checkpoints/README.md
```

### 高级工作流
```bash
# 配置高级特性
# 见 09-advanced-features/config-examples.json

# 使用 planning mode
/plan Implement feature X

# 使用 permission modes
claude --permission-mode plan          # 用于代码评审（只读）
claude --permission-mode acceptEdits   # 自动接受编辑
claude --permission-mode auto          # 自动批准安全动作

# 在 CI/CD 中以 headless 模式运行
claude -p "Run tests and report results"

# 运行后台任务
Run tests in background

# 完整指南见 09-advanced-features/README.md
```

---

## 功能覆盖矩阵

| Category | Commands | Agents | MCP | Hooks | Scripts | Templates | Docs | Images | Total |
|----------|----------|--------|-----|-------|---------|-----------|------|--------|-------|
| **01 Slash Commands** | 8 | - | - | - | - | - | 1 | 1 | **10** |
| **02 Memory** | - | - | - | - | - | 3 | 1 | 2 | **6** |
| **03 Skills** | - | - | - | - | 5 | 9 | 1 | - | **28** |
| **04 Subagents** | - | 8 | - | - | - | - | 1 | - | **9** |
| **05 MCP** | - | - | 4 | - | - | - | 1 | - | **5** |
| **06 Hooks** | - | - | - | 8 | - | - | 1 | - | **9** |
| **07 Plugins** | 11 | 9 | 3 | 3 | 3 | 3 | 4 | - | **40** |
| **08 Checkpoints** | - | - | - | - | - | - | 1 | 1 | **2** |
| **09 Advanced** | - | - | - | - | - | - | 1 | 2 | **3** |
| **10 CLI** | - | - | - | - | - | - | 1 | - | **1** |

---

## 学习路径

### Beginner（第 1 周）
1. ✅ 阅读 `README.md`
2. ✅ 安装 1-2 个 slash commands
3. ✅ 创建项目 memory 文件
4. ✅ 试用基础命令

### Intermediate（第 2-3 周）
1. ✅ 配好 GitHub MCP
2. ✅ 安装一个 subagent
3. ✅ 尝试任务委派
4. ✅ 安装一个 skill

### Advanced（第 4 周及以后）
1. ✅ 安装完整 plugin
2. ✅ 创建自定义 slash commands
3. ✅ 创建自定义 subagent
4. ✅ 创建自定义 skill
5. ✅ 构建自己的 plugin

### Expert（第 5 周及以后）
1. ✅ 配置 hooks 做自动化
2. ✅ 使用 checkpoints 做试验
3. ✅ 配置 planning mode
4. ✅ 高效使用 permission modes
5. ✅ 为 CI/CD 配好 headless mode
6. ✅ 熟练使用 session management

---

## 按关键词搜索

### Performance
- `01-slash-commands/optimize.md` - 性能分析
- `04-subagents/code-reviewer.md` - 性能评审
- `03-skills/code-review/` - 性能指标分析
- `07-plugins/pr-review/agents/performance-analyzer.md` - 性能专家

### Security
- `04-subagents/secure-reviewer.md` - 安全评审
- `03-skills/code-review/` - 安全分析
- `07-plugins/pr-review/` - 安全检查

### Testing
- `04-subagents/test-engineer.md` - 测试工程师
- `07-plugins/pr-review/commands/check-tests.md` - 测试覆盖率检查

### Documentation
- `01-slash-commands/generate-api-docs.md` - API 文档命令
- `04-subagents/documentation-writer.md` - 文档编写 agent
- `03-skills/doc-generator/` - 文档生成 skill
- `07-plugins/documentation/` - 完整文档 plugin

### Deployment
- `07-plugins/devops-automation/` - 完整 DevOps 方案

### Automation
- `06-hooks/` - 事件驱动自动化
- `06-hooks/pre-commit.sh` - 提交前自动化
- `06-hooks/format-code.sh` - 自动格式化
- `09-advanced-features/` - 用于 CI/CD 的 headless mode

### Validation
- `06-hooks/security-scan.sh` - 安全校验
- `06-hooks/validate-prompt.sh` - Prompt 校验

### Experimentation
- `08-checkpoints/` - 带回退能力的安全试验
- `08-checkpoints/checkpoint-examples.md` - 真实案例

### Planning
- `09-advanced-features/planning-mode-examples.md` - Planning mode 示例
- `09-advanced-features/README.md` - Extended thinking 等内容

### Configuration
- `09-advanced-features/config-examples.json` - 配置示例

---

## 说明

- 所有示例都可以直接使用
- 请按你的具体场景进行修改
- 示例遵循 Claude Code 最佳实践
- 每个分类都有自己的 README，内含详细说明
- 脚本都包含适当的错误处理
- 模板可按需自定义

---

## 参与贡献

想补充更多示例？请按以下结构进行：
1. 创建合适的子目录
2. 增加带使用说明的 README.md
3. 遵循命名约定
4. 充分测试
5. 更新这份索引

---

**Last Updated**：2026 年 3 月  
**Total Examples**：100+ 个文件  
**Categories**：10 个功能分类  
**Hooks**：8 个自动化脚本  
**Configuration Examples**：10+ 个场景  
**Ready to Use**：全部示例可直接使用
