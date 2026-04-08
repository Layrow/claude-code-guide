---
name: self-assessment
version: 2.2.0
description: 全面的 Codex 自我评估与学习路径顾问。它会运行一个覆盖 10 个特性领域的多类别测验，输出按主题拆分的技能画像，识别具体缺口，并生成带优先级的个性化学习路径。适用于用户提出 “assess my level”、“take the quiz”、“find my level”、“where should I start”、“what should I learn next”、“check my skills”、“skill check” 或 “level up” 这类请求时。
---

# Self-Assessment & Learning Path Advisor

这是一个全面的交互式评估，会衡量你在 10 个特性领域里的 Codex 熟练度，找出具体技能缺口，并生成个性化升级路径。

## Instructions

### Step 1: 欢迎语与评估模式选择

先让用户选择评估深度：

使用 AskUserQuestion，提供以下选项：
- **Quick Assessment** — "8 questions, ~2 minutes. Determines your overall level (Beginner/Intermediate/Advanced) and gives a learning path."
- **Deep Assessment** — "5 categories with detailed questions, ~5 minutes. Gives per-topic skill scores, identifies specific gaps, and builds a prioritized learning path."

如果用户选择 **Quick Assessment**，进入 Step 2A。
如果用户选择 **Deep Assessment**，进入 Step 2B。

---

### Step 2A: Quick Assessment

展示 **两道多选题**（AskUserQuestion 每题最多支持 4 个选项）：

**Question 1**（header: "Basics"）：
"第 1/2 部分：以下这些 Codex 能力，你已经具备哪些？"
Options:
1. "Start Codex and chat" — 我可以运行 `Codex` 并与它交互
2. "Created/edited AGENTS.md" — 我已经配置过项目级或用户级记忆
3. "Used 3+ slash commands" — 例如 /help、/compact、/model、/clear
4. "Created custom command/skill" — 写过 SKILL.md 或自定义命令文件

**Question 2**（header: "Advanced"）：
"第 2/2 部分：以下这些进阶能力，你已经具备哪些？"
Options:
1. "Configured an MCP server" — 例如 GitHub、数据库或其他外部数据源
2. "Set up hooks" — 在 ~/.Codex/settings.json 中配置过 hooks
3. "Created/used subagents" — 使用过 .Codex/agents/ 做任务委派
4. "Used print mode (Codex -p)" — 使用过 `Codex -p` 做无交互或 CI/CD 场景

**计分规则：**
- 总计 0-2 项 = Level 1: Beginner
- 总计 3-5 项 = Level 2: Intermediate
- 总计 6-8 项 = Level 3: Advanced

然后进入 Step 3，并把未勾选的项列为技能缺口。

---

### Step 2B: Deep Assessment

展示 5 轮问题，每轮调用一次 AskUserQuestion。每轮覆盖两个相关领域，全部使用多选。

**重要**：每题最多 4 个选项；每轮刚好 1 道题，4 个选项，覆盖 2 个主题（每个主题对应 2 个选项）。

---

**Round 1 — Slash Commands & Memory**（header: "Commands"）

"以下哪些事情你做过？可多选。"
Options:
1. "Created a custom slash command or skill" — 写过带 frontmatter 的 SKILL.md，或创建过 .Codex/commands/ 文件
2. "Used dynamic context in commands" — 在 skill/command 文件中使用过 `$ARGUMENTS`、`$0`/`$1`、反引号 `!command` 语法或 `@file` 引用
3. "Set up project + personal memory" — 同时创建过项目级 AGENTS.md 和个人级 ~/.Codex/AGENTS.md（或 Codex.local.md）
4. "Used memory hierarchy features" — 理解 7 层优先级，使用过 .Codex/rules/ 目录、路径限定规则或 @import 语法

**Round 1 计分：**
- 选项 1-2 对应 **Slash Commands**（0-2 分）
- 选项 3-4 对应 **Memory**（0-2 分）

---

**Round 2 — Skills & Hooks**（header: "Automation"）

