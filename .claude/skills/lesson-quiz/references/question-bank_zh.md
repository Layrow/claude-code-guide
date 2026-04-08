# Lesson Quiz — 题库

每节课 10 道题。每道题都包含：category、question text、options（3-4 个）、correct answer、explanation 和 review section。

---

## Lesson 01: Slash Commands

### Q1
- **Category**: 概念
- **Question**: Claude Code 里的 slash commands 一共有哪四种类型？
- **Options**: A) 内置命令、skills、plugin commands、MCP prompts | B) 内置命令、自定义命令、hook commands、API prompts | C) system、user、plugin、terminal commands | D) core、extension、macro、script commands
- **Correct**: A
- **Explanation**: Claude Code 的 slash commands 包括：内置命令（例如 /help、/compact）、skills（SKILL.md 文件）、插件命令（带 plugin-name:command 命名空间）以及 MCP prompts（/mcp__server__prompt）。
- **Review**: Slash Commands 类型章节

### Q2
- **Category**: 实操
- **Question**: 如何把用户在命令后输入的全部参数传给一个 skill？
- **Options**: A) 使用 `${args}` | B) 使用 `$ARGUMENTS` | C) 使用 `$@` | D) 使用 `$INPUT`
- **Correct**: B
- **Explanation**: `$ARGUMENTS` 会捕获命令名之后的全部文本。如果你要取位置参数，可以使用 `$0`、`$1` 等。
- **Review**: 参数处理章节

### Q3
- **Category**: 概念
- **Question**: 当同名的 skill（`.claude/skills/name/SKILL.md`）和旧式 command（`.claude/commands/name.md`）同时存在时，哪个优先？
- **Options**: A) 旧式 command | B) skill | C) 谁先创建就用谁 | D) Claude 会让用户选择
- **Correct**: B
- **Explanation**: 同名时 skill 优先于旧式 command。skill 系统是对旧命令系统的覆盖升级。
- **Review**: Skill 优先级章节

### Q4
- **Category**: 实操
- **Question**: 如何把实时 shell 输出注入到一个 skill 的 prompt 中？
- **Options**: A) 使用 `$(command)` 语法 | B) 使用 `!`command``（感叹号 + 反引号）语法 | C) 使用 `@shell:command` 语法 | D) 使用 `{command}` 语法
- **Correct**: B
- **Explanation**: `!`command`` 语法会先运行 shell 命令，再把输出注入到 skill prompt 中，然后 Claude 才会看到它。
- **Review**: 动态上下文注入章节

### Q5
- **Category**: 概念
- **Question**: skill frontmatter 里的 `disable-model-invocation: true` 有什么作用？
- **Options**: A) 完全阻止 skill 运行 | B) 只允许用户手动调用（Claude 不能自动调用） | C) 从 /help 菜单中隐藏 | D) 禁用 skill 的 AI 处理
- **Correct**: B
- **Explanation**: `disable-model-invocation: true` 表示只有用户可以通过 `/command-name` 手动触发，Claude 不会自动调用。这个设置很适合部署类等带副作用的 skill。
- **Review**: 调用控制章节

### Q6
- **Category**: 实操
- **Question**: 你想创建一个只能由 Claude 自动调用、但不出现在用户 `/` 菜单中的 skill。应该设置哪个 frontmatter 字段？
- **Options**: A) `disable-model-invocation: true` | B) `user-invocable: false` | C) `hidden: true` | D) `auto-only: true`
- **Correct**: B
- **Explanation**: `user-invocable: false` 会把 skill 从用户的 slash 菜单中隐藏，但仍允许 Claude 基于上下文自动调用。
- **Review**: 调用控制矩阵

### Q7
- **Category**: 实操
- **Question**: 一个名为 "deploy" 的自定义 skill，正确的目录结构是什么？
- **Options**: A) `.claude/commands/deploy.md` | B) `.claude/skills/deploy/SKILL.md` | C) `.claude/skills/deploy.md` | D) `.claude/deploy/SKILL.md`
- **Correct**: B
- **Explanation**: skill 应该放在 `.claude/skills/` 下的一个目录中，并在目录内放置 `SKILL.md`。目录名通常就是命令名。
- **Review**: Skill 类型与位置章节

### Q8
- **Category**: 概念
- **Question**: plugin commands 如何避免与用户自定义命令发生命名冲突？
- **Options**: A) 使用 `plugin-name:command-name` 命名空间 | B) 使用特殊的 .plugin 扩展名 | C) 统一加 `p/` 前缀 | D) 自动覆盖用户命令
- **Correct**: A
- **Explanation**: 插件命令使用类似 `pr-review:check-security` 的命名空间，从而避免与用户自定义命令冲突。
- **Review**: Plugin commands 章节

### Q9
- **Category**: 实操
- **Question**: 如果你想限制一个 skill 可使用的工具，应该加哪个 frontmatter 字段？
- **Options**: A) `tools: [Read, Grep]` | B) `allowed-tools: [Read, Grep]` | C) `permissions: [Read, Grep]` | D) `restrict-tools: [Read, Grep]`
- **Correct**: B
- **Explanation**: `SKILL.md` frontmatter 中的 `allowed-tools` 可以限制这个命令能调用哪些工具。
- **Review**: Frontmatter 字段参考

### Q10
- **Category**: 概念
- **Question**: skill 中的 `@file` 语法是用来做什么的？
- **Options**: A) 导入另一个 skill | B) 引用一个文件，并把其内容包含进 prompt | C) 创建符号链接 | D) 设置文件权限
- **Correct**: B
- **Explanation**: skill 中的 `@path/to/file` 语法会把目标文件内容注入进 prompt，用于引入模板或上下文文件。
- **Review**: 文件引用章节

---

## Lesson 02: Memory

### Q1
- **Category**: 概念
- **Question**: Claude Code 的 memory hierarchy 一共有几层？最高优先级是什么？
- **Options**: A) 5 层，User Memory 最高 | B) 7 层，Managed Policy 最高 | C) 3 层，Project Memory 最高 | D) 7 层，Auto Memory 最高
- **Correct**: B
- **Explanation**: 共有 7 层：Managed Policy > Project Memory > Project Rules > User Memory > User Rules > Local Project Memory > Auto Memory。最高优先级是由管理员设置的 Managed Policy。
- **Review**: Memory hierarchy 章节

### Q2
- **Category**: 实操
- **Question**: 在对话过程中，如何快速往 memory 里新增一条规则？
- **Options**: A) 输入 `/memory add "rule text"` | B) 在消息前加 `#`（例如 `# always use TypeScript`） | C) 输入 `/rule "rule text"` | D) 使用 `@add-memory "rule text"`
- **Correct**: B
- **Explanation**: 使用 `#` 前缀可以快速加入一条规则。Claude 会继续询问你要保存到哪个 memory 层级。
- **Review**: 快速更新 memory 章节

