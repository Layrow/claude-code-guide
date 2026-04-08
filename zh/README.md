<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude Code Guide" src="resources/logos/claude-howto-logo.svg">
</picture>

<p align="center">
  <a href="https://github.com/trending">
    <img src="https://img.shields.io/badge/GitHub-🔥%20%231%20Trending-purple?style=for-the-badge&logo=github"/>
  </a>
</p>

[![GitHub Stars](https://img.shields.io/github/stars/Layrow/claude-code-guide?style=flat&color=gold)](https://github.com/Layrow/claude-code-guide/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/Layrow/claude-code-guide?style=flat)](https://github.com/Layrow/claude-code-guide/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.2.0-brightgreen)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-2.1+-purple)](https://code.claude.com)

# 一个周末掌握 Claude Code

从只会输入 `claude`，进阶到能够编排 agents、hooks、skills 和 MCP servers。这里有可视化教程、可直接复制的模板，以及一条清晰的学习路径。

**[15 分钟开始上手](#15-分钟快速开始)** | **[先判断你的级别](#不知道从哪里开始)** | **[浏览功能目录](CATALOG.md)**

---

## 目录

- [问题是什么](#问题是什么)
- [Claude Code Guide 如何解决这个问题](#claude-code-guide-如何解决这个问题)
- [它是如何工作的](#它是如何工作的)
- [不知道从哪里开始？](#不知道从哪里开始)
- [15 分钟快速开始](#15-分钟快速开始)
- [你可以用这些能力构建什么？](#你可以用这些能力构建什么)
- [FAQ](#faq)
- [参与贡献](#参与贡献)
- [许可证](#许可证)

---

## 问题是什么

你装好了 Claude Code。你跑了几个 prompt。然后呢？

- **官方文档会介绍功能，但不会告诉你怎么把它们组合起来。** 你知道 slash commands 存在，却不知道该如何把它们和 hooks、memory、subagents 串起来，做成一个真正能省下数小时的工作流。
- **没有清晰的学习路径。** 应该先学 MCP 还是先学 hooks？先学 skills 还是 subagents？最后就变成什么都扫一眼，但什么都没真正掌握。
- **示例太基础。** 一个 “hello world” 的 slash command 并不能帮你搭出生产级代码评审流水线，更别提结合 memory、委派给专用 agents、再自动运行安全扫描了。

你实际上只用了 Claude Code 10% 的能力，但问题在于，你甚至不知道另外那 90% 在哪里。

---

## Claude Code Guide 如何解决这个问题

这不是另一份单纯的功能参考手册。它是一份 **结构化、可视化、示例驱动的指南**，会教你如何使用 Claude Code 的每一项能力，并且给你今天就能复制进项目里的真实模板。

| | Official Docs | This Guide |
|--|---------------|------------|
| **Format** | 参考型文档 | 带 Mermaid 图的可视化教程 |
| **Depth** | 功能描述 | 解释其底层工作方式 |
| **Examples** | 基础代码片段 | 可立即使用的生产级模板 |
| **Structure** | 按功能组织 | 递进式学习路径（从入门到高级） |
| **Onboarding** | 自助摸索 | 带时间预估的引导式路线图 |
| **Self-Assessment** | 没有 | 可交互测验，帮你定位短板并生成个性化路径 |

### 你会得到：

- **10 个教程模块**，覆盖 Claude Code 的所有核心能力 —— 从 slash commands 一直到自定义 agent teams
- **可复制即用的配置** —— slash commands、CLAUDE.md 模板、hook 脚本、MCP 配置、subagent 定义，以及完整 plugin bundle
- **Mermaid 图**，展示每个功能在内部是如何工作的，让你理解的不只是 *怎么做*，而是 *为什么这样做*
- **一条清晰的学习路径**，帮助你在 11-13 小时内从新手走到 power user
- **内置自我评估** —— 你可以直接在 Claude Code 中运行 `/self-assessment` 或 `/lesson-quiz hooks` 来识别短板

**[开始学习路径  ->](LEARNING-ROADMAP.md)**

---

## 它是如何工作的

### 1. 找到你的级别

先做 [self-assessment quiz](LEARNING-ROADMAP.md)，或者直接在 Claude Code 中运行 `/self-assessment`。你会根据已有基础拿到一条个性化路线图。

### 2. 按引导式路径学习

按顺序学习 10 个模块，每一章都会建立在前一章之上。你可以一边学，一边把模板直接复制进自己的项目里。

### 3. 把功能组合成工作流

真正的威力来自组合。你会学会如何把 slash commands + memory + subagents + hooks 串成自动化流水线，用来处理代码评审、部署和文档生成。

### 4. 验证你的理解

每学完一章，就运行 `/lesson-quiz [topic]`。测验会帮你定位你漏掉的点，让你能更快补齐短板。

**[15 分钟开始上手](#15-分钟快速开始)**

---

## 已被 5,900+ 位开发者采用

- **5,900+ GitHub stars**，来自每天都在用 Claude Code 的开发者
- **690+ forks** —— 很多团队已经把这份指南改造成自己的工作流文档
- **持续维护中** —— 每次 Claude Code 发布都会同步（最新版本：v2.2.0，2026 年 3 月）
- **社区驱动** —— 贡献者会把真实的生产配置回流进项目

[![Star History Chart](https://api.star-history.com/svg?repos=Layrow/claude-code-guide&type=Date)](https://star-history.com/#Layrow/claude-code-guide&Date)

---

## 不知道从哪里开始？

先做自评，或者直接按自己的级别开始：

| Level | You can... | Start here | Time |
|-------|-----------|------------|------|
| **Beginner** | 能启动 Claude Code 并开始对话 | [Slash Commands](01-slash-commands/) | ~2.5 小时 |
| **Intermediate** | 会用 CLAUDE.md 和自定义命令 | [Skills](03-skills/) | ~3.5 小时 |
| **Advanced** | 能配置 MCP servers 和 hooks | [Advanced Features](09-advanced-features/) | ~5 小时 |

**完整学习路径（共 10 个模块）：**

| Order | Module | Level | Time |
|-------|--------|-------|------|
| 1 | [Slash Commands](01-slash-commands/) | Beginner | 30 min |
| 2 | [Memory](02-memory/) | Beginner+ | 45 min |
| 3 | [Checkpoints](08-checkpoints/) | Intermediate | 45 min |
| 4 | [CLI Basics](10-cli/) | Beginner+ | 30 min |
| 5 | [Skills](03-skills/) | Intermediate | 1 hour |
| 6 | [Hooks](06-hooks/) | Intermediate | 1 hour |
| 7 | [MCP](05-mcp/) | Intermediate+ | 1 hour |
| 8 | [Subagents](04-subagents/) | Intermediate+ | 1.5 hours |
| 9 | [Advanced Features](09-advanced-features/) | Advanced | 2-3 hours |
| 10 | [Plugins](07-plugins/) | Advanced | 2 hours |

**[完整学习路线图 ->](LEARNING-ROADMAP.md)**

---

## 15 分钟快速开始

```bash
# 1. Clone 这份指南
git clone https://github.com/Layrow/claude-code-guide.git
cd claude-code-guide

# 2. 复制你的第一个 slash command
mkdir -p /path/to/your-project/.claude/commands
cp 01-slash-commands/optimize.md /path/to/your-project/.claude/commands/

# 3. 试一下 —— 在 Claude Code 里输入：
# /optimize

# 4. 想继续？配置项目 memory：
cp 02-memory/project-CLAUDE.md /path/to/your-project/CLAUDE.md

# 5. 安装一个 skill：
cp -r 03-skills/code-review ~/.claude/skills/
```

想要完整一些的配置？这里有一个 **1 小时核心上手方案**：

```bash
# Slash commands（15 分钟）
cp 01-slash-commands/*.md .claude/commands/

# Project memory（15 分钟）
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Install a skill（15 分钟）
cp -r 03-skills/code-review ~/.claude/skills/

# 周末目标：继续加 hooks、subagents、MCP 和 plugins
# 按学习路径继续做引导式搭建
```

**[查看完整安装参考](#15-分钟快速开始)**

---

## 你可以用这些能力构建什么？

| Use Case | Features You'll Combine |
|----------|------------------------|
| **自动化代码评审** | Slash Commands + Subagents + Memory + MCP |
| **团队上手与规范统一** | Memory + Slash Commands + Plugins |
| **CI/CD 自动化** | CLI Reference + Hooks + Background Tasks |
| **文档生成** | Skills + Subagents + Plugins |
| **安全审计** | Subagents + Skills + Hooks（只读模式） |
| **DevOps 流水线** | Plugins + MCP + Hooks + Background Tasks |
| **复杂重构** | Checkpoints + Planning Mode + Hooks |

---

## FAQ

**这是免费的吗？**  
是的。MIT 许可证，永久免费。你可以用于个人项目、公司项目、团队内部，只要保留许可证声明即可。

**这个项目还在维护吗？**  
持续维护中。每次 Claude Code 发布都会同步更新。当前版本：v2.2.0（2026 年 3 月），兼容 Claude Code 2.1+。

**这和官方文档有什么不同？**  
官方文档是功能参考手册；这份指南是教程，包含图示、可直接使用的模板，以及递进式学习路径。两者是互补关系：先在这里学会怎么用，再去官方文档查具体细节。

**完整学一遍需要多久？**  
整条路径大约 11-13 小时。但你在 15 分钟内就能获得第一波收益 —— 只要复制一个 slash command 模板并试一试。

**这些模板能用于 Claude Sonnet / Haiku / Opus 吗？**  
可以。所有模板都适用于 Claude Sonnet 4.6、Claude Opus 4.6 和 Claude Haiku 4.5。

**我可以参与贡献吗？**  
当然可以。请查看 [CONTRIBUTING.md](CONTRIBUTING.md)。我们欢迎新的示例、bug 修复、文档改进以及社区模板。

**我能离线阅读吗？**  
可以。运行 `uv run scripts/build_epub.py` 即可生成包含全部内容和渲染后图表的 EPUB 电子书。

---

## 今天就开始真正掌握 Claude Code

你已经装好了 Claude Code。你和 10x 生产力之间，差的只是知道该怎么真正把它用起来。这份指南给你结构化路径、可视化解释和可直接复制的模板，帮助你跨过去。

MIT 授权。永久免费。你可以 clone、fork，并把它改造成你自己的版本。

**[开始学习路径 ->](LEARNING-ROADMAP.md)** | **[浏览功能目录](CATALOG.md)** | **[15 分钟开始上手](#15-分钟快速开始)**

---

<details>
<summary>快速导航 — 全部功能</summary>

| Feature | Description | Folder |
|---------|-------------|--------|
| **Feature Catalog** | 含安装命令的完整参考 | [CATALOG.md](CATALOG.md) |
| **Slash Commands** | 用户触发的快捷命令 | [01-slash-commands/](01-slash-commands/) |
| **Memory** | 持久上下文 | [02-memory/](02-memory/) |
| **Skills** | 可复用能力 | [03-skills/](03-skills/) |
| **Subagents** | 专用 AI 助手 | [04-subagents/](04-subagents/) |
| **MCP Protocol** | 外部工具访问 | [05-mcp/](05-mcp/) |
| **Hooks** | 事件驱动自动化 | [06-hooks/](06-hooks/) |
| **Plugins** | 打包式功能 | [07-plugins/](07-plugins/) |
| **Checkpoints** | 会话快照与回退 | [08-checkpoints/](08-checkpoints/) |
| **Advanced Features** | 规划、思考、后台任务 | [09-advanced-features/](09-advanced-features/) |
| **CLI Reference** | 命令、参数与选项 | [10-cli/](10-cli/) |
| **Blog Posts** | 真实使用案例 | [Blog Posts](https://medium.com/@luongnv89) |

</details>

<details>
<summary>功能对比</summary>

| Feature | Invocation | Persistence | Best For |
|---------|-----------|------------|----------|
| **Slash Commands** | 手动（`/cmd`） | 仅会话内 | 快捷操作 |
| **Memory** | 自动加载 | 跨会话 | 长期上下文 |
| **Skills** | 自动调用 | 文件系统 | 自动化工作流 |
| **Subagents** | 自动委派 | 隔离上下文 | 任务拆分 |
| **MCP Protocol** | 自动查询 | 实时 | 实时数据访问 |
| **Hooks** | 事件触发 | 配置化 | 自动化与校验 |
| **Plugins** | 一条命令 | 全部功能 | 完整解决方案 |
| **Checkpoints** | 手动 / 自动 | 基于会话 | 安全试验 |
| **Planning Mode** | 手动 / 自动 | 计划阶段 | 复杂实现 |
| **Background Tasks** | 手动 | 任务时长内 | 长时间运行操作 |
| **CLI Reference** | 终端命令 | 会话 / 脚本 | 自动化与脚本化 |

</details>

<details>
<summary>安装速查</summary>

```bash
# Slash Commands
cp 01-slash-commands/*.md .claude/commands/

# Memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Skills
cp -r 03-skills/code-review ~/.claude/skills/

# Subagents
cp 04-subagents/*.md .claude/agents/

# MCP
export GITHUB_TOKEN="token"
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# Hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Plugins
/plugin install pr-review

# Checkpoints（默认自动启用，可在 settings 中配置）
# 见 08-checkpoints/README.md

# Advanced Features（在 settings 中配置）
# 见 09-advanced-features/config-examples.json

# CLI Reference（无需安装）
# 使用示例见 10-cli/README.md
```

</details>

<details>
<summary>01. Slash Commands</summary>

**Location**: [01-slash-commands/](01-slash-commands/)

**What**：以 Markdown 文件形式存储、由用户手动调用的快捷命令

**Examples**：
- `optimize.md` - 代码优化分析
- `pr.md` - Pull request 准备
- `generate-api-docs.md` - API 文档生成器

**Installation**：
```bash
cp 01-slash-commands/*.md /path/to/project/.claude/commands/
```

**Usage**：
```
/optimize
/pr
/generate-api-docs
```

**Learn More**：[Discovering Claude Code Slash Commands](https://medium.com/@luongnv89/discovering-claude-code-slash-commands-cdc17f0dfb29)

</details>

<details>
<summary>02. Memory</summary>

**Location**: [02-memory/](02-memory/)

**What**：跨会话的持久上下文

**Examples**：
- `project-CLAUDE.md` - 团队共享的项目规范
- `directory-api-CLAUDE.md` - 目录级规则
- `personal-CLAUDE.md` - 个人偏好

**Installation**：
```bash
# Project memory
cp 02-memory/project-CLAUDE.md /path/to/project/CLAUDE.md

# Directory memory
cp 02-memory/directory-api-CLAUDE.md /path/to/project/src/api/CLAUDE.md

# Personal memory
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

**Usage**：Claude 会自动加载

</details>

<details>
<summary>03. Skills</summary>

**Location**: [03-skills/](03-skills/)

**What**：带说明和脚本的可复用、自动调用能力

**Examples**：
- `code-review/` - 带脚本的完整代码评审能力
- `brand-voice/` - 品牌语气一致性检查
- `doc-generator/` - API 文档生成器

**Installation**：
```bash
# Personal skills
cp -r 03-skills/code-review ~/.claude/skills/

# Project skills
cp -r 03-skills/code-review /path/to/project/.claude/skills/
```

**Usage**：在相关场景中自动调用

</details>

<details>
<summary>04. Subagents</summary>

**Location**: [04-subagents/](04-subagents/)

**What**：带隔离上下文和自定义 prompt 的专用 AI 助手

**Examples**：
- `code-reviewer.md` - 全面代码质量分析
- `test-engineer.md` - 测试策略与覆盖率
- `documentation-writer.md` - 技术文档编写
- `secure-reviewer.md` - 安全导向评审（只读）
- `implementation-agent.md` - 完整功能实现

**Installation**：
```bash
cp 04-subagents/*.md /path/to/project/.claude/agents/
```

**Usage**：由主 agent 自动委派

</details>

<details>
<summary>05. MCP Protocol</summary>

**Location**: [05-mcp/](05-mcp/)

**What**：用于访问外部工具与 API 的 Model Context Protocol

**Examples**：
- `github-mcp.json` - GitHub 集成
- `database-mcp.json` - 数据库查询
- `filesystem-mcp.json` - 文件操作
- `multi-mcp.json` - 多个 MCP servers

**Installation**：
```bash
# 设置环境变量
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# 通过 CLI 添加 MCP server
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# 或者手动加到项目 .mcp.json（见 05-mcp/ 中示例）
```

**Usage**：配置完成后，Claude 会自动获得 MCP 工具

</details>

<details>
<summary>06. Hooks</summary>

**Location**: [06-hooks/](06-hooks/)

**What**：对 Claude Code 事件自动响应的事件驱动 shell 命令

**Examples**：
- `format-code.sh` - 写入前自动格式化代码
- `pre-commit.sh` - 提交前运行测试
- `security-scan.sh` - 扫描安全问题
- `log-bash.sh` - 记录所有 bash 命令
- `validate-prompt.sh` - 校验用户提示词
- `notify-team.sh` - 在事件发生时发送通知

**Installation**：
```bash
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

在 `~/.claude/settings.json` 中配置 hooks：
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/format-code.sh"]
    }],
    "PostToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/security-scan.sh"]
    }]
  }
}
```

**Usage**：Hooks 会在对应事件发生时自动执行

**Hook Types**（4 类，25 个事件）：
- **Tool Hooks**：`PreToolUse`、`PostToolUse`、`PostToolUseFailure`、`PermissionRequest`
- **Session Hooks**：`SessionStart`、`SessionEnd`、`Stop`、`StopFailure`、`SubagentStart`、`SubagentStop`
- **Task Hooks**：`UserPromptSubmit`、`TaskCompleted`、`TaskCreated`、`TeammateIdle`
- **Lifecycle Hooks**：`ConfigChange`、`CwdChanged`、`FileChanged`、`PreCompact`、`PostCompact`、`WorktreeCreate`、`WorktreeRemove`、`Notification`、`InstructionsLoaded`、`Elicitation`、`ElicitationResult`

</details>

<details>
<summary>07. Plugins</summary>

**Location**: [07-plugins/](07-plugins/)

**What**：把 commands、agents、MCP 和 hooks 打包在一起的能力集合

**Examples**：
- `pr-review/` - 完整 PR review 工作流
- `devops-automation/` - 部署与监控
- `documentation/` - 文档生成

**Installation**：
```bash
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

**Usage**：直接使用其中打包好的 slash commands 与其他能力

</details>

<details>
<summary>08. Checkpoints and Rewind</summary>

**Location**: [08-checkpoints/](08-checkpoints/)

**What**：保存对话状态，并回退到先前时刻，以探索不同实现路径

**Key Concepts**：
- **Checkpoint**：对话状态快照
- **Rewind**：回到之前的 checkpoint
- **Branch Point**：从同一个 checkpoint 分叉探索多种方案

**Usage**：
```
# 每次用户输入前都会自动创建 checkpoint
# 要回退，请按两次 Esc 或使用：
/rewind

# 然后从以下五个选项中选择：
# 1. Restore code and conversation
# 2. Restore conversation
# 3. Restore code
# 4. Summarize from here
# 5. Never mind
```

**Use Cases**：
- 尝试不同实现方案
- 从错误中恢复
- 安全试验
- 比较备选解法
- A/B 测试不同设计

</details>

<details>
<summary>09. Advanced Features</summary>

**Location**: [09-advanced-features/](09-advanced-features/)

**What**：用于复杂工作流与自动化的高级能力

**Includes**：
- **Planning Mode** —— 编码前先生成详细计划
- **Extended Thinking** —— 用于复杂问题的深度推理（通过 `Alt+T` / `Option+T` 切换）
- **Background Tasks** —— 在不阻塞当前对话的情况下运行长任务
- **Permission Modes** —— `default`、`acceptEdits`、`plan`、`dontAsk`、`bypassPermissions`
- **Headless Mode** —— 在 CI/CD 中运行 Claude Code：`claude -p "Run tests and generate report"`
- **Session Management** —— `/resume`、`/rename`、`/fork`、`claude -c`、`claude -r`
- **Configuration** —— 在 `~/.claude/settings.json` 中自定义行为

完整配置示例见 [config-examples.json](09-advanced-features/config-examples.json)。

</details>

<details>
<summary>10. CLI Reference</summary>

**Location**: [10-cli/](10-cli/)

**What**：Claude Code 的完整命令行参考

**Quick Examples**：
```bash
# Interactive mode
claude "explain this project"

# Print mode（非交互）
claude -p "review this code"

# 处理文件内容
cat error.log | claude -p "explain this error"

# 供脚本使用的 JSON 输出
claude -p --output-format json "list functions"

# 恢复会话
claude -r "feature-auth" "continue implementation"
```

**Use Cases**：CI/CD 流水线集成、脚本自动化、批处理、多会话工作流、自定义 agent 配置

</details>

<details>
<summary>示例工作流</summary>

### 完整代码评审工作流

```markdown
# Uses: Slash Commands + Subagents + Memory + MCP

User: /review-pr

Claude:
1. 加载项目 memory（编码规范）
2. 通过 GitHub MCP 拉取 PR
3. 委派给 code-reviewer subagent
4. 委派给 test-engineer subagent
5. 汇总发现
6. 给出完整 review
```

### 自动化文档生成

```markdown
# Uses: Skills + Subagents + Memory

User: "Generate API documentation for the auth module"

Claude:
1. 加载项目 memory（文档规范）
2. 识别到文档生成请求
3. 自动调用 doc-generator skill
4. 委派给 api-documenter subagent
5. 生成带示例的完整文档
```

### DevOps 部署

```markdown
# Uses: Plugins + MCP + Hooks

User: /deploy production

Claude:
1. 运行 pre-deploy hook（校验环境）
2. 委派给 deployment-specialist subagent
3. 通过 Kubernetes MCP 执行部署
4. 监控进度
5. 运行 post-deploy hook（健康检查）
6. 回报状态
```

</details>

<details>
<summary>目录结构</summary>

```
├── 01-slash-commands/
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   └── README.md
├── 02-memory/
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   └── README.md
├── 03-skills/
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   └── templates/
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   └── templates/
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   └── README.md
├── 04-subagents/
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   └── README.md
├── 05-mcp/
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
├── 06-hooks/
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   └── README.md
├── 07-plugins/
│   ├── pr-review/
│   ├── devops-automation/
│   ├── documentation/
│   └── README.md
├── 08-checkpoints/
│   ├── checkpoint-examples.md
│   └── README.md
├── 09-advanced-features/
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
├── 10-cli/
│   └── README.md
└── README.md（当前文件）
```

</details>

<details>
<summary>最佳实践</summary>

### Do's
- 从 slash commands 这种简单能力开始
- 逐步增加功能
- 用 memory 记录团队规范
- 先在本地测试配置
- 为自定义实现写文档
- 将项目配置纳入版本控制
- 与团队共享 plugins

### Don'ts
- 不要创建重复能力
- 不要硬编码凭据
- 不要跳过文档
- 不要把简单任务过度复杂化
- 不要忽视安全最佳实践
- 不要提交敏感数据

</details>

<details>
<summary>故障排查</summary>

### 功能没有加载
1. 检查文件位置和命名
2. 校验 YAML frontmatter 语法
3. 检查文件权限
4. 确认 Claude Code 版本兼容性

### MCP 连接失败
1. 检查环境变量
2. 检查 MCP server 是否安装正确
3. 测试凭据
4. 检查网络连通性

### Subagent 没有被委派
1. 检查工具权限
2. 确认 agent 描述是否清晰
3. 查看任务复杂度是否足够
4. 单独测试 agent

</details>

<details>
<summary>测试</summary>

本项目包含完整的自动化测试：

- **Unit Tests**：使用 pytest 的 Python 单元测试（Python 3.10、3.11、3.12）
- **Code Quality**：使用 Ruff 做 lint 和格式化
- **Security**：使用 Bandit 做漏洞扫描
- **Type Checking**：使用 mypy 做静态类型分析
- **Build Verification**：测试 EPUB 生成流程
- **Coverage Tracking**：集成 Codecov

```bash
# 安装开发依赖
uv pip install -r requirements-dev.txt

# 运行全部单元测试
pytest scripts/tests/ -v

# 生成覆盖率报告
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 运行代码质量检查
ruff check scripts/
ruff format --check scripts/

# 安全扫描
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# 类型检查
mypy scripts/ --ignore-missing-imports
```

测试会在每次 push 到 `main` / `develop`，以及每次针对 `main` 的 PR 上自动运行。详细信息见 [TESTING.md](../.github/TESTING.md)。

</details>

<details>
<summary>EPUB 生成</summary>

想离线阅读这份指南？可以生成 EPUB 电子书：

```bash
uv run scripts/build_epub.py
```

这会生成 `claude-code-guide.epub`，其中包含所有内容以及渲染后的 Mermaid 图表。

更多选项见 [scripts/README.md](../scripts/README.md)。

</details>

<details>
<summary>参与贡献</summary>

如果你发现问题，或者想贡献新的示例，我们非常欢迎！

**请先阅读 [CONTRIBUTING.md](CONTRIBUTING.md)，里面详细说明了：**
- 可接受的贡献类型（示例、文档、功能、bug、反馈）
- 如何搭建开发环境
- 目录结构以及如何添加内容
- 写作规范和最佳实践
- Commit 和 PR 流程

**我们的社区标准：**
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) - 我们如何彼此相待
- [SECURITY.md](SECURITY.md) - 安全策略与漏洞报告流程

### 报告安全问题

如果你发现了安全漏洞，请负责任地报告：

1. **使用 GitHub Private Vulnerability Reporting**：https://github.com/Layrow/claude-code-guide/security/advisories
2. **或者阅读** [.github/SECURITY_REPORTING.md](../.github/SECURITY_REPORTING.md) 了解详细流程
3. **不要** 为安全漏洞创建公开 issue

快速开始：
1. Fork 并 clone 这个仓库
2. 创建描述性分支（`add/feature-name`、`fix/bug`、`docs/improvement`）
3. 按照指南进行修改
4. 提交带清晰描述的 pull request

**需要帮助？** 发起 issue 或 discussion，我们会协助你完成流程。

</details>

<details>
<summary>更多资源</summary>

- [Claude Code Documentation](https://code.claude.com/docs/en/overview)
- [MCP Protocol Specification](https://modelcontextprotocol.io/specification)
- [Skills Repository](https://github.com/luongnv89/skills) - 一组可直接使用的 skills
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)
- [Boris Cherny's Claude Code Workflow](https://x.com/bcherny/status/2007179832300581177) - Claude Code 的作者分享了他的系统化工作流：并行 agents、共享 CLAUDE.md、Plan mode、slash commands、subagents 和 verification hooks，用于支持长时间自主运行的会话。

</details>

---

## 参与贡献

欢迎贡献！请查看我们的 [Contributing Guide](CONTRIBUTING.md)，了解如何开始。

## 贡献者

感谢所有为这个项目做出贡献的人！

| Contributor | PRs |
|-------------|-----|
| [wjhrdy](https://github.com/wjhrdy) | [#1 - add a tool to create an epub](https://github.com/Layrow/claude-code-guide/pull/1) |
| [VikalpP](https://github.com/VikalpP) | [#7 - fix(docs): Use tilde fences for nested code blocks in concepts guide](https://github.com/Layrow/claude-code-guide/pull/7) |

---

## 许可证

MIT License - 详见 [LICENSE](LICENSE)。可自由使用、修改和分发，唯一要求是保留许可证声明。

---

**Last Updated**：2026 年 3 月  
**Claude Code Version**：2.1+  
**Compatible Models**：Claude Sonnet 4.6、Claude Opus 4.6、Claude Haiku 4.5