"以下哪些事情你做过？可多选。"
Options:
1. "Installed and used an auto-invoked skill" — 一个会根据 description 自动触发、无需手动 `/command` 调用的 skill
2. "Controlled skill invocation behavior" — 在 SKILL.md frontmatter 中使用过 `disable-model-invocation`、`user-invocable` 或 `context: fork` + `agent` 字段
3. "Set up a PreToolUse or PostToolUse hook" — 配置过在工具调用前 / 后执行的 hook（例如命令校验器、自动格式化器）
4. "Used advanced hook features" — 配置过 prompt-type hooks、SKILL.md 里的 component-scoped hooks、HTTP hooks，或带自定义 JSON 输出（updatedInput、systemMessage）的 hooks

**Round 2 计分：**
- 选项 1-2 对应 **Skills**（0-2 分）
- 选项 3-4 对应 **Hooks**（0-2 分）

---

**Round 3 — MCP & Subagents**（header: "Integration"）

"以下哪些事情你做过？可多选。"
Options:
1. "Connected an MCP server and used its tools" — 例如用 GitHub MCP 处理 PR / issues，或用 database MCP 查询数据，或接入任何外部数据源
2. "Used advanced MCP features" — 用过项目级 .mcp.json、OAuth 认证、带 @mentions 的 MCP resources、Tool Search，或 `Codex mcp serve`
3. "Created or configured custom subagents" — 在 .Codex/agents/ 中定义过带自定义 tools、model 或 permissions 的 agents
4. "Used advanced subagent features" — 用过 worktree isolation、持久化 agent memory、Ctrl+B 后台任务、`Task(agent_name)` allowlist 或 agent teams

**Round 3 计分：**
- 选项 1-2 对应 **MCP**（0-2 分）
- 选项 3-4 对应 **Subagents**（0-2 分）

---

**Round 4 — Checkpoints & Advanced Features**（header: "Power User"）

"以下哪些事情你做过？可多选。"
Options:
1. "Used checkpoints for safe experimentation" — 创建过 checkpoints，使用过 Esc+Esc 或 /rewind，恢复过代码和 / 或对话，或使用过 Summarize 选项
2. "Used planning mode or extended thinking" — 通过 /plan、Shift+Tab 或 --permission-mode plan 开启 planning；通过 Alt+T / Option+T 切换 extended thinking
3. "Configured permission modes" — 通过 CLI flags、快捷键或 settings 使用过 acceptEdits、plan、dontAsk 或 bypassPermissions
4. "Used remote/desktop/web features" — 使用过 `Codex remote-control`、`Codex --remote`、`/teleport`、`/desktop` 或 `Codex -w`

**Round 4 计分：**
- 选项 1 对应 **Checkpoints**（0-1 分）
- 选项 2-4 对应 **Advanced Features**（0-3 分，最多记 2 分）

---

**Round 5 — Plugins & CLI**（header: "Mastery"）

"以下哪些事情你做过？可多选。"
Options:
1. "Installed or created a plugin" — 使用过 marketplace 中的插件，或创建过带 plugin.json manifest 的 .Codex-plugin/ 目录
2. "Used plugin advanced features" — 用过 plugin hooks、plugin MCP servers、LSP 配置、plugin namespaced commands，或用于测试的 --plugin-dir flag
3. "Used print mode in scripts or CI/CD" — 在脚本或 CI/CD 中使用过 `Codex -p`、`--output-format json`、`--max-turns`、管道输入或 GitHub Actions 集成
4. "Used advanced CLI features" — 用过 session resumption（-c/-r）、--agents、结构化输出的 --json-schema、--fallback-model、--from-pr 或批处理循环

**Round 5 计分：**
- 选项 1-2 对应 **Plugins**（0-2 分）
- 选项 3-4 对应 **CLI**（0-2 分）

---

### Step 3: 计算并展示结果

#### 3A: 对于 Quick Assessment

统计总勾选数并判定等级，然后输出：

```markdown
## Codex Skill Assessment Results

### Your Level: [Level 1: Beginner / Level 2: Intermediate / Level 3: Advanced]

You checked **N/8** items.

[One-line motivational summary based on level]

### Your Skill Profile

| Area | Status |
|------|--------|
| Basic CLI & Conversations | [Checked/Gap] |
| AGENTS.md & Memory | [Checked/Gap] |
| Slash Commands (built-in) | [Checked/Gap] |
| Custom Commands & Skills | [Checked/Gap] |
| MCP Servers | [Checked/Gap] |
| Hooks | [Checked/Gap] |
| Subagents | [Checked/Gap] |
| Print Mode & CI/CD | [Checked/Gap] |

### Identified Gaps

[For each unchecked item, provide a 1-line description of what to learn and a link to the tutorial]

### Your Personalized Learning Path

[Output the level-specific learning path — see Step 4]
```