### Q3
- **Category**: 概念
- **Question**: 在 CLAUDE.md 中，`@path/to/file` 导入的最大深度是多少？
- **Options**: A) 3 层 | B) 5 层 | C) 10 层 | D) 无限
- **Correct**: B
- **Explanation**: `@import` 语法最多支持递归导入 5 层，以避免无限循环。
- **Review**: 导入语法章节

### Q4
- **Category**: 实操
- **Question**: 如果你想让一份规则文件只作用于 `src/api/` 下的文件，应该怎么做？
- **Options**: A) 把规则写进 `src/api/CLAUDE.md` | B) 在 `.claude/rules/*.md` 文件的 YAML frontmatter 中加入 `paths: src/api/**` | C) 把文件命名为 `.claude/rules/api.md` | D) 在规则文件中使用 `@scope: src/api`
- **Correct**: B
- **Explanation**: `.claude/rules/` 下的规则文件支持 `paths:` frontmatter，可通过 glob 模式限制其生效路径。
- **Review**: Path-specific rules 章节

### Q5
- **Category**: 概念
- **Question**: Auto Memory 的 MEMORY.md 在会话开始时会自动加载多少行？
- **Options**: A) 全部行 | B) 前 100 行 | C) 前 200 行 | D) 前 500 行
- **Correct**: C
- **Explanation**: MEMORY.md 的前 200 行会在会话启动时自动加载。它引用的主题文件则按需加载。
- **Review**: Auto Memory 章节

### Q6
- **Category**: 实操
- **Question**: 你想存放“个人项目偏好”，并且这些内容**不提交到 Git**。应该使用哪个文件？
- **Options**: A) `~/.claude/CLAUDE.md` | B) `CLAUDE.local.md` | C) `.claude/rules/personal.md` | D) `.claude/memory/personal.md`
- **Correct**: B
- **Explanation**: 项目根目录下的 `CLAUDE.local.md` 用于保存“个人、项目级”的偏好，它应该被 git ignore。
- **Review**: Memory 文件位置对比

### Q7
- **Category**: 概念
- **Question**: `/init` 命令的作用是什么？
- **Options**: A) 从零初始化一个新的 Claude Code 项目 | B) 根据你的项目结构生成一个模板 CLAUDE.md | C) 把所有 memory 重置为默认值 | D) 创建一个新会话
- **Correct**: B
- **Explanation**: `/init` 会分析当前项目，并生成一个带推荐规则和标准的模板 CLAUDE.md。它通常用于初始化阶段。
- **Review**: /init 命令章节

### Q8
- **Category**: 实操
- **Question**: 如何完全禁用 Auto Memory？
- **Options**: A) 删除 `~/.claude/projects` 目录 | B) 设置 `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` | C) 在 CLAUDE.md 中加入 `auto-memory: false` | D) 使用 `/memory disable auto`
- **Correct**: B
- **Explanation**: 设置 `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` 会关闭 auto memory；设置为 `0` 则强制开启；不设置则按默认行为处理。
- **Review**: Auto Memory 配置章节

### Q9
- **Category**: 概念
- **Question**: 较低优先级的 memory 层，能否覆盖更高优先级层里的规则？
- **Options**: A) 可以，最近添加的规则总是生效 | B) 不可以，高优先级永远优先 | C) 可以，只要低优先级规则用了 `!important` | D) 取决于规则类型
- **Correct**: B
- **Explanation**: memory 的优先级是自上而下生效的。低层级（例如 Auto Memory）不能覆盖高层级（例如 Project Memory）。
- **Review**: Memory hierarchy 章节

### Q10
- **Category**: 实操
- **Question**: 你同时在两个仓库里工作，并希望 Claude 同时加载这两个仓库的 CLAUDE.md。应该使用哪个 flag？
- **Options**: A) `--multi-repo` | B) `--add-dir /path/to/other` | C) `--include /path/to/other` | D) `--merge-context /path/to/other`
- **Correct**: B
- **Explanation**: `--add-dir` 会从额外目录中加载 CLAUDE.md，从而支持多仓库上下文。
- **Review**: Additional directories 章节

---

## Lesson 03: Skills

### Q1
- **Category**: 概念
- **Question**: skill 系统中的 progressive disclosure 分为哪 3 层？
- **Options**: A) Metadata、instructions、resources | B) name、body、attachments | C) header、content、scripts | D) summary、details、data
- **Correct**: A
- **Explanation**: 第 1 层是 Metadata（约 100 tokens，始终加载），第 2 层是 SKILL.md 正文（<5k tokens，触发后加载），第 3 层是附带资源（scripts / references / assets，按需加载）。
- **Review**: Progressive disclosure 架构章节

### Q2
- **Category**: 实操
- **Question**: 一个 skill 能否被 Claude 自动调用，最关键取决于什么？
- **Options**: A) skill 的文件名 | B) frontmatter 里的 `description` 字段，以及其中的触发场景描述 | C) skill 所在目录 | D) `auto-invoke: true` 这个 frontmatter 字段
- **Correct**: B
- **Explanation**: Claude 是否自动调用 skill，核心依据就是 `description` 字段。这里必须写清触发短语和适用场景。
- **Review**: Auto-invocation 章节

### Q3
- **Category**: 概念
- **Question**: 对于一个 SKILL.md 文件，推荐的最大长度是多少？
- **Options**: A) 100 行 | B) 250 行 | C) 500 行 | D) 1000 行
- **Correct**: C
- **Explanation**: SKILL.md 最好控制在 500 行以内。更大的参考资料应拆到 `references/` 子目录。
- **Review**: 内容准则章节

### Q4
- **Category**: 实操
- **Question**: 如何让一个 skill 在隔离的 subagent 中运行，并拥有独立上下文？
- **Options**: A) 在 frontmatter 中设置 `isolation: true` | B) 在 frontmatter 中设置 `context: fork` 并指定 `agent` 字段 | C) 设置 `subagent: true` | D) 把 skill 放进 `.claude/agents/`
- **Correct**: B
- **Explanation**: `context: fork` 会让 skill 在独立上下文中运行，而 `agent` 字段用来指定使用哪种 agent（例如 `Explore`、`Plan` 或自定义 agent）。
- **Review**: 在 subagents 中运行 skills 章节

### Q5
- **Category**: 概念
- **Question**: 分配给 skill metadata（第 1 层）的上下文预算大约是多少？
- **Options**: A) 上下文窗口的 0.5% | B) 上下文窗口的 2% | C) 上下文窗口的 5% | D) 上下文窗口的 10%
- **Correct**: B
- **Explanation**: skill metadata 大约占用上下文窗口的 2%（兜底值为 16,000 字符）。这个值可以通过 `SLASH_COMMAND_TOOL_CHAR_BUDGET` 配置。
- **Review**: 上下文预算章节

