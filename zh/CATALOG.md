<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude Code Guide" src="resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code 功能目录

> 面向 Claude Code 全部功能的速查指南：commands、agents、skills、plugins 和 hooks。

**导航**：[Commands](#slash-commands) | [Permission Modes](#permission-modes) | [Subagents](#subagents) | [Skills](#skills) | [Plugins](#plugins) | [MCP Servers](#mcp-servers) | [Hooks](#hooks) | [Memory](#memory-files) | [New Features](#new-features-march-2026)

---

## Summary

| Feature | Built-in | Examples | Total | Reference |
|---------|----------|----------|-------|-----------|
| **Slash Commands** | 55+ | 8 | 63+ | [01-slash-commands/](01-slash-commands/) |
| **Subagents** | 6 | 10 | 16 | [04-subagents/](04-subagents/) |
| **Skills** | 5 bundled | 4 | 9 | [03-skills/](03-skills/) |
| **Plugins** | - | 3 | 3 | [07-plugins/](07-plugins/) |
| **MCP Servers** | 1 | 8 | 9 | [05-mcp/](05-mcp/) |
| **Hooks** | 25 events | 7 | 7 | [06-hooks/](06-hooks/) |
| **Memory** | 7 types | 3 | 3 | [02-memory/](02-memory/) |
| **Total** | **99** | **43** | **117** | |

---

## Slash Commands

Commands 是由用户手动触发的快捷操作，用来执行特定任务。

### Built-in Commands

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/help` | 显示帮助信息 | 入门、查看命令 |
| `/btw` | 提问旁支问题但不加入主上下文 | 快速插问 |
| `/chrome` | 配置 Chrome 集成 | 浏览器自动化 |
| `/clear` | 清空对话历史 | 重新开始、减少上下文 |
| `/diff` | 交互式 diff 查看器 | 审查变更 |
| `/config` | 查看/编辑配置 | 自定义行为 |
| `/status` | 显示会话状态 | 检查当前状态 |
| `/agents` | 列出可用 agents | 查看委派选项 |
| `/skills` | 列出可用 skills | 查看自动调用能力 |
| `/hooks` | 列出已配置 hooks | 调试自动化 |
| `/insights` | 分析会话模式 | 优化会话使用 |
| `/install-slack-app` | 安装 Claude Slack app | Slack 集成 |
| `/keybindings` | 自定义快捷键 | 按键配置 |
| `/mcp` | 列出 MCP servers | 查看外部集成 |
| `/memory` | 查看已加载的 memory 文件 | 调试上下文加载 |
| `/mobile` | 生成移动端二维码 | 手机访问 |
| `/passes` | 查看使用配额 | 订阅信息 |
| `/plugin` | 管理 plugins | 安装/移除扩展 |
| `/plan` | 进入 planning mode | 复杂实现 |
| `/rewind` | 回退到 checkpoint | 撤销修改、探索备选方案 |
| `/checkpoint` | 管理 checkpoints | 保存/恢复状态 |
| `/cost` | 显示 token 使用成本 | 监控花费 |
| `/context` | 显示上下文窗口使用情况 | 管理对话长度 |
| `/export` | 导出对话 | 保存参考记录 |
| `/extra-usage` | 配置额外使用上限 | 额度管理 |
| `/feedback` | 提交反馈或 bug 报告 | 反馈问题 |
| `/login` | 用 Anthropic 账号登录 | 解锁功能 |
| `/logout` | 登出 | 切换账号 |
| `/sandbox` | 切换 sandbox 模式 | 安全执行命令 |
| `/vim` | 切换 vim mode | 使用 Vim 风格编辑 |
| `/doctor` | 运行诊断 | 故障排查 |
| `/reload-plugins` | 重新加载已安装 plugins | Plugin 管理 |
| `/release-notes` | 显示发布说明 | 查看新功能 |
| `/remote-control` | 启用远程控制 | 远程访问 |
| `/permissions` | 管理权限 | 控制访问方式 |
| `/session` | 管理会话 | 多会话工作流 |
| `/rename` | 重命名当前会话 | 整理会话 |
| `/resume` | 恢复之前的会话 | 继续工作 |
| `/todo` | 查看/管理待办列表 | 跟踪任务 |
| `/tasks` | 查看后台任务 | 监控异步操作 |
| `/copy` | 将上一条回复复制到剪贴板 | 快速分享输出 |
| `/teleport` | 将会话转移到另一台机器 | 远程接续工作 |
| `/desktop` | 打开 Claude Desktop app | 切换到桌面界面 |
| `/theme` | 切换颜色主题 | 自定义外观 |
| `/usage` | 显示 API 使用统计 | 监控配额和成本 |
| `/fork` | Fork 当前对话 | 探索备选方案 |
| `/stats` | 显示会话统计 | 查看会话指标 |
| `/statusline` | 配置状态栏 | 自定义状态显示 |
| `/stickers` | 查看会话 stickers | 趣味奖励 |
| `/fast` | 切换快速输出模式 | 提升响应速度 |
| `/terminal-setup` | 配置终端集成 | 终端功能设置 |
| `/upgrade` | 检查更新 | 版本管理 |

### Custom Commands（示例）

| Command | Description | When to Use | Scope | Installation |
|---------|-------------|-------------|-------|--------------|
| `/optimize` | 分析代码优化空间 | 性能改进 | Project | `cp 01-slash-commands/optimize.md .claude/commands/` |
| `/pr` | 准备 pull request | 提交 PR 前 | Project | `cp 01-slash-commands/pr.md .claude/commands/` |
| `/generate-api-docs` | 生成 API 文档 | 文档化 API | Project | `cp 01-slash-commands/generate-api-docs.md .claude/commands/` |
| `/commit` | 结合上下文创建 git commit | 提交变更 | User | `cp 01-slash-commands/commit.md .claude/commands/` |
| `/push-all` | 暂存、提交并推送 | 快速发布 | User | `cp 01-slash-commands/push-all.md .claude/commands/` |
| `/doc-refactor` | 重构文档结构 | 改进文档 | Project | `cp 01-slash-commands/doc-refactor.md .claude/commands/` |
| `/setup-ci-cd` | 配置 CI/CD 流水线 | 新项目初始化 | Project | `cp 01-slash-commands/setup-ci-cd.md .claude/commands/` |
| `/unit-test-expand` | 扩展单元测试覆盖率 | 加强测试 | Project | `cp 01-slash-commands/unit-test-expand.md .claude/commands/` |

> **Scope**：`User` = 个人工作流（`~/.claude/commands/`），`Project` = 团队共享（`.claude/commands/`）

**Reference**：[01-slash-commands/](01-slash-commands/) | [Official Docs](https://code.claude.com/docs/en/interactive-mode)

**Quick Install（全部 Custom Commands）**：
```bash
cp 01-slash-commands/*.md .claude/commands/
```

---

## Permission Modes

Claude Code 支持 6 种 permission mode，用来控制工具调用的授权方式。

| Mode | Description | When to Use |
|------|-------------|-------------|
| `default` | 每次工具调用都提示 | 标准交互使用 |
| `acceptEdits` | 自动接受文件编辑，其余操作仍提示 | 可信编辑工作流 |
| `plan` | 仅允许只读工具，不可写入 | 规划与探索 |
| `auto` | 无需提示即可接受所有工具调用 | 完全自主运行（Research Preview） |
| `bypassPermissions` | 跳过所有权限检查 | CI/CD、headless 环境 |
| `dontAsk` | 跳过所有需要授权的工具 | 非交互式脚本化 |

> **Note**：`auto` mode 是 2026 年 3 月的 Research Preview 功能。`bypassPermissions` 只应在可信且受 sandbox 保护的环境中使用。

**Reference**：[Official Docs](https://code.claude.com/docs/en/permissions)

---

## Subagents

带隔离上下文、专注特定任务的专用 AI 助手。

### Built-in Subagents

| Agent | Description | Tools | Model | When to Use |
|-------|-------------|-------|-------|-------------|
| **general-purpose** | 多步骤任务、研究 | All tools | 继承当前模型 | 复杂研究、多文件任务 |
| **Plan** | 实施规划 | Read、Glob、Grep、Bash | 继承当前模型 | 架构设计、任务规划 |
| **Explore** | 代码库探索 | Read、Glob、Grep | Haiku 4.5 | 快速搜索、理解代码 |
| **Bash** | 命令执行 | Bash | 继承当前模型 | Git 操作、终端任务 |
| **statusline-setup** | 状态栏配置 | Bash、Read、Write | Sonnet 4.6 | 配置状态栏显示 |
| **Claude Code Guide** | 帮助与文档 | Read、Glob、Grep | Haiku 4.5 | 获取帮助、学习功能 |

### Subagent 配置字段

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Agent 标识符 |
| `description` | string | Agent 的职责说明 |
| `model` | string | 模型覆盖（例如 `haiku-4.5`） |
| `tools` | array | 允许使用的工具列表 |
| `effort` | string | 推理强度等级（`low`、`medium`、`high`） |
| `initialPrompt` | string | Agent 启动时注入的 system prompt |
| `disallowedTools` | array | 明确禁止该 agent 使用的工具 |

### Custom Subagents（示例）

| Agent | Description | When to Use | Scope | Installation |
|-------|-------------|-------------|-------|--------------|
| `code-reviewer` | 全面代码质量审查 | 代码评审会话 | Project | `cp 04-subagents/code-reviewer.md .claude/agents/` |
| `code-architect` | 功能架构设计 | 新功能规划 | Project | `cp 04-subagents/code-architect.md .claude/agents/` |
| `code-explorer` | 深度代码库分析 | 理解已有功能 | Project | `cp 04-subagents/code-explorer.md .claude/agents/` |
| `clean-code-reviewer` | 按 Clean Code 原则审查 | 可维护性评审 | Project | `cp 04-subagents/clean-code-reviewer.md .claude/agents/` |
| `test-engineer` | 测试策略与覆盖率 | 测试规划 | Project | `cp 04-subagents/test-engineer.md .claude/agents/` |
| `documentation-writer` | 技术文档编写 | API 文档、指南 | Project | `cp 04-subagents/documentation-writer.md .claude/agents/` |
| `secure-reviewer` | 聚焦安全的审查 | 安全审计 | Project | `cp 04-subagents/secure-reviewer.md .claude/agents/` |
| `implementation-agent` | 完整功能实现 | 功能开发 | Project | `cp 04-subagents/implementation-agent.md .claude/agents/` |
| `debugger` | 根因分析 | Bug 调查 | User | `cp 04-subagents/debugger.md .claude/agents/` |
| `data-scientist` | SQL 查询与数据分析 | 数据任务 | User | `cp 04-subagents/data-scientist.md .claude/agents/` |

> **Scope**：`User` = 个人（`~/.claude/agents/`），`Project` = 团队共享（`.claude/agents/`）

**Reference**：[04-subagents/](04-subagents/) | [Official Docs](https://code.claude.com/docs/en/sub-agents)

**Quick Install（全部 Custom Agents）**：
```bash
cp 04-subagents/*.md .claude/agents/
```

---

## Skills

带说明、脚本和模板、能够自动调用的能力模块。

### Example Skills

| Skill | Description | When Auto-Invoked | Scope | Installation |
|-------|-------------|-------------------|-------|--------------|
| `code-review` | 全面代码评审 | “Review this code”、“Check quality” | Project | `cp -r 03-skills/code-review .claude/skills/` |
| `brand-voice` | 品牌语气一致性检查 | 编写营销文案时 | Project | `cp -r 03-skills/brand-voice .claude/skills/` |
| `doc-generator` | API 文档生成器 | “Generate docs”、“Document API” | Project | `cp -r 03-skills/doc-generator .claude/skills/` |
| `refactor` | 系统化代码重构（Martin Fowler 风格） | “Refactor this”、“Clean up code” | User | `cp -r 03-skills/refactor ~/.claude/skills/` |

> **Scope**：`User` = 个人（`~/.claude/skills/`），`Project` = 团队共享（`.claude/skills/`）

### Skill 结构

```
~/.claude/skills/skill-name/
├── SKILL.md          # Skill 定义与说明
├── scripts/          # 辅助脚本
└── templates/        # 输出模板
```

### Skill Frontmatter 字段

Skills 在 `SKILL.md` 中支持 YAML frontmatter 配置：

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Skill 显示名称 |
| `description` | string | Skill 的作用说明 |
| `autoInvoke` | array | 自动调用的触发短语 |
| `effort` | string | 推理强度等级（`low`、`medium`、`high`） |
| `shell` | string | 脚本所用 shell（`bash`、`zsh`、`sh`） |

**Reference**：[03-skills/](03-skills/) | [Official Docs](https://code.claude.com/docs/en/skills)

**Quick Install（全部 Skills）**：
```bash
cp -r 03-skills/* ~/.claude/skills/
```

### Bundled Skills

| Skill | Description | When Auto-Invoked |
|-------|-------------|-------------------|
| `/simplify` | 审查代码质量 | 编写代码后 |
| `/batch` | 对多个文件运行提示词 | 批处理操作 |
| `/debug` | 调试失败测试 / 错误 | 调试会话 |
| `/loop` | 按间隔运行提示词 | 周期性任务 |
| `/claude-api` | 用 Claude API 构建应用 | API 开发 |

---

## Plugins

打包式集合，可把 commands、agents、MCP servers 和 hooks 组合在一起。

### Example Plugins

| Plugin | Description | Components | When to Use | Scope | Installation |
|--------|-------------|------------|-------------|-------|--------------|
| `pr-review` | PR review 工作流 | 3 commands、3 agents、GitHub MCP | 代码评审 | Project | `/plugin install pr-review` |
| `devops-automation` | 部署与监控 | 4 commands、3 agents、K8s MCP | DevOps 任务 | Project | `/plugin install devops-automation` |
| `documentation` | 文档生成套件 | 4 commands、3 agents、templates | 文档工作 | Project | `/plugin install documentation` |

> **Scope**：`Project` = 团队共享，`User` = 个人工作流

### Plugin 结构

```
.claude-plugin/
├── plugin.json       # Manifest file
├── commands/         # Slash commands
├── agents/           # Subagents
├── skills/           # Skills
├── mcp/              # MCP 配置
├── hooks/            # Hook 脚本
└── scripts/          # 工具脚本
```

**Reference**：[07-plugins/](07-plugins/) | [Official Docs](https://code.claude.com/docs/en/plugins)

**Plugin 管理命令**：
```bash
/plugin list              # 列出已安装 plugins
/plugin install <name>    # 安装 plugin
/plugin remove <name>     # 移除 plugin
/plugin update <name>     # 更新 plugin
```

---

## MCP Servers

Model Context Protocol servers 用于接入外部工具和 API。

### Common MCP Servers

| Server | Description | When to Use | Scope | Installation |
|--------|-------------|-------------|-------|--------------|
| **GitHub** | PR 管理、issues、代码访问 | GitHub 工作流 | Project | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| **Database** | SQL 查询、数据访问 | 数据库操作 | Project | `claude mcp add db -- npx -y @modelcontextprotocol/server-postgres` |
| **Filesystem** | 高级文件操作 | 复杂文件任务 | User | `claude mcp add fs -- npx -y @modelcontextprotocol/server-filesystem` |
| **Slack** | 团队沟通 | 通知、更新 | Project | 在 settings 中配置 |
| **Google Docs** | 文档访问 | 文档编辑、审查 | Project | 在 settings 中配置 |
| **Asana** | 项目管理 | 任务跟踪 | Project | 在 settings 中配置 |
| **Stripe** | 支付数据 | 财务分析 | Project | 在 settings 中配置 |
| **Memory** | 持久 memory | 跨会话召回 | User | 在 settings 中配置 |
| **Context7** | 库文档查询 | 获取最新文档 | Built-in | 内置 |

> **Scope**：`Project` = 团队（`.mcp.json`），`User` = 个人（`~/.claude.json`），`Built-in` = 预装

### MCP 配置示例

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Reference**：[05-mcp/](05-mcp/) | [MCP Protocol Docs](https://modelcontextprotocol.io/docs/getting-started/intro)

**Quick Install（GitHub MCP）**：
```bash
export GITHUB_TOKEN="your_token" && claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

---

## Hooks

事件驱动自动化，能够在 Claude Code 事件发生时自动执行 shell 命令。

### Hook Events

| Event | Description | When Triggered | Use Cases |
|-------|-------------|----------------|-----------|
| `SessionStart` | 会话开始 / 恢复 | 会话初始化时 | 初始化任务 |
| `InstructionsLoaded` | 说明加载完成 | 加载 CLAUDE.md 或规则文件时 | 自定义说明处理 |
| `UserPromptSubmit` | 提示词处理前 | 用户发送消息时 | 输入校验 |
| `PreToolUse` | 工具执行前 | 任何工具运行前 | 校验、日志 |
| `PermissionRequest` | 权限弹窗出现 | 敏感操作前 | 自定义审批流 |
| `PostToolUse` | 工具成功后 | 任意工具执行完成后 | 格式化、通知 |
| `PostToolUseFailure` | 工具执行失败 | 工具报错后 | 错误处理、日志 |
| `Notification` | 通知发送时 | Claude 发送通知时 | 外部告警 |
| `SubagentStart` | Subagent 启动 | Subagent 任务开始时 | 初始化子代理上下文 |
| `SubagentStop` | Subagent 结束 | Subagent 任务完成时 | 串联后续动作 |
| `Stop` | Claude 结束回复 | 响应完成时 | 清理、汇报 |
| `StopFailure` | API 错误结束当前轮次 | API 报错时 | 错误恢复、日志 |
| `TeammateIdle` | 队友 agent 空闲 | Agent team 协作中 | 分发工作 |
| `TaskCompleted` | 任务完成 | 任务标记完成时 | 任务后处理 |
| `TaskCreated` | 任务创建 | 通过 TaskCreate 创建时 | 任务跟踪、日志 |
| `ConfigChange` | 配置更新 | settings 修改时 | 响应配置变化 |
| `CwdChanged` | 工作目录变化 | 目录变更时 | 目录级初始化 |
| `FileChanged` | 被监视文件变化 | 文件变更时 | 文件监听、重建 |
| `PreCompact` | compact 之前 | 上下文压缩前 | 状态保留 |
| `PostCompact` | compact 完成后 | 压缩完成后 | 后续处理 |
| `WorktreeCreate` | Worktree 创建中 | Git worktree 创建时 | 配置 worktree 环境 |
| `WorktreeRemove` | Worktree 移除中 | Git worktree 移除时 | 清理资源 |
| `Elicitation` | MCP server 请求输入 | MCP elicitation 时 | 输入校验 |
| `ElicitationResult` | 用户响应 elicitation | 用户作出响应时 | 响应处理 |
| `SessionEnd` | 会话终止 | 会话结束时 | 清理、保存状态 |

### Example Hooks

| Hook | Description | Event | Scope | Installation |
|------|-------------|-------|-------|--------------|
| `validate-bash.py` | 命令校验 | PreToolUse:Bash | Project | `cp 06-hooks/validate-bash.py .claude/hooks/` |
| `security-scan.py` | 安全扫描 | PostToolUse:Write | Project | `cp 06-hooks/security-scan.py .claude/hooks/` |
| `format-code.sh` | 自动格式化 | PostToolUse:Write | User | `cp 06-hooks/format-code.sh ~/.claude/hooks/` |
| `validate-prompt.py` | Prompt 校验 | UserPromptSubmit | Project | `cp 06-hooks/validate-prompt.py .claude/hooks/` |
| `context-tracker.py` | 追踪上下文窗口使用 | Stop | User | `cp 06-hooks/context-tracker.py ~/.claude/hooks/` |
| `pre-commit.sh` | 提交前校验 | PreToolUse:Bash | Project | `cp 06-hooks/pre-commit.sh .claude/hooks/` |
| `log-bash.sh` | 记录命令日志 | PostToolUse:Bash | User | `cp 06-hooks/log-bash.sh ~/.claude/hooks/` |

> **Scope**：`Project` = 团队（`.claude/settings.json`），`User` = 个人（`~/.claude/settings.json`）

### Hook 配置

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "~/.claude/hooks/validate-bash.py"
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "~/.claude/hooks/format-code.sh"
      }
    ]
  }
}
```

**Reference**：[06-hooks/](06-hooks/) | [Official Docs](https://code.claude.com/docs/en/hooks)

**Quick Install（全部 Hooks）**：
```bash
mkdir -p ~/.claude/hooks && cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh
```

---

## Memory Files

在跨会话场景下会自动加载的持久上下文文件。

### Memory Types

| Type | Location | Scope | When to Use |
|------|----------|-------|-------------|
| **Managed Policy** | 组织托管策略 | Organization | 强制组织级规范 |
| **Project** | `./CLAUDE.md` | Project (team) | 团队标准、项目上下文 |
| **Project Rules** | `.claude/rules/` | Project (team) | 模块化项目规则 |
| **User** | `~/.claude/CLAUDE.md` | User (personal) | 个人偏好 |
| **User Rules** | `~/.claude/rules/` | User (personal) | 模块化个人规则 |
| **Local** | `./CLAUDE.local.md` | Local (git-ignored) | 机器特定覆盖（截至 2026 年 3 月未见于官方文档；可能属于 legacy） |
| **Auto Memory** | 自动生成 | Session | 自动捕获的洞察与修正 |

> **Scope**：`Organization` = 管理员托管，`Project` = 通过 git 与团队共享，`User` = 个人偏好，`Local` = 不提交，`Session` = 自动管理

**Reference**：[02-memory/](02-memory/) | [Official Docs](https://code.claude.com/docs/en/memory)

**Quick Install**：
```bash
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

---

## New Features (March 2026)

| Feature | Description | How to Use |
|---------|-------------|------------|
| **Remote Control** | 通过 API 远程控制 Claude Code 会话 | 使用 remote control API 以编程方式发送提示词并接收响应 |
| **Web Sessions** | 在浏览器环境中运行 Claude Code | 通过 `claude web` 或 Anthropic Console 访问 |
| **Desktop App** | Claude Code 原生桌面应用 | 使用 `/desktop` 或从 Anthropic 网站下载 |
| **Agent Teams** | 协调多个 agents 处理相关任务 | 配置会协作并共享上下文的 teammate agents |
| **Task List** | 后台任务管理与监控 | 使用 `/tasks` 查看和管理后台操作 |
| **Prompt Suggestions** | 上下文感知的命令建议 | 基于当前上下文自动出现建议 |
| **Git Worktrees** | 用于并行开发的隔离 git worktree | 使用 worktree 命令安全地并行分支工作 |
| **Sandboxing** | 提升安全性的隔离执行环境 | 用 `/sandbox` 切换；命令在受限环境中运行 |
| **MCP OAuth** | MCP servers 的 OAuth 认证 | 在 MCP server 配置中设置 OAuth 凭据以实现安全访问 |
| **MCP Tool Search** | 动态搜索和发现 MCP 工具 | 使用 tool search 查找已连接 server 中可用的 MCP 工具 |
| **Scheduled Tasks** | 用 `/loop` 和 cron 工具配置周期任务 | 使用 `/loop 5m /command` 或 CronCreate 工具 |
| **Chrome Integration** | 基于 headless Chromium 的浏览器自动化 | 使用 `--chrome` 参数或 `/chrome` 命令 |
| **Keyboard Customization** | 支持 chord 的快捷键自定义 | 使用 `/keybindings` 或编辑 `~/.claude/keybindings.json` |
| **Auto Mode** | 无需权限提示的全自主运行（Research Preview） | 使用 `--mode auto` 或 `/permissions auto`；2026 年 3 月 |
| **Channels** | 多通道通信（Telegram、Slack 等）（Research Preview） | 配置 channel plugins；2026 年 3 月 |
| **Voice Dictation** | 用语音输入 prompt | 使用麦克风图标或语音快捷键 |
| **Agent Hook Type** | Hook 可通过拉起 subagent 而非运行 shell 命令来处理 | 在 hook 配置中设置 `"type": "agent"` |
| **Prompt Hook Type** | Hook 可将 prompt 文本注入当前对话 | 在 hook 配置中设置 `"type": "prompt"` |
| **MCP Elicitation** | MCP servers 可在工具执行期间请求用户输入 | 通过 `Elicitation` 和 `ElicitationResult` hook 事件处理 |
| **WebSocket MCP Transport** | 用于 MCP server 连接的 WebSocket 传输 | 在 MCP server 配置中使用 `"transport": "websocket"` |
| **Plugin LSP Support** | 通过 plugins 集成 Language Server Protocol | 在 `plugin.json` 中配置 LSP servers 以提供编辑器能力 |
| **Managed Drop-ins** | 组织托管的 drop-in 配置（v2.1.83） | 由管理员通过托管策略配置；自动应用给所有用户 |

---

## Quick Reference Matrix

### Feature Selection Guide

| Need | Recommended Feature | Why |
|------|---------------------|-----|
| 快捷操作 | Slash Command | 手动触发、即时生效 |
| 持久上下文 | Memory | 自动加载 |
| 复杂自动化 | Skill | 自动调用 |
| 专用任务 | Subagent | 隔离上下文 |
| 外部数据 | MCP Server | 实时访问 |
| 事件自动化 | Hook | 事件触发 |
| 完整方案 | Plugin | 一站式打包 |

### Installation Priority

| Priority | Feature | Command |
|----------|---------|---------|
| 1. Essential | Memory | `cp 02-memory/project-CLAUDE.md ./CLAUDE.md` |
| 2. Daily Use | Slash Commands | `cp 01-slash-commands/*.md .claude/commands/` |
| 3. Quality | Subagents | `cp 04-subagents/*.md .claude/agents/` |
| 4. Automation | Hooks | `cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh` |
| 5. External | MCP | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| 6. Advanced | Skills | `cp -r 03-skills/* ~/.claude/skills/` |
| 7. Complete | Plugins | `/plugin install pr-review` |

---

## Complete One-Command Installation

安装本仓库中的全部示例：

```bash
# 创建目录
mkdir -p .claude/{commands,agents,skills} ~/.claude/{hooks,skills}

# 安装全部功能
cp 01-slash-commands/*.md .claude/commands/ && \
cp 02-memory/project-CLAUDE.md ./CLAUDE.md && \
cp -r 03-skills/* ~/.claude/skills/ && \
cp 04-subagents/*.md .claude/agents/ && \
cp 06-hooks/*.sh ~/.claude/hooks/ && \
chmod +x ~/.claude/hooks/*.sh
```

---

## Additional Resources

- [Official Claude Code Documentation](https://code.claude.com/docs/en/overview)
- [MCP Protocol Specification](https://modelcontextprotocol.io/specification)
- [Learning Roadmap](LEARNING-ROADMAP.md)
- [Main README](README.md)

---

**Last Updated**：2026 年 3 月