#### 3B: 对于 Deep Assessment

根据 5 轮结果计算每个主题的分数。每个主题得分 0-2 分。然后输出：

```markdown
## Codex Skill Assessment Results

### Overall Level: [Level 1 / Level 2 / Level 3]

**Total Score: N/20 points**

[One-line motivational summary]

### Your Skill Profile

| Feature Area | Score | Mastery | Status |
|-------------|-------|---------|--------|
| Slash Commands | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| Memory | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| Skills | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| Hooks | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| MCP | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| Subagents | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| Checkpoints | N/1 | [None/Proficient] | [Learn/Mastered] |
| Advanced Features | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| Plugins | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |
| CLI | N/2 | [None/Basic/Proficient] | [Learn/Review/Mastered] |

**Mastery key:** 0 = None, 1 = Basic, 2 = Proficient

### Strength Areas
[List topics with score 2/2 — these are mastered]

### Priority Gaps (Learn Next)
[List topics with score 0 — these need attention first, ordered by dependency]

### Review Areas
[List topics with score 1/2 — basics known but advanced features not yet used]

### Your Personalized Learning Path

[Output gap-specific learning path — see Step 4]
```

**Deep Assessment 总等级计算：**
- 总分 0-6 = Level 1: Beginner
- 总分 7-13 = Level 2: Intermediate
- 总分 14-20 = Level 3: Advanced

---

### Step 4: 生成个性化学习路径

根据评估结果，生成一条**真正适配缺口**的学习路径。不要只重复泛化的等级路线，要根据用户具体情况调整。

#### 路径生成规则

1. **跳过已掌握主题**：如果某主题得分 2/2，不要再放进学习路径。
2. **按依赖顺序排序**：Slash Commands 在 Skills 前，Memory 在 Subagents 前，等等。依赖顺序如下：
   - Slash Commands（无依赖）-> Skills（依赖 Slash Commands）
   - Memory（无依赖）-> Subagents（依赖 Memory）
   - CLI Basics（无依赖）-> CLI Mastery（依赖整体能力）
   - Checkpoints（无依赖）
   - Hooks（依赖 Slash Commands）
   - MCP（无依赖）-> Plugins（依赖 MCP、Skills、Hooks）
   - Advanced Features（依赖前面所有内容）
3. **对 1/2 分主题**：推荐“深入复习”其高级部分，并链接到具体章节。
4. **估算时间**：只累计需要学习 / 复习的主题时间。
5. **分阶段组织**：把剩余主题按逻辑整理成每阶段 2-3 个主题。

#### 学习路径输出格式

```markdown
### Your Personalized Learning Path

**Estimated time**: ~N hours (adjusted for your current skills)

#### Phase 1: [Phase Name] (~N hours)
[Only if they have gaps in these areas]

**[Topic Name]** — [Learn from scratch / Deep dive into advanced features]
- Tutorial: [link to tutorial directory]
- Focus on: [specific sections/concepts they need]
- Key exercise: [one concrete exercise to do]
- You'll know it's done when: [specific success criterion]

**[Topic Name]** — ...

---

#### Phase 2: [Phase Name] (~N hours)
...

---

### Recommended Practice Projects

Based on your gaps, try these real-world exercises to solidify your learning:

1. **[Project name]**: [1-line description combining 2-3 gap topics]
2. **[Project name]**: [1-line description]
3. **[Project name]**: [1-line description]
```

#### Topic-Specific Recommendations

当某个主题是缺口时，请使用以下定向建议：

**Slash Commands (score 0)**:
- Tutorial: [01-slash-commands/](../../../01-slash-commands/)
- Focus on: 内置命令参考、创建你的第一个 SKILL.md、`$ARGUMENTS` 语法
- Key exercise: 创建一个 `/optimize` 命令并测试
- Done when: 你能创建一个带参数和动态上下文的自定义 skill

**Slash Commands (score 1 — review)**:
- Focus on: 使用 `!`backtick`` 语法做动态上下文、`@file` 引用、`disable-model-invocation` 与 `user-invocable` 的差异
- Done when: 你能创建一个会注入实时命令输出、并控制自身调用方式的 skill