### Q6
- **Category**: 实操
- **Question**: 如果一个 skill 需要引用一份很大的 API 规范，应该把它放在哪里？
- **Options**: A) 直接写进 SKILL.md | B) 放在 skill 目录内的 `references/api-spec.md` | C) 放进项目根的 CLAUDE.md | D) 放到独立的 `.claude/rules/` 文件里
- **Correct**: B
- **Explanation**: 大体量参考资料应放在 `references/` 子目录。Claude 会按需加载第 3 层资源，从而保持 SKILL.md 精简。
- **Review**: Supporting files 结构章节

### Q7
- **Category**: 概念
- **Question**: skill 中的 Reference Content 与 Task Content 有什么区别？
- **Options**: A) Reference 只读，Task 可读写 | B) Reference 为上下文补充知识，Task 提供逐步操作指导 | C) Reference 只用于文档，Task 只用于代码 | D) 两者没有区别
- **Correct**: B
- **Explanation**: Reference Content 用于给 Claude 增加领域知识（例如品牌规范）；Task Content 则是面向工作流的、可执行的步骤说明。
- **Review**: Skill 内容类型章节

### Q8
- **Category**: 实操
- **Question**: skill frontmatter 里的 `name` 字段允许使用哪些字符？
- **Options**: A) 任意字符 | B) 仅允许小写字母、数字和连字符（最多 64 个字符） | C) 字母和下划线 | D) 仅允许字母数字
- **Correct**: B
- **Explanation**: `name` 必须使用 kebab-case（小写 + 连字符），最长 64 个字符，并且不能包含 "anthropic" 或 "claude"。
- **Review**: SKILL.md 格式章节

### Q9
- **Category**: 概念
- **Question**: Claude 查找 skills 的顺序是什么？
- **Options**: A) User > Project > Enterprise | B) Enterprise > Personal > Project（plugin 使用命名空间） | C) Project > User > Enterprise | D) 按字母顺序
- **Correct**: B
- **Explanation**: 优先级顺序是 Enterprise > Personal > Project。plugin skills 使用命名空间（plugin-name:skill），因此不会冲突。
- **Review**: Skill 类型与位置章节

### Q10
- **Category**: 实操
- **Question**: 如果你想阻止 Claude 自动调用某个 skill，但仍允许用户手动使用它，应该怎么做？
- **Options**: A) 设置 `user-invocable: false` | B) 设置 `disable-model-invocation: true` | C) 删除 `description` 字段 | D) 设置 `auto-invoke: false`
- **Correct**: B
- **Explanation**: `disable-model-invocation: true` 会阻止 Claude 自动调用，但仍保留它在用户 `/` 菜单中的手动可用性。
- **Review**: 调用控制章节

---

## Lesson 04: Subagents

### Q1
- **Category**: 概念
- **Question**: 与直接在主对话中处理任务相比，subagents 最大的优势是什么？
- **Options**: A) 它们更快 | B) 它们在独立、干净的上下文窗口中运行，不会污染主对话 | C) 它们可以用更多工具 | D) 它们的错误处理更好
- **Correct**: B
- **Explanation**: subagents 会获得一个新的上下文窗口，只接收主 agent 显式传入的内容，因此不会让主对话被任务细节污染。
- **Review**: 概述章节

### Q2
- **Category**: 实操
- **Question**: agent definitions 的优先级顺序是什么？
- **Options**: A) Project > User > CLI | B) CLI > User > Project | C) User > Project > CLI | D) 三者优先级相同
- **Correct**: B
- **Explanation**: 通过 CLI（`--agents` flag）定义的 agents 优先级最高，其次是用户级（`~/.claude/agents/`），最后是项目级（`.claude/agents/`）。
- **Review**: 文件位置章节

### Q3
- **Category**: 概念
- **Question**: 哪个内置 subagent 使用 Haiku 模型，并专门优化为只读的代码库探索？
- **Options**: A) general-purpose | B) Plan | C) Explore | D) Bash
- **Correct**: C
- **Explanation**: Explore subagent 使用 Haiku，适合快速、只读地探索代码库。它支持 quick、medium、very thorough 三种深入程度。
- **Review**: 内置 subagents 章节

### Q4
- **Category**: 实操
- **Question**: 如何限制一个协调型 agent 只能生成特定的 subagents？
- **Options**: A) 使用 `allowed-agents:` 字段 | B) 在 `tools` 字段中使用 `Task(agent_name)` 语法 | C) 设置 `spawn-limit: 2` | D) 使用 `restrict-agents: [name1, name2]`
- **Correct**: B
- **Explanation**: 在 `tools` 字段中加入 `Task(worker, researcher)` 这类写法，会形成 allowlist，该 agent 只能生成指定名字的 subagents。
- **Review**: 限制可生成 subagent 章节

### Q5
- **Category**: 概念
- **Question**: 对于 subagent 来说，`isolation: worktree` 的作用是什么？
- **Options**: A) 让 agent 在 Docker 容器中运行 | B) 给 agent 分配独立的 git worktree，使其改动不影响主工作树 | C) 阻止 agent 读取任何文件 | D) 让 agent 在沙箱中运行
- **Correct**: B
- **Explanation**: worktree isolation 会创建一个独立的 git worktree。如果 agent 没有产生改动，系统会自动清理；如果产生了改动，则会返回 worktree 路径和分支信息。
- **Review**: Worktree isolation 章节

### Q6
- **Category**: 实操
- **Question**: 如何让一个 subagent 在后台运行？
- **Options**: A) 在 agent 配置中设置 `background: true` | B) 在 agent 配置中设置 `async: true` | C) 启动后按 Ctrl+D | D) 使用 `--background` CLI flag
- **Correct**: A
- **Explanation**: 在 agent 配置中设置 `background: true` 可以让它总是作为后台任务运行。用户也可以通过 Ctrl+B 把前台任务转到后台。
- **Review**: 后台 subagents 章节

### Q7
- **Category**: 概念
- **Question**: 对于一个 subagent，`memory` 字段里 scope 设为 `project` 表示什么？
- **Options**: A) 只给它读取项目 CLAUDE.md 的权限 | B) 为当前项目创建一个持久化 memory 目录 | C) 共享主 agent 的全部对话历史 | D) 加载项目的 git 历史
- **Correct**: B
- **Explanation**: `memory` 字段会为 subagent 创建一个持久目录。scope = `project` 表示这份记忆只绑定到当前项目。该 agent 的 MEMORY.md 前 200 行会自动加载。
- **Review**: Persistent memory 章节

### Q8
- **Category**: 实操
- **Question**: 如果你想鼓励 Claude 自动把任务委派给某个 subagent，应该在它的 description 里加入什么样的措辞？
- **Options**: A) 加上 "priority: high" | B) 在描述里加入 "use PROACTIVELY" 或 "MUST BE USED" | C) 设置 `auto-delegate: true` | D) 加上 "trigger: always"
- **Correct**: B
- **Explanation**: 在描述中加入诸如 "use PROACTIVELY" 或 "MUST BE USED" 的措辞，会显著增强 Claude 自动委派相关任务给它的倾向。
- **Review**: 自动委派章节

