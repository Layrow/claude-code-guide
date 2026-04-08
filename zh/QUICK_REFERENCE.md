<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-code-guide-logo-dark.svg">
  <img alt="Claude Code Guide" src="resources/logos/claude-code-guide-logo.svg">
</picture>

# Claude Code 示例速查卡

## 🚀 安装快速命令

### Slash Commands
```bash
# 安装全部
cp 01-slash-commands/*.md .claude/commands/

# 安装指定命令
cp 01-slash-commands/optimize.md .claude/commands/
```

### Memory
```bash
# 项目级 memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 个人级 memory
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

### Skills
```bash
# 个人 skills
cp -r 03-skills/code-review ~/.claude/skills/

# 项目 skills
cp -r 03-skills/code-review .claude/skills/
```

### Subagents
```bash
# 安装全部
cp 04-subagents/*.md .claude/agents/

# 安装指定 subagent
cp 04-subagents/code-reviewer.md .claude/agents/
```

### MCP
```bash
# 设置凭据
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# 安装配置（项目级）
cp 05-mcp/github-mcp.json .mcp.json

# 或用户级：添加到 ~/.claude.json
```

### Hooks
```bash
# 安装 hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 在 settings 中配置（~/.claude/settings.json）
```

### Plugins
```bash
# 从示例安装（如果已发布）
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

### Checkpoints
```bash
# 每次用户输入时都会自动创建检查点
# 要回退，请按两次 Esc 或使用：
/rewind

# 然后选择：Restore code and conversation、Restore conversation、
# Restore code、Summarize from here，或 Never mind
```

### Advanced Features
```bash
# 在 settings 中配置（.claude/settings.json）
# 参见 09-advanced-features/config-examples.json

# Planning mode
/plan Task description

# Permission modes（使用 --permission-mode 参数）
# default        - 对高风险操作请求批准
# acceptEdits    - 自动接受文件编辑，其余操作仍会询问
# plan           - 只读分析，不做修改
# dontAsk        - 接受所有非高风险操作
# auto           - 由后台分类器自动决定权限
# bypassPermissions - 接受所有操作（需要 --dangerously-skip-permissions）

# 会话管理
/resume                # 恢复之前的会话
/rename "name"         # 给当前会话命名
/fork                  # Fork 当前会话
claude -c              # 继续最近一次会话
claude -r "session"    # 按名称/ID 恢复会话
```

---

## 📋 功能速查表

| Feature | Install Path | Usage |
|---------|-------------|-------|
| **Slash Commands (55+)** | `.claude/commands/*.md` | `/command-name` |
| **Memory** | `./CLAUDE.md` | 自动加载 |
| **Skills** | `.claude/skills/*/SKILL.md` | 自动调用 |
| **Subagents** | `.claude/agents/*.md` | 自动委派 |
| **MCP** | `.mcp.json`（项目）或 `~/.claude.json`（用户） | `/mcp__server__action` |
| **Hooks (25 events)** | `~/.claude/hooks/*.sh` | 事件触发（4 种类型） |
| **Plugins** | 通过 `/plugin install` | 打包式能力集合 |
| **Checkpoints** | 内置 | `Esc+Esc` 或 `/rewind` |
| **Planning Mode** | 内置 | `/plan <task>` |
| **Permission Modes (6)** | 内置 | `--allowedTools`、`--permission-mode` |
| **Sessions** | 内置 | `/session <command>` |
| **Background Tasks** | 内置 | 在后台运行 |
| **Remote Control** | 内置 | WebSocket API |
| **Web Sessions** | 内置 | `claude web` |
| **Git Worktrees** | 内置 | `/worktree` |
| **Auto Memory** | 内置 | 自动保存到 CLAUDE.md |
| **Task List** | 内置 | `/task list` |
| **Bundled Skills (5)** | 内置 | `/simplify`、`/loop`、`/claude-api`、`/voice`、`/browse` |

---

## 🎯 常见使用场景

### 代码评审
```bash
# 方法 1：Slash command
cp 01-slash-commands/optimize.md .claude/commands/
# 使用：/optimize

# 方法 2：Subagent
cp 04-subagents/code-reviewer.md .claude/agents/
# 使用：自动委派

# 方法 3：Skill
cp -r 03-skills/code-review ~/.claude/skills/
# 使用：自动调用

# 方法 4：Plugin（最佳）
/plugin install pr-review
# 使用：/review-pr
```

### 文档生成
```bash
# Slash command
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# Subagent
cp 04-subagents/documentation-writer.md .claude/agents/

# Skill
cp -r 03-skills/doc-generator ~/.claude/skills/

# Plugin（完整方案）
/plugin install documentation
```

### DevOps
```bash
# 完整 plugin
/plugin install devops-automation

# 命令：/deploy、/rollback、/status、/incident
```

### 团队规范
```bash
# 项目级 memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 按团队需要编辑
vim CLAUDE.md
```

### 自动化与 Hooks
```bash
# 安装 hooks（25 个事件，4 种类型：command、http、prompt、agent）
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 示例：
# - 提交前测试：pre-commit.sh
# - 自动格式化代码：format-code.sh
# - 安全扫描：security-scan.sh

# Auto Mode 适合全自主工作流
claude --enable-auto-mode -p "Refactor and test the auth module"
# 或在交互模式中用 Shift+Tab 切换模式
```

### 安全重构
```bash
# 每次提示前都会自动创建检查点
# 尝试重构
# 如果成功：继续
# 如果失败：按 Esc+Esc 或用 /rewind 回退
```

### 复杂实现
```bash
# 使用 planning mode
/plan Implement user authentication system

# Claude 会生成详细计划
# 审查并批准
# Claude 再系统化实现
```

### CI/CD 集成
```bash
# 以 headless 模式运行（非交互）
claude -p "Run all tests and generate report"

# 在 CI 中指定权限模式
claude -p "Run tests" --permission-mode dontAsk

# 用 Auto Mode 执行完全自主的 CI 任务
claude --enable-auto-mode -p "Run tests and fix failures"

# 配合 hooks 做自动化
# 见 09-advanced-features/README.md
```

### 学习与试验
```bash
# 用 plan mode 做安全分析
claude --permission-mode plan

# 安全试验 —— 检查点会自动创建
# 如需回退：按 Esc+Esc 或使用 /rewind
```

### Agent Teams
```bash
# 启用 agent teams
export CLAUDE_AGENT_TEAMS=1

# 或在 settings.json 中配置
{ "agentTeams": { "enabled": true } }

# 这样开始："Implement feature X using a team approach"
```

### Scheduled Tasks
```bash
# 每 5 分钟运行一次命令
/loop 5m /check-status

# 一次性提醒
/loop 30m "remind me to check the deploy"
```

---

## 📁 文件位置参考

```
Your Project/
├── .claude/
│   ├── commands/              # Slash commands 放这里
│   ├── agents/                # Subagents 放这里
│   ├── skills/                # 项目级 skills 放这里
│   └── settings.json          # 项目设置（hooks 等）
├── .mcp.json                  # MCP 配置（项目级）
├── CLAUDE.md                  # 项目 memory
└── src/
    └── api/
        └── CLAUDE.md          # 目录级 memory

User Home/
├── .claude/
│   ├── commands/              # 个人 commands
│   ├── agents/                # 个人 agents
│   ├── skills/                # 个人 skills
│   ├── hooks/                 # Hook 脚本
│   ├── settings.json          # 用户设置
│   ├── managed-settings.d/    # 托管设置（企业/组织）
│   └── CLAUDE.md              # 个人 memory
└── .claude.json               # 个人 MCP 配置（用户级）
```

---

## 🔍 查找示例

### 按类别
- **Slash Commands**: `01-slash-commands/`
- **Memory**: `02-memory/`
- **Skills**: `03-skills/`
- **Subagents**: `04-subagents/`
- **MCP**: `05-mcp/`
- **Hooks**: `06-hooks/`
- **Plugins**: `07-plugins/`
- **Checkpoints**: `08-checkpoints/`
- **Advanced Features**: `09-advanced-features/`
- **CLI**: `10-cli/`

### 按使用场景
- **Performance**: `01-slash-commands/optimize.md`
- **Security**: `04-subagents/secure-reviewer.md`
- **Testing**: `04-subagents/test-engineer.md`
- **Docs**: `03-skills/doc-generator/`
- **DevOps**: `07-plugins/devops-automation/`

### 按复杂度
- **Simple**: Slash commands
- **Medium**: Subagents、Memory
- **Advanced**: Skills、Hooks
- **Complete**: Plugins

---

## 🎓 学习路径

### 第 1 天
```bash
# 阅读概览
cat README.md

# 安装一个命令
cp 01-slash-commands/optimize.md .claude/commands/

# 试一下
/optimize
```

### 第 2-3 天
```bash
# 配置 memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
vim CLAUDE.md

# 安装 subagent
cp 04-subagents/code-reviewer.md .claude/agents/
```

### 第 4-5 天
```bash
# 配置 MCP
export GITHUB_TOKEN="your_token"
cp 05-mcp/github-mcp.json .mcp.json

# 试一下 MCP 命令
/mcp__github__list_prs
```

### 第 2 周
```bash
# 安装 skill
cp -r 03-skills/code-review ~/.claude/skills/

# 让它自动调用
# 直接说："Review this code for issues"
```

### 第 3 周及以后
```bash
# 安装完整 plugin
/plugin install pr-review

# 使用打包功能
/review-pr
/check-security
/check-tests
```

---

## 新功能（2026 年 3 月）

| Feature | Description | Usage |
|---------|-------------|-------|
| **Auto Mode** | 带后台分类器的全自主运行 | `--enable-auto-mode` 参数，`Shift+Tab` 循环切换模式 |
| **Channels** | Discord 和 Telegram 集成 | `--channels` 参数，Discord/Telegram bots |
| **Voice Dictation** | 对 Claude 说出命令和上下文 | `/voice` 命令 |
| **Hooks (25 events)** | 扩展后的 hook 系统，支持 4 种类型 | command、http、prompt、agent hook types |
| **MCP Elicitation** | MCP servers 可在运行时请求用户输入 | 当 server 需要澄清时会自动提示 |
| **WebSocket MCP** | 用于 MCP 连接的 WebSocket 传输 | 在 `.mcp.json` 中配置 `ws://` URL |
| **Plugin LSP** | 为 plugins 提供 Language Server Protocol 支持 | `userConfig`、`${CLAUDE_PLUGIN_DATA}` 变量 |
| **Remote Control** | 通过 WebSocket API 控制 Claude Code | `claude --remote` 用于外部集成 |
| **Web Sessions** | 基于浏览器的 Claude Code 界面 | `claude web` 启动 |
| **Desktop App** | 原生桌面应用 | 从 claude.ai/download 下载 |
| **Task List** | 管理后台任务 | `/task list`、`/task status <id>` |
| **Auto Memory** | 从对话中自动保存 memory | Claude 会自动把关键上下文保存到 CLAUDE.md |
| **Git Worktrees** | 用于并行开发的隔离工作区 | `/worktree` 创建隔离工作区 |
| **Model Selection** | 在 Sonnet 4.6 和 Opus 4.6 间切换 | `/model` 或 `--model` |
| **Agent Teams** | 协调多个 agents 共同处理任务 | 用环境变量 `CLAUDE_AGENT_TEAMS=1` 启用 |
| **Scheduled Tasks** | 使用 `/loop` 的周期任务 | `/loop 5m /command` 或 CronCreate 工具 |
| **Chrome Integration** | 浏览器自动化 | `--chrome` 参数或 `/chrome` 命令 |
| **Keyboard Customization** | 自定义快捷键 | `/keybindings` 命令 |

---

## Tips & Tricks

### 自定义
- 先直接使用现有示例
- 再按你的需求修改
- 分享给团队前先测试
- 将你的配置纳入版本控制

### 最佳实践
- 用 memory 管理团队规范
- 用 plugins 搭建完整工作流
- 用 subagents 处理复杂任务
- 用 slash commands 处理快速任务

### 故障排查
```bash
# 检查文件位置
ls -la .claude/commands/
ls -la .claude/agents/

# 校验 YAML 语法
head -20 .claude/agents/code-reviewer.md

# 测试 MCP 连接
echo $GITHUB_TOKEN
```

---

## 📊 功能矩阵

| Need | Use This | Example |
|------|----------|---------|
| 快捷操作 | Slash Command (55+) | `01-slash-commands/optimize.md` |
| 团队规范 | Memory | `02-memory/project-CLAUDE.md` |
| 自动工作流 | Skill | `03-skills/code-review/` |
| 专用任务 | Subagent | `04-subagents/code-reviewer.md` |
| 外部数据 | MCP (+ Elicitation, WebSocket) | `05-mcp/github-mcp.json` |
| 事件自动化 | Hook (25 events, 4 types) | `06-hooks/pre-commit.sh` |
| 完整方案 | Plugin (+ LSP support) | `07-plugins/pr-review/` |
| 安全试验 | Checkpoint | `08-checkpoints/checkpoint-examples.md` |
| 完全自主 | Auto Mode | `--enable-auto-mode` 或 `Shift+Tab` |
| 聊天集成 | Channels | `--channels`（Discord、Telegram） |
| CI/CD 流水线 | CLI | `10-cli/README.md` |

---

## 🔗 快速链接

- **Main Guide**: `README.md`
- **Complete Index**: `INDEX.md`
- **Summary**: `EXAMPLES_SUMMARY.md`
- **Original Guide**: `claude_concepts_guide.md`

---

## 📞 常见问题

**Q: 我该先用哪个？**
A: 先从 slash commands 开始，再按需要逐步加功能。

**Q: 我能混合使用这些能力吗？**
A: 可以！它们可以协同工作。Memory + Commands + MCP = 很强的组合。

**Q: 怎么和团队共享？**
A: 把 `.claude/` 目录提交到 git。

**Q: 密钥怎么办？**
A: 使用环境变量，永远不要硬编码。

**Q: 我能改这些示例吗？**
A: 当然可以！它们本来就是给你定制用的模板。

---

## ✅ 清单

入门清单：

- [ ] 阅读 `README.md`
- [ ] 安装 1 个 slash command
- [ ] 试用这个命令
- [ ] 创建项目级 `CLAUDE.md`
- [ ] 安装 1 个 subagent
- [ ] 配置 1 个 MCP 集成
- [ ] 安装 1 个 skill
- [ ] 试用 1 个完整 plugin
- [ ] 按你的需要做定制
- [ ] 与团队共享

---

**快速开始**：`cat README.md`

**完整索引**：`cat INDEX.md`

**这张卡片**：放手边，随时查！