**Memory (score 0)**:
- Tutorial: [02-memory/](../../../02-memory/)
- Focus on: AGENTS.md 创建、`/init` 和 `/memory` 命令、使用 `#` 前缀快速更新
- Key exercise: 创建一个记录编码规范的项目级 AGENTS.md
- Done when: Codex 能在跨会话中记住你的偏好

**Memory (score 1 — review)**:
- Focus on: 7 层优先级体系、带路径限定的 .Codex/rules/ 目录、`@import` 语法（最大深度 5）、Auto Memory 的 MEMORY.md（200 行限制）
- Done when: 你已经为不同目录拆分出模块化规则，并理解完整层级关系

**Skills (score 0)**:
- Tutorial: [03-skills/](../../../03-skills/)
- Focus on: SKILL.md 格式、通过 description 自动调用、渐进式加载（3 层）
- Key exercise: 安装 code-review skill，并验证它会自动触发
- Done when: 一个 skill 能根据对话上下文自动激活

**Skills (score 1 — review)**:
- Focus on: `context: fork` + `agent` 字段的子代理执行、`disable-model-invocation` 与 `user-invocable`、2% 上下文预算、bundled resources（scripts/、references/、assets/）
- Done when: 你能创建一个在 forked context 的 subagent 中运行的 skill

**Hooks (score 0)**:
- Tutorial: [06-hooks/](../../../06-hooks/)
- Focus on: 配置结构（matcher + hooks 数组）、PreToolUse / PostToolUse 事件、退出码（0=成功，2=阻止）、JSON 输入 / 输出格式
- Key exercise: 创建一个用于校验 Bash 命令的 PreToolUse hook
- Done when: hook 能在执行前拦截危险命令

**Hooks (score 1 — review)**:
- Focus on: 全部 25 个 hook 事件（包括 PostToolUseFailure、StopFailure、TaskCreated、CwdChanged、FileChanged、PostCompact、Elicitation、ElicitationResult）、4 种 hook 类型（command、http、prompt、agent）、SKILL.md frontmatter 中的 component-scoped hooks、带 allowedEnvVars 的 HTTP hooks，以及用于 SessionStart / CwdChanged / FileChanged 的 `CLAUDE_ENV_FILE`
- Done when: 你能创建一个基于 prompt 的 Stop hook，以及 skill 内部的 component-scoped hook

**MCP (score 0)**:
- Tutorial: [05-mcp/](../../../05-mcp/)
- Focus on: `Codex mcp add` 命令、传输类型（推荐 HTTP）、GitHub MCP 配置、环境变量展开
- Key exercise: 添加 GitHub MCP server 并查询 PR
- Done when: 你能通过 MCP 查询外部服务的实时数据

**MCP (score 1 — review)**:
- Focus on: 项目级 .mcp.json（需要团队批准）、OAuth 2.0、`@server:resource` 形式的 MCP resources、Tool Search（ENABLE_TOOL_SEARCH）、`Codex mcp serve`、输出限制（10k / 25k / 50k）
- Done when: 你已经配置好项目级 .mcp.json，并理解 Tool Search 自动模式