### Q9
- **Category**: 概念
- **Question**: subagent 的 `permissionMode` 允许哪些值？
- **Options**: A) read、write、admin | B) default、acceptEdits、bypassPermissions、plan、dontAsk、auto | C) safe、normal、dangerous | D) restricted、standard、elevated
- **Correct**: B
- **Explanation**: subagent 支持六种 permission modes：default、acceptEdits、bypassPermissions、plan、dontAsk、auto。
- **Review**: 配置字段章节

### Q10
- **Category**: 实操
- **Question**: 如果你有一个来自上次运行的 `agentId`，如何恢复对应的 subagent？
- **Options**: A) 使用 `/resume agent-id` | B) 调用 Task 工具时传入 `resume` 参数，并给出 agentId | C) 使用 `claude -r agent-id` | D) subagent 不能恢复
- **Correct**: B
- **Explanation**: 你可以在调用 Task 工具时传入 `resume` 参数并给出之前的 agentId，从而在保留完整上下文的情况下继续该 subagent。
- **Review**: Resumable agents 章节

---

## Lesson 05: MCP

### Q1
- **Category**: 概念
- **Question**: MCP 有哪三种传输协议？其中推荐使用哪一种？
- **Options**: A) HTTP（推荐）、Stdio、SSE（已弃用） | B) WebSocket（推荐）、REST、gRPC | C) TCP、UDP、HTTP | D) Stdio（推荐）、HTTP、SSE
- **Correct**: A
- **Explanation**: 对远程服务推荐使用 HTTP；Stdio 适用于本地进程（目前也很常见）；SSE 已弃用但仍兼容。
- **Review**: 传输协议章节

### Q2
- **Category**: 实操
- **Question**: 如何通过 CLI 添加一个 GitHub MCP server？
- **Options**: A) `claude mcp install github` | B) `claude mcp add --transport http github https://api.github.com/mcp` | C) `claude plugin add github-mcp` | D) `claude connect github`
- **Correct**: B
- **Explanation**: 通过 `claude mcp add`，配合 `--transport`、名字和 server URL 即可添加。若使用 stdio，则可写成：`claude mcp add github -- npx -y @modelcontextprotocol/server-github`。
- **Review**: MCP 配置管理章节

### Q3
- **Category**: 概念
- **Question**: 当 MCP 工具描述占用超过上下文窗口的 10% 时，会发生什么？
- **Options**: A) 工具描述被截断 | B) 自动启用 Tool Search，以动态选择相关工具 | C) Claude 报错 | D) 多余工具会被禁用
- **Correct**: B
- **Explanation**: 当 MCP 工具过多、描述占用超过 10% 上下文时，MCP Tool Search 会自动启用。它至少要求 Sonnet 4 或 Opus 4（Haiku 不支持）。
- **Review**: MCP Tool Search 章节

### Q4
- **Category**: 实操
- **Question**: 如何在 MCP 配置中使用环境变量回退值？
- **Options**: A) `${VAR || "default"}` | B) `${VAR:-default}` | C) `${VAR:default}` | D) `${VAR ? "default"}`
- **Correct**: B
- **Explanation**: `${VAR:-default}` 会在环境变量未设置时使用默认值；如果只写 `${VAR}`，在变量缺失时会报错。
- **Review**: 环境变量展开章节

### Q5
- **Category**: 概念
- **Question**: 就数据访问而言，MCP 与 Memory 的区别是什么？
- **Options**: A) MCP 更快，Memory 更慢 | B) MCP 用于实时 / 变化中的外部数据，Memory 用于持久 / 静态偏好 | C) MCP 用于代码，Memory 用于文本 | D) 两者可以完全互换
- **Correct**: B
- **Explanation**: MCP 用于连接实时变化的外部数据源（API、数据库等）；Memory 用于存储稳定的项目上下文和偏好。
- **Review**: MCP vs Memory 章节

### Q6
- **Category**: 实操
- **Question**: 当团队成员第一次遇到项目级 `.mcp.json` 时，会发生什么？
- **Options**: A) 自动加载 | B) 弹出信任该项目 MCP servers 的审批提示 | C) 除非在 settings 中 opt in，否则会被忽略 | D) Claude 会请管理员审批
- **Correct**: B
- **Explanation**: 项目级 `.mcp.json` 会在每位团队成员首次使用时触发安全审批提示。这是刻意设计的，用于避免加载不可信的 MCP server。
- **Review**: MCP Scopes 章节

### Q7
- **Category**: 概念
- **Question**: `claude mcp serve` 的作用是什么？
- **Options**: A) 启动一个 MCP server 仪表盘 | B) 让 Claude Code 自身作为 MCP server，对其他应用提供能力 | C) 提供 MCP 文档服务 | D) 测试 MCP server 连接
- **Correct**: B
- **Explanation**: `claude mcp serve` 会把 Claude Code 变成一个 MCP server，从而支持多 agent 编排，例如一个 Claude 实例控制另一个 Claude 实例。
- **Review**: Claude as MCP Server 章节

### Q8
- **Category**: 实操
- **Question**: MCP 工具默认的最大输出大小是多少？
- **Options**: A) 5,000 tokens | B) 10,000 tokens | C) 25,000 tokens | D) 50,000 tokens
- **Correct**: C
- **Explanation**: 默认最大值是 25,000 tokens（`MAX_MCP_OUTPUT_TOKENS`）。当输出达到 10k tokens 时会出现警告，而写盘持久化上限是 50k 字符。
- **Review**: MCP Output Limits 章节

### Q9
- **Category**: 概念
- **Question**: 在托管的 managed config 中，如果 `allowedMcpServers` 和 `deniedMcpServers` 同时命中某个 server，哪一个优先生效？
- **Options**: A) allowed 优先 | B) denied 优先 | C) 后配置的优先 | D) 两者独立同时应用
- **Correct**: B
- **Explanation**: 在 managed MCP 配置里，deny 规则永远优先于 allow 规则。
- **Review**: Managed MCP Configuration 章节

### Q10
- **Category**: 实操
- **Question**: 在对话中，如何引用一个 MCP resource？
- **Options**: A) 使用 `/mcp resource-name` | B) 使用 `@server-name:protocol://resource/path` 形式的 mention 语法 | C) 使用 `mcp.get("resource")` | D) resources 会自动加载
- **Correct**: B
- **Explanation**: 在对话中，MCP resources 通过 `@server-name:protocol://resource/path` 这样的 mention 语法访问。
- **Review**: MCP Resources 章节

---

## Lesson 06: Hooks

