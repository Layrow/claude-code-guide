# 更新日志

## v2.2.0 — 2026-03-26

### 文档

- 将所有教程与参考文档同步到 Claude Code v2.1.84（f78c094） @luongnv89
  - 将 slash commands 更新为 55+ 个内置命令 + 5 个打包技能，并标记 3 个已废弃项
  - 将 hook 事件从 18 个扩展到 25 个，新增 `agent` hook 类型（现共 4 种类型）
  - 在高级特性中加入 Auto Mode、Channels、Voice Dictation
  - 增加 `effort`、`shell` skill frontmatter 字段；增加 `initialPrompt`、`disallowedTools` agent 字段
  - 增加 WebSocket MCP transport、elicitation、2KB tool cap
  - 更新 plugin 的 LSP 支持、`userConfig`、`${CLAUDE_PLUGIN_DATA}`
  - 更新全部参考文档（CATALOG、QUICK_REFERENCE、LEARNING-ROADMAP、INDEX）
- 将 README 重写为落地页式结构指南（32a0776） @luongnv89

### Bug 修复

- 为满足 CI 要求，补充缺失的 cSpell 单词和 README 章节（93f9d51） @luongnv89
- 将 `Sandboxing` 添加到 cSpell 词典中（b80ce6f） @luongnv89

**完整更新日志**：https://github.com/luongnv89/claude-howto/compare/v2.1.1...v2.2.0

---

## v2.1.1 — 2026-03-13

### Bug 修复

- 移除导致 CI 链接检查失败的失效 marketplace 链接（3fdf0d6） @luongnv89
- 将 `sandboxed` 和 `pycache` 添加到 cSpell 词典中（dc64618） @luongnv89

**完整更新日志**：https://github.com/luongnv89/claude-howto/compare/v2.1.0...v2.1.1

---

## v2.1.0 — 2026-03-13

### 新特性

- 增加自适应学习路径，包括 self-assessment 和 lesson quiz 技能（1ef46cd） @luongnv89
  - `/self-assessment` — 覆盖 10 个能力领域的交互式熟练度测验，并生成个性化学习路径
  - `/lesson-quiz [lesson]` — 针对单课内容的知识检查，包含 8-10 个定向问题

### Bug 修复

- 更新损坏链接、已废弃内容和过时引用（8fe4520） @luongnv89
- 修复 resources 和 self-assessment skill 中的失效链接（7a05863） @luongnv89
- 在 concepts guide 中使用波浪线围栏处理嵌套代码块（5f82719） @VikalpP
- 将缺失单词加入 cSpell 词典（8df7572） @luongnv89

### 文档

- 第 5 阶段 QA：修复文档中的一致性、URL 和术语问题（00bbe4c） @luongnv89
- 完成第 3-4 阶段：补充新特性覆盖并更新参考文档（132de29） @luongnv89
- 在 MCP 上下文膨胀章节中加入 MCPorter runtime（ef52705） @luongnv89
- 在 6 份指南中补充缺失命令、功能和设置（4bc8f15） @luongnv89
- 基于现有仓库约定新增 style guide（84141d0） @luongnv89
- 在指南对照表中加入 self-assessment 条目（8fe0c96） @luongnv89
- 在 PR #7 中将 @VikalpP 加入贡献者列表（d5b4350） @luongnv89
- 在 README 和 roadmap 中加入 self-assessment 与 lesson-quiz 的技能引用（d5a6106） @luongnv89

### 新贡献者

- @VikalpP 在 #7 中完成了首次贡献

**完整更新日志**：https://github.com/luongnv89/claude-howto/compare/v2.0.0...v2.1.0

---

## v2.0.0 — 2026-02-01

### 新特性

- 将所有文档同步到 Claude Code 2026 年 2 月版本特性（487c96d）
  - 更新 10 个教程目录和 7 份参考文档中的 26 个文件
  - 增加 **Auto Memory** 文档 —— 为每个项目持久保存学习结果
  - 增加 **Remote Control**、**Web Sessions** 和 **Desktop App** 文档
  - 增加 **Agent Teams** 文档（实验性的多代理协作）
  - 增加 **MCP OAuth 2.0**、**Tool Search** 和 **Claude.ai Connectors** 文档
  - 增加 **Persistent Memory** 与 subagent **Worktree Isolation** 文档
  - 增加 **Background Subagents**、**Task List**、**Prompt Suggestions** 文档
  - 增加 **Sandboxing** 和 **Managed Settings**（企业版）文档
  - 增加 **HTTP Hooks** 和 7 个新的 hook 事件文档
  - 增加 **Plugin Settings**、**LSP Servers** 和 Marketplace 更新文档
  - 增加回退选项 **Summarize from Checkpoint** 文档
  - 记录 17 个新 slash commands（`/fork`、`/desktop`、`/teleport`、`/tasks`、`/fast` 等）
  - 记录新的 CLI flags（`--worktree`、`--from-pr`、`--remote`、`--teleport`、`--teammate-mode` 等）
  - 记录 auto memory、effort levels、agent teams 等相关新环境变量

### 设计

- 将 logo 重设计为 compass-bracket 风格标记，并使用更精简的配色（20779db）

### Bug 修复 / 纠正

- 更新模型名称：Sonnet 4.5 → **Sonnet 4.6**，Opus 4.5 → **Opus 4.6**
- 修正权限模式名称：将虚构的 "Unrestricted/Confirm/Read-only" 替换为真实的 `default`/`acceptEdits`/`plan`/`dontAsk`/`bypassPermissions`
- 修正 hook 事件：移除虚构的 `PreCommit`/`PostCommit`/`PrePush`，改为真实事件（`SubagentStart`、`WorktreeCreate`、`ConfigChange` 等）
- 修正 CLI 语法：将 `claude-code --headless` 替换为 `claude -p`（print mode）
- 修正 checkpoint 命令：将虚构的 `/checkpoint save/list/rewind/diff` 替换为真实的 `Esc+Esc` / `/rewind` 界面
- 修正 session management：将虚构的 `/session list/new/switch/save` 替换为真实的 `/resume`/`/rename`/`/fork`
- 修正 plugin manifest 格式：从 `plugin.yaml` 迁移到 `.claude-plugin/plugin.json`
- 修正 MCP 配置路径：`~/.claude/mcp.json` → `.mcp.json`（项目）/ `~/.claude.json`（用户）
- 修正文档 URL：`docs.claude.com` → `docs.anthropic.com`；移除虚构的 `plugins.claude.com`
- 在多个文件中移除虚构配置字段
- 将所有 “Last Updated” 日期更新为 2026 年 2 月

**完整更新日志**：https://github.com/luongnv89/claude-howto/compare/20779db...v2.0.0