**Subagents (score 0)**:
- Tutorial: [04-subagents/](../../../04-subagents/)
- Focus on: agent 文件格式（.Codex/agents/*.md）、内置 agents（general-purpose、Plan、Explore）、tools / model / permissionMode 配置
- Key exercise: 创建一个 code-reviewer subagent 并测试委派
- Done when: Codex 会把代码审查任务委派给你的自定义 agent

**Subagents (score 1 — review)**:
- Focus on: worktree isolation（`isolation: worktree`）、持久化 agent memory（带作用域的 `memory` 字段）、后台 agents（Ctrl+B / Ctrl+F）、通过 `Task(agent_name)` 做 allowlist、agent teams（`--teammate-mode`）
- Done when: 你拥有一个在 worktree 隔离中运行、且带持久记忆的 subagent

**Checkpoints (score 0)**:
- Tutorial: [08-checkpoints/](../../../08-checkpoints/)
- Focus on: Esc+Esc 与 /rewind 的使用、5 种 rewind 选项（恢复代码+对话、仅恢复对话、仅恢复代码、摘要化、取消）、限制（bash 文件系统操作不会被跟踪）
- Key exercise: 做一轮实验性修改，然后 rewind 恢复
- Done when: 你能放心做实验，因为你知道随时可以回退

**Advanced Features (score 0)**:
- Tutorial: [09-advanced-features/](../../../09-advanced-features/)
- Focus on: Planning mode（/plan 或 Shift+Tab）、permission modes（5 种）、extended thinking（Alt+T 切换）
- Key exercise: 用 planning mode 设计一个功能，然后再实现
- Done when: 你能在规划模式和实现模式之间流畅切换

**Advanced Features (score 1 — review)**:
- Focus on: Remote control（`Codex remote-control`）、web sessions（`Codex --remote`）、desktop handoff（`/desktop`）、worktrees（`Codex -w`）、task lists（Ctrl+T）、企业级 managed settings
- Done when: 你能在 CLI、Web 和桌面端之间顺畅交接会话

**Plugins (score 0)**:
- Tutorial: [07-plugins/](../../../07-plugins/)
- Focus on: 插件结构（.Codex-plugin/plugin.json）、插件能打包什么（commands、agents、MCP、hooks、settings）、从 marketplace 安装
- Key exercise: 安装一个插件并查看它的组成部分
- Done when: 你理解什么时候该用 plugin，什么时候该用独立组件

**Plugins (score 1 — review)**:
- Focus on: 创建 plugin.json manifest、plugin hooks（hooks/hooks.json）、LSP 配置（.lsp.json）、`${CLAUDE_PLUGIN_ROOT}` 变量、用于测试的 --plugin-dir、marketplace 发布
- Done when: 你能为团队创建并测试一个插件

**CLI (score 0)**:
- Tutorial: [10-cli/](../../../10-cli/)
- Focus on: 交互模式 vs print mode、带管道的 `Codex -p`、`--output-format json`、会话管理（-c / -r）
- Key exercise: 把一个文件管道给 `Codex -p`，并拿到 JSON 输出
- Done when: 你能在脚本中以无交互方式使用 Codex

**CLI (score 1 — review)**:
- Focus on: 带 JSON 配置的 --agents、结构化输出的 --json-schema、--fallback-model、--from-pr、--strict-mcp-config、for 循环批处理、`Codex mcp serve`
- Done when: 你已经有一个使用 Codex 并输出结构化 JSON 的 CI/CD 脚本

---

### Step 5: 提供后续动作

展示结果后，询问用户下一步想做什么：

使用 AskUserQuestion，提供以下选项：
- **Start learning** — "Help me begin the first topic in my learning path right now"
- **Deep dive on a gap** — "Explain one of my gap areas in detail so I can learn it here"
- **Practice project** — "Set up a practice project that covers my gap areas"
- **Retake assessment** — "I want to retake the quiz (maybe the other mode)"

如果选择 **Start learning**：读取学习路径中第一个缺口教程的 README.md，并带用户完成第一项练习。
如果选择 **Deep dive on a gap**：先询问要深入哪一项缺口，再读取相应教程 README.md，并配合示例讲解关键概念。
如果选择 **Practice project**：设计一个结合 2-3 个薄弱项的小项目，并给出具体步骤。
如果选择 **Retake assessment**：回到 Step 1。

## Error Handling

### 某一轮什么都没选
该轮相关主题记 0 分，然后继续下一轮。

### 所有轮都什么都没选
判定为 Level 1: Beginner，鼓励用户从头开始学习，并输出完整的 Level 1 路线。

### 用户想重测
从 Step 1 重新开始，视为一次新的评估。

### 用户不同意评估结果
先认可用户的主观判断，然后询问他认为自己更接近哪个等级。接着输出对应等级的路径，并补一个先修项检查，确认是否遗漏关键主题。

### 用户中途询问某个具体主题
如果用户在评估过程中说出类似 “tell me about hooks” 或 “I want to learn MCP” 的话，请记录下来。展示结果时，无论该主题得分如何，都在学习路径里额外高亮它。

## Validation

### Triggering test suite

**Should trigger:**
- "assess my level"
- "take the quiz"
- "find my level"
- "where should I start"
- "what level am I"
- "learning path quiz"
- "self-assessment"
- "what should I learn next"
- "check my skills"
- "skill check"
- "level up"
- "how good am I at Codex"
- "evaluate my Codex knowledge"

**Should NOT trigger:**
- "review my code"
- "create a skill"
- "help me with MCP"
- "explain slash commands"
- "what is a checkpoint"