### Q1
- **Category**: 概念
- **Question**: Claude Code 中的 hooks 一共有哪四种类型？
- **Options**: A) Pre、Post、Error、Filter hooks | B) Command、HTTP、Prompt、Agent hooks | C) Before、After、Around、Through hooks | D) Input、Output、Filter、Transform hooks
- **Correct**: B
- **Explanation**: Command hooks 运行 shell 脚本，HTTP hooks 调 webhook，Prompt hooks 使用单轮 LLM 判断，Agent hooks 使用 subagent 做验证。
- **Review**: Hook types 章节

### Q2
- **Category**: 实操
- **Question**: 一个 hook 脚本以退出码 2 结束时，会发生什么？
- **Options**: A) 仅显示非阻塞警告 | B) 触发阻塞错误 —— stderr 会作为错误显示给 Claude，并阻止工具继续执行 | C) 自动重试 hook | D) 直接结束会话
- **Correct**: B
- **Explanation**: 退出码 0 = 成功 / 继续；退出码 2 = 阻塞错误（stderr 会作为错误信息展示）；其他任意非 0 值 = 非阻塞（stderr 只在 verbose 中显示）。
- **Review**: Exit codes 章节

### Q3
- **Category**: 概念
- **Question**: PreToolUse hook 会通过 stdin 收到哪些 JSON 字段？
- **Options**: A) `tool_name` 和 `tool_output` | B) `session_id`、`tool_name`、`tool_input`、`hook_event_name`、`cwd` 等 | C) 只有 `tool_name` | D) 完整对话历史
- **Correct**: B
- **Explanation**: hook 会从 stdin 收到一个 JSON 对象，包含：session_id、transcript_path、hook_event_name、tool_name、tool_input、tool_use_id、cwd、permission_mode 等字段。
- **Review**: JSON 输入结构章节

### Q4
- **Category**: 实操
- **Question**: PreToolUse hook 如何在工具执行前修改其输入参数？
- **Options**: A) 在 stderr 输出修改后的 JSON | B) 在 stdout 输出包含 `updatedInput` 字段的 JSON，并以退出码 0 返回 | C) 写入临时文件 | D) hooks 不能修改输入
- **Correct**: B
- **Explanation**: PreToolUse hook 可以通过 stdout 输出包含 `"updatedInput": {...}` 的 JSON（并以退出码 0 结束），从而在 Claude 调用工具前修改参数。
- **Review**: PreToolUse 输出章节

### Q5
- **Category**: 概念
- **Question**: 哪个 hook 事件支持用 `CLAUDE_ENV_FILE` 把环境变量持久化进当前会话？
- **Options**: A) PreToolUse | B) UserPromptSubmit | C) SessionStart | D) 所有事件都支持
- **Correct**: C
- **Explanation**: 只有 SessionStart hooks 支持使用 `CLAUDE_ENV_FILE` 把环境变量持久化到当前会话中。
- **Review**: SessionStart 章节

### Q6
- **Category**: 实操
- **Question**: 你想让一个 hook 只在某个 skill 第一次加载时运行一次，而不是每次工具调用都执行。应该添加哪个字段？
- **Options**: A) `run-once: true` | B) 在 component hook 定义里加 `once: true` | C) `single: true` | D) `max-runs: 1`
- **Correct**: B
- **Explanation**: component-scoped hooks（定义在 SKILL.md 或 agent frontmatter 中）支持 `once: true`，表示只在首次激活时运行。
- **Review**: Component-scoped hooks 章节

### Q7
- **Category**: 概念
- **Question**: 如果一个 Stop hook 被定义在 subagent 的 frontmatter 中，它会自动转换成什么？
- **Options**: A) PostToolUse hook | B) SubagentStop hook | C) SessionEnd hook | D) 它仍然保持为 Stop hook
- **Correct**: B
- **Explanation**: 当 Stop hook 写在 subagent frontmatter 里时，会自动转成 SubagentStop，以便在该 subagent 完成时触发。
- **Review**: Component-scoped hooks 章节

### Q8
- **Category**: 实操
- **Question**: 如果你想让一个 hook 匹配某个 MCP server 的全部工具，应该怎么写 matcher？
- **Options**: A) `matcher: "mcp_github"` | B) `matcher: "mcp__github__.*"`（正则） | C) `matcher: "mcp:github:*"` | D) `matcher: "github-mcp"`
- **Correct**: B
- **Explanation**: matcher 支持正则。MCP 工具使用 `mcp__server__tool` 命名方式，因此 `mcp__github__.*` 能匹配所有 GitHub MCP 工具。
- **Review**: Matcher patterns 章节

### Q9
- **Category**: 概念
- **Question**: Claude Code 总共支持多少个 hook 事件？
- **Options**: A) 10 | B) 16 | C) 25 | D) 30
- **Correct**: C
- **Explanation**: Claude Code 一共支持 25 个 hook 事件：PreToolUse、PostToolUse、PostToolUseFailure、UserPromptSubmit、Stop、StopFailure、SubagentStop、SubagentStart、PermissionRequest、Notification、PreCompact、PostCompact、SessionStart、SessionEnd、WorktreeCreate、WorktreeRemove、ConfigChange、CwdChanged、FileChanged、TeammateIdle、TaskCompleted、TaskCreated、Elicitation、ElicitationResult、InstructionsLoaded。
- **Review**: Hook events 表

### Q10
- **Category**: 实操
- **Question**: 如果你想排查某个 hook 为什么没有触发，最佳方式是什么？
- **Options**: A) 在 hook 脚本里加 print 语句 | B) 使用 `--debug` flag，并结合 `Ctrl+O` 打开 verbose 模式 | C) 查看系统日志 | D) hooks 没有调试工具
- **Correct**: B
- **Explanation**: `--debug` 和 `Ctrl+O` 的 verbose 模式会展示 hook 执行细节，包括哪些 hook 被触发、它们的输入和输出。
- **Review**: Debugging 章节

---

## Lesson 07: Plugins

### Q1
- **Category**: 概念
- **Question**: plugin 的核心 manifest 文件是什么？它位于哪里？
- **Options**: A) 根目录下的 `plugin.yaml` | B) `.claude-plugin/plugin.json` | C) 带有 "claude" 字段的 `package.json` | D) `.claude/plugin.md`
- **Correct**: B
- **Explanation**: 插件 manifest 位于 `.claude-plugin/plugin.json`，其中至少包含 name、description、version、author 等字段。
- **Review**: Plugin definition structure 章节

### Q2
- **Category**: 实操
- **Question**: 在发布前，如何在本地测试一个 plugin？
- **Options**: A) 使用 `/plugin test ./my-plugin` | B) 使用 `claude --plugin-dir ./my-plugin` | C) 使用 `claude plugin validate ./my-plugin` | D) 复制到 ~/.claude/plugins/
- **Correct**: B
- **Explanation**: `--plugin-dir` 可以从本地目录加载 plugin 进行测试，而且可以重复使用以同时加载多个 plugin。
- **Review**: Testing 章节

### Q3
- **Category**: 概念
- **Question**: 在 plugin hooks 和 MCP 配置中，哪个环境变量可用于引用 plugin 的安装目录？
- **Options**: A) `$PLUGIN_HOME` | B) `${CLAUDE_PLUGIN_ROOT}` | C) `$PLUGIN_DIR` | D) `${CLAUDE_PLUGIN_PATH}`
- **Correct**: B
- **Explanation**: `${CLAUDE_PLUGIN_ROOT}` 会解析为 plugin 的安装目录，因此可在 hooks 和 MCP 配置中写可移植路径。
- **Review**: Plugin 目录结构章节

### Q4
- **Category**: 实操
- **Question**: 如果 `pr-review` 插件中有一个名为 "check-security" 的命令，用户应该如何调用？
- **Options**: A) `/check-security` | B) `/pr-review:check-security` | C) `/plugin pr-review check-security` | D) `/pr-review/check-security`
- **Correct**: B
- **Explanation**: 插件命令使用 `plugin-name:command-name` 命名空间，以避免与用户命令或其他插件命令冲突。
- **Review**: Plugin commands 章节

### Q5
- **Category**: 概念
- **Question**: plugin 可以打包哪些组件？
- **Options**: A) 只有 commands 和 settings | B) commands、agents、skills、hooks、MCP servers、LSP config、settings、templates、scripts | C) 只有 commands、hooks 和 MCP servers | D) 只有 skills 和 agents
- **Correct**: B
- **Explanation**: plugin 可打包的内容包括：commands/、agents/、skills/、hooks/hooks.json、.mcp.json、.lsp.json、settings.json、templates/、scripts/、docs/、tests/。
- **Review**: Plugin directory structure 章节

### Q6
- **Category**: 实操
- **Question**: 如何从 GitHub 安装一个 plugin？
- **Options**: A) `claude plugin add github:username/repo` | B) `/plugin install github:username/repo` | C) `npm install @claude/username-repo` | D) `git clone` 后再执行 `claude plugin register`
- **Correct**: B
- **Explanation**: 使用 `/plugin install github:username/repo` 就可以直接从 GitHub 仓库安装插件。
- **Review**: Installation methods 章节

### Q7
- **Category**: 概念
- **Question**: plugin 的 `settings.json` 里的 `agent` 字段有什么作用？
- **Options**: A) 指定认证凭据 | B) 指定 plugin 激活时主线程要使用的 agent | C) 列出可用 subagents | D) 配置 agent 权限
- **Correct**: B
- **Explanation**: plugin 的 settings.json 中，`agent` 用来指定在 plugin 激活时主线程所采用的 agent 定义。
- **Review**: Plugin Settings 章节

### Q8
- **Category**: 实操
- **Question**: 如何管理 plugin 生命周期（启用 / 禁用 / 更新）？
- **Options**: A) 手动改配置文件 | B) 使用 `/plugin enable`、`/plugin disable`、`/plugin update plugin-name` | C) 使用 `claude plugin-manager` | D) 重新安装整个 plugin
- **Correct**: B
- **Explanation**: Claude Code 提供了完整的 lifecycle 管理命令：enable、disable、update、uninstall。
- **Review**: Installation methods 章节

### Q9
- **Category**: 概念
- **Question**: 相比单独使用 skills / hooks / MCP，plugin 最大的优势是什么？
- **Options**: A) plugin 更快 | B) 一条命令安装、带版本、可在 marketplace 分发，并把所有能力打包到一起 | C) plugin 拥有更多权限 | D) plugin 支持离线工作
- **Correct**: B
- **Explanation**: plugin 能把多个组件打包成一个可安装单元，支持版本管理、marketplace 分发和自动更新，而不是像独立组件那样手工配置。
- **Review**: Standalone vs Plugin comparison 章节

### Q10
- **Category**: 实操
- **Question**: plugin 中的 hooks 配置文件位于什么位置？
- **Options**: A) `.claude-plugin/hooks.json` | B) `hooks/hooks.json` | C) `plugin.json` 的 hooks 字段 | D) `.claude/settings.json`
- **Correct**: B
- **Explanation**: plugin 的 hooks 配置放在插件目录里的 `hooks/hooks.json`。
- **Review**: Plugin hooks 章节

---

## Lesson 08: Checkpoints

### Q1
- **Category**: 概念
- **Question**: checkpoints 会捕获哪四类内容？
- **Options**: A) git commits、branches、tags、stashes | B) 消息、文件修改、工具使用历史、会话上下文 | C) 代码、测试、日志、配置 | D) 输入、输出、错误、耗时
- **Correct**: B
- **Explanation**: checkpoints 会记录对话消息、Claude 工具所做的文件修改、工具使用历史以及会话上下文。
- **Review**: 概述章节

### Q2
- **Category**: 实操
- **Question**: 如何打开 checkpoint browser？
- **Options**: A) 使用 `/checkpoints` 命令 | B) 按 `Esc + Esc`（双击 Esc）或使用 `/rewind` | C) 使用 `/history` | D) 按 `Ctrl+Z`
- **Correct**: B
- **Explanation**: 双击 Esc（Esc+Esc）或使用 `/rewind` 命令，都可以打开 checkpoint browser，选择回退点。
- **Review**: Accessing checkpoints 章节

### Q3
- **Category**: 概念
- **Question**: rewind 一共有几种选项？分别是什么？
- **Options**: A) 3 种：Undo、Redo、Reset | B) 5 种：Restore code+conversation、Restore conversation、Restore code、Summarize from here、Never mind | C) 2 种：Full restore、Partial restore | D) 4 种：Code、Messages、Both、Cancel
- **Correct**: B
- **Explanation**: 共有 5 个选项：同时恢复代码和对话、只恢复对话、只恢复代码、从这里开始摘要化、取消。
- **Review**: Rewind options 章节

### Q4
- **Category**: 实操
- **Question**: 你在 Claude Code 中通过 Bash 执行了 `rm -rf temp/`，随后想 rewind。checkpoint 会恢复这些文件吗？
- **Options**: A) 会，checkpoint 会捕获一切 | B) 不会，Bash 的文件系统操作（rm、mv、cp）不会被 checkpoint 跟踪 | C) 只有使用 Edit 工具时才会 | D) 只有在开启 autoCheckpoint 时才会
- **Correct**: B
- **Explanation**: checkpoints 只会跟踪由 Claude 工具（Write、Edit）产生的文件改动。像 rm、mv、cp 这类 Bash 操作不在跟踪范围内。
- **Review**: Limitations 章节

### Q5
- **Category**: 概念
- **Question**: checkpoints 会保留多长时间？
- **Options**: A) 到会话结束为止 | B) 7 天 | C) 30 天 | D) 永久保留
- **Correct**: C
- **Explanation**: checkpoints 可以跨会话保留最多 30 天，之后会被自动清理。
- **Review**: Checkpoint persistence 章节

### Q6
- **Category**: 实操
- **Question**: rewind 时，"Summarize from here" 的作用是什么？
- **Options**: A) 删除从该点开始的对话 | B) 把后续对话压缩成 AI 生成的摘要，同时保留原始 transcript | C) 生成一份改动的项目符号列表 | D) 把对话导出成文件
- **Correct**: B
- **Explanation**: Summarize 会把对话压缩成更短的 AI 摘要，而原始完整文本仍然保存在 transcript 文件中。
- **Review**: Summarize option 章节

### Q7
- **Category**: 概念
- **Question**: checkpoints 会在什么时机自动创建？
- **Options**: A) 每 5 分钟一次 | B) 每次用户发起 prompt 时 | C) 只有手动保存时 | D) 每次工具调用后
- **Correct**: B
- **Explanation**: 每当用户发出新的 prompt，系统都会自动创建 checkpoint，用于记录 Claude 处理该请求前的状态。
- **Review**: Automatic checkpoints 章节

### Q8
- **Category**: 实操
- **Question**: 如何禁用自动 checkpoint 创建？
- **Options**: A) 使用 `--no-checkpoints` | B) 在 settings 中设置 `autoCheckpoint: false` | C) 删除 checkpoints 目录 | D) checkpoints 不能被禁用
- **Correct**: B
- **Explanation**: 在配置中设置 `autoCheckpoint: false` 就可以关闭自动 checkpoint 创建（默认值是 true）。
- **Review**: Configuration 章节

### Q9
- **Category**: 概念
- **Question**: checkpoints 能否替代 git commits？
- **Options**: A) 能，而且更强大 | B) 不能，它们是互补关系 —— checkpoints 作用于单个会话且会过期，git 是永久且可共享的 | C) 对小项目可以 | D) 只有单人开发时可以
- **Correct**: B
- **Explanation**: checkpoints 是临时的（保留 30 天）、会话级的、也不能分享；git commits 则是永久的、可审计的、可共享的。两者最好配合使用。
- **Review**: Integration with git 章节

### Q10
- **Category**: 实操
- **Question**: 如果你想比较两种不同实现方案，推荐的 checkpoint 工作流是什么？
- **Options**: A) 创建两个独立会话 | B) 在方案 A 前先打 checkpoint，尝试 A，rewind 回该点，再尝试 B，最后比较结果 | C) 改用 git branches | D) 没有好的方法比较两种方案
- **Correct**: B
- **Explanation**: 推荐分支式策略：先在干净状态打 checkpoint，尝试方案 A 并记录结果，再 rewind 回同一 checkpoint，尝试方案 B，最后对比两种结果。
- **Review**: Workflow patterns 章节

---

## Lesson 09: Advanced Features

### Q1
- **Category**: 概念
- **Question**: Claude Code 一共有哪六种 permission modes？
- **Options**: A) read、write、execute、admin、root、sudo | B) default、acceptEdits、plan、auto、dontAsk、bypassPermissions | C) safe、normal、elevated、admin、unrestricted、god | D) view、edit、run、deploy、full、bypass
- **Correct**: B
- **Explanation**: 六种模式分别是：default、acceptEdits、plan、auto、dontAsk、bypassPermissions。
- **Review**: Permission Modes 章节

### Q2
- **Category**: 实操
- **Question**: 如何激活 planning mode？
- **Options**: A) 只能通过 `/plan` 命令 | B) 可通过 `/plan`、`Shift+Tab`/`Alt+M`、`--permission-mode plan`，或默认配置启用 | C) 只能通过 `--planning` flag | D) planning 默认始终开启
- **Correct**: B
- **Explanation**: planning mode 可以通过多种方式开启：/plan 命令、Shift+Tab / Alt+M 快捷键、`--permission-mode plan` CLI 参数，或者在配置中设为默认。
- **Review**: Planning Mode 章节

### Q3
- **Category**: 概念
- **Question**: `opusplan` 这个 model alias 的作用是什么？
- **Options**: A) 全流程都只用 Opus | B) 规划阶段使用 Opus，执行阶段使用 Sonnet | C) 使用专门为规划优化的独立模型 | D) 自动启用 plan mode
- **Correct**: B
- **Explanation**: `opusplan` 是一个 model alias，会在规划阶段使用 Opus（更强分析），在执行阶段使用 Sonnet（更快实现）。
- **Review**: Planning Mode 章节

### Q4
- **Category**: 实操
- **Question**: 在会话中如何切换 extended thinking？
- **Options**: A) 输入 `/think` | B) 按 `Option+T`（macOS）或 `Alt+T` | C) 使用 `--thinking` flag | D) 它默认总是开启且无法切换
- **Correct**: B
- **Explanation**: 在会话中按 Option+T（macOS）或 Alt+T 即可切换 extended thinking。默认对所有模型都可用；Opus 4.6 还支持自适应 effort 等级。
- **Review**: Extended Thinking 章节

### Q5
- **Category**: 概念
- **Question**: "think" 或 "ultrathink" 这些词是特殊关键字吗？会自动开启更强推理吗？
- **Options**: A) 是，会开启更深层推理 | B) 不是，它们只是普通提示文本，没有特殊行为 | C) 只有 "ultrathink" 有特殊作用 | D) 只有在 Opus 下才有效
- **Correct**: B
- **Explanation**: 文档明确说明这些只是普通 prompt 文本，并不是特殊开关。真正控制 extended thinking 的方式是 Alt+T 切换和环境变量。
- **Review**: Extended Thinking 章节

### Q6
- **Category**: 实操
- **Question**: 如何在 CI/CD 中以结构化 JSON 输出和 turn limit 运行 Claude？
- **Options**: A) `claude --ci --json --limit 3` | B) `claude -p --output-format json --max-turns 3 "review code"` | C) `claude --pipeline --format json` | D) `claude run --json --turns 3`
- **Correct**: B
- **Explanation**: 标准做法是使用 print mode（`-p`）+ `--output-format json` + `--max-turns`。
- **Review**: Headless / Print Mode 章节

### Q7
- **Category**: 概念
- **Question**: Task List（Ctrl+T）功能提供了什么？
- **Options**: A) 当前后台进程列表 | B) 一个可跨 compact 保留的持久 to-do list，并可通过 `CLAUDE_CODE_TASK_LIST_ID` 跨会话共享 | C) 过往会话历史 | D) 等待中的工具调用队列
- **Correct**: B
- **Explanation**: Task List（Ctrl+T）可以在上下文 compact 后继续保留，并可通过 `CLAUDE_CODE_TASK_LIST_ID` 在多个会话之间共享任务目录。
- **Review**: Task List 章节

### Q8
- **Category**: 实操
- **Question**: 在 planning mode 中，如何把 plan 打开到外部编辑器进行修改？
- **Options**: A) 手动从终端复制粘贴 | B) 按 `Ctrl+G`，在外部编辑器中打开 plan | C) 使用 `/export-plan` 命令 | D) plan 不能在外部编辑
- **Correct**: B
- **Explanation**: 按 Ctrl+G 会用你配置好的外部编辑器打开当前 plan，便于修改。
- **Review**: Planning Mode 章节

### Q9
- **Category**: 概念
- **Question**: `dontAsk` 与 `bypassPermissions` 的区别是什么？
- **Options**: A) 它们没有区别 | B) `dontAsk` 会自动拒绝未预先批准的请求，而 `bypassPermissions` 会跳过所有检查 | C) `dontAsk` 用于文件，`bypassPermissions` 用于命令 | D) `bypassPermissions` 更安全
- **Correct**: B
- **Explanation**: dontAsk 会自动拒绝权限请求，除非命中预批准规则；而 bypassPermissions 会完全跳过所有安全检查，因此不适合日常使用。
- **Review**: Permission Modes 章节

### Q10
- **Category**: 实操
- **Question**: 如何把一个 CLI 会话交接给桌面端应用？
- **Options**: A) 使用 `/export` | B) 使用 `/desktop` | C) 复制 session ID 再粘到桌面端 | D) CLI 与桌面端之间不能转移会话
- **Correct**: B
- **Explanation**: `/desktop` 命令会把当前 CLI 会话交给原生桌面应用，以便进行可视化 diff 审查或多会话管理。
- **Review**: Desktop App 章节

---

## Lesson 10: CLI Reference

### Q1
- **Category**: 概念
- **Question**: Claude CLI 的两种主要模式是什么？
- **Options**: A) 在线 / 离线模式 | B) 交互式 REPL（`claude`）和 Print mode（`claude -p`） | C) GUI 模式和终端模式 | D) 单次模式和批处理模式
- **Correct**: B
- **Explanation**: 默认是交互式 REPL，会持续对话；而 Print mode（`-p`）是无交互、可脚本化、可管道化的，一次响应后就退出。
- **Review**: CLI 架构章节

### Q2
- **Category**: 实操
- **Question**: 如何把一个文件通过管道传给 Claude，并要求它输出 JSON？
- **Options**: A) `claude --file error.log --json` | B) `cat error.log | claude -p --output-format json "explain this"` | C) `claude < error.log --format json` | D) `claude -p --input error.log --json`
- **Correct**: B
- **Explanation**: 把内容通过 stdin 管道传给 print mode（`-p`），再加 `--output-format json`，即可得到结构化输出。
- **Review**: Interactive vs Print Mode 章节

### Q3
- **Category**: 概念
- **Question**: `-c` 和 `-r` 这两个 flag 的区别是什么？
- **Options**: A) 没区别 | B) `-c` 继续最近一次会话；`-r` 按名称或 ID 恢复指定会话 | C) `-c` 创建新会话；`-r` 才是恢复 | D) `-c` 用于代码模式，`-r` 用于 review 模式
- **Correct**: B
- **Explanation**: `-c/--continue` 会恢复最近一次会话；`-r/--resume "name"` 会按会话名或 session ID 恢复指定会话。
- **Review**: 会话管理章节

### Q4
- **Category**: 实操
- **Question**: 如何保证 Claude 输出的 JSON 一定符合你指定的 schema？
- **Options**: A) 只用 `--output-format json` 就行 | B) 使用 `--output-format json --json-schema '{"type":"object",...}'` | C) 使用 `--strict-json` flag | D) JSON 输出默认总是符合 schema
- **Correct**: B
- **Explanation**: 仅使用 `--output-format json` 只能尽量输出 JSON；再加上 `--json-schema` 指定 JSON Schema，才能强约束输出结构。
- **Review**: Output and format 章节

### Q5
- **Category**: 概念
- **Question**: 哪个 flag 只在 print mode（`-p`）下有效，在交互模式里无效？
- **Options**: A) `--model` | B) `--system-prompt-file` | C) `--verbose` | D) `--max-turns`
- **Correct**: B
- **Explanation**: `--system-prompt-file` 只在 print mode 下有效；如果在交互式会话中想设置系统提示，应使用 `--system-prompt`（内联字符串）。
- **Review**: 系统提示参数对比表

### Q6
- **Category**: 实操
- **Question**: 如果你想在做安全审计时把 Claude 限制为只读工具，应该怎么写命令？
- **Options**: A) `claude --read-only "audit code"` | B) `claude --permission-mode plan --tools "Read,Grep,Glob" "audit code"` | C) `claude --safe-mode "audit code"` | D) `claude --no-write "audit code"`
- **Correct**: B
- **Explanation**: 使用 `--permission-mode plan`（只读分析）并配合 `--tools` 指定 allowlist，可以把 Claude 限定为只执行读操作。
- **Review**: Tool and permission management 章节

### Q7
- **Category**: 概念
- **Question**: agent definitions 的优先级顺序是什么？
- **Options**: A) Project > User > CLI | B) CLI > User > Project | C) User > CLI > Project | D) 优先级相同
- **Correct**: B
- **Explanation**: 通过 CLI（`--agents`）定义的 agents 优先级最高，其次是用户级（`~/.claude/agents/`），最后是项目级（`.claude/agents/`）。
- **Review**: Agents configuration 章节

### Q8
- **Category**: 实操
- **Question**: 如果你想在不丢失原会话的前提下分叉出一个新方案，应该怎么做？
- **Options**: A) 使用 `/fork` 命令 | B) 使用 `--resume session-name --fork-session "branch name"` | C) 使用 `--clone session-name` | D) 使用 `/branch session-name`
- **Correct**: B
- **Explanation**: 使用 `--resume` 搭配 `--fork-session`，可以从已有会话分叉出一个新的独立分支，同时保留原会话。
- **Review**: 会话管理章节

### Q9
- **Category**: 概念
- **Question**: 当用户已登录时，`claude auth status` 的退出码是多少？
- **Options**: A) 1 | B) 0 | C) 200 | D) 它不会返回退出码
- **Correct**: B
- **Explanation**: `claude auth status` 在用户已登录时返回退出码 0，未登录时返回 1，因此很适合在脚本或 CI/CD 中使用。
- **Review**: CLI commands 表

### Q10
- **Category**: 实操
- **Question**: 如何使用 Claude 批量处理多个文件？
- **Options**: A) `claude --batch *.md` | B) 使用 for 循环：`for file in *.md; do claude -p "summarize: $(cat $file)" > ${file%.md}.json; done` | C) `claude -p --files *.md "summarize all"` | D) Claude 不支持批处理
- **Correct**: B
- **Explanation**: 通过 shell for 循环配合 print mode，可以逐个处理文件。每次调用都是独立的，也便于分别输出结构化结果。
- **Review**: Batch processing 章节
