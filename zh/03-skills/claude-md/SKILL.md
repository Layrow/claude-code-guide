---
name: claude-md
description: 按最佳实践创建或更新 CLAUDE.md 文件，以获得更好的 AI agent onboarding 效果
---

## User Input

```text
$ARGUMENTS
```

在继续之前，你**必须**先考虑用户输入（如果不为空）。用户可能会指定：
- `create` - 从零开始创建新的 CLAUDE.md
- `update` - 改进已有 CLAUDE.md
- `audit` - 分析并报告当前 CLAUDE.md 的质量
- 指定要创建/更新的具体路径（例如 `src/api/CLAUDE.md`，表示目录级说明）

## Core Principles

**LLMs are stateless**：`CLAUDE.md` 是唯一一个会在每次对话中自动包含的文件。它相当于 AI agent 进入代码库时的首要 onboarding 文档。

### The Golden Rules

1. **Less is More**：前沿 LLM 通常只能稳定遵循约 150-200 条指令，而 Claude Code 自身的 system prompt 已经占用了约 50 条。请让 CLAUDE.md 保持聚焦和简洁。
2. **Universal Applicability**：只写对**每一次 session**都相关的信息。任务专属说明应该拆到其他文件里。
3. **Don't Use Claude as a Linter**：风格规则会膨胀上下文，还会降低执行指令的质量。格式与风格请交给确定性工具（prettier、eslint 等）。
4. **Never Auto-Generate**：CLAUDE.md 是 AI harness 中杠杆效应最高的文件之一，应当经过认真设计和手工打磨。

## Execution Flow

### 1. Project Analysis

首先分析当前项目状态：

1. 检查是否已有 CLAUDE.md：
   - 根目录：`./CLAUDE.md` 或 `.claude/CLAUDE.md`
   - 目录级：`**/CLAUDE.md`
   - 全局用户配置：`~/.claude/CLAUDE.md`

2. 识别项目结构：
   - 技术栈（语言、框架）
   - 项目类型（monorepo、单应用、库）
   - 开发工具（包管理器、构建系统、测试运行器）

3. 审阅现有文档：
   - `README.md`
   - `CONTRIBUTING.md`
   - `package.json`、`pyproject.toml`、`Cargo.toml` 等

### 2. Content Strategy (WHAT, WHY, HOW)

围绕三个维度来组织 CLAUDE.md：

#### WHAT - Technology & Structure
- 技术栈概览
- 项目组织方式（对 monorepo 尤其重要）
- 关键目录及其职责

#### WHY - Purpose & Context
- 项目做什么
- 为什么做了某些架构决策
- 每个主要组件负责什么

#### HOW - Workflow & Conventions
- 开发工作流（bun vs node、pip vs uv 等）
- 测试流程和命令
- 验证与构建方式
- 关键的 "gotchas" 或不明显但很重要的要求

### 3. Progressive Disclosure Strategy

对于较大的项目，建议建立 `agent_docs/` 目录：

```
agent_docs/
  |- building_the_project.md
  |- running_tests.md
  |- code_conventions.md
  |- architecture_decisions.md
```

在 CLAUDE.md 中，用类似下面的方式引用这些文档：
```markdown
For detailed build instructions, refer to `agent_docs/building_the_project.md`
```

**Important**：优先使用 `file:line` 引用，而不是直接粘贴代码片段，这样可以避免上下文过时。

### 4. Quality Constraints

在创建或更新 CLAUDE.md 时：

1. **Target Length**：控制在 300 行以内（最好 100 行以内）
2. **No Style Rules**：移除所有 lint/formatting 类说明
3. **No Task-Specific Instructions**：任务专属说明拆到其他文件
4. **No Code Snippets**：改用文件引用
5. **No Redundant Information**：不要重复 package.json 或 README 里已有的信息

### 5. Essential Sections

一个结构良好的 CLAUDE.md 通常应包含：

```markdown
# Project Name

Brief one-line description.

## Tech Stack
- Primary language and version
- Key frameworks/libraries
- Database/storage (if any)

## Project Structure
[Only for monorepos or complex structures]
- `apps/` - Application entry points
- `packages/` - Shared libraries

## Development Commands
- Install: `command`
- Test: `command`
- Build: `command`

## Critical Conventions
[Only non-obvious, high-impact conventions]
- Convention 1 with brief explanation
- Convention 2 with brief explanation

## Known Issues / Gotchas
[Things that consistently trip up developers]
- Issue 1
- Issue 2
```

### 6. Anti-Patterns to Avoid

**DO NOT include:**
- 代码风格规范（交给 linters）
- 如何使用 Claude 的说明
- 对显而易见模式的冗长解释
- 复制粘贴的代码示例
- 泛泛的最佳实践（例如 "write clean code"）
- 针对某个具体任务的说明
- 自动生成的内容
- 很长的 TODO 列表

### 7. Validation Checklist

在最终定稿前，确认：

- [ ] 少于 300 行（最好少于 100 行）
- [ ] 每一行都适用于**所有** session
- [ ] 没有风格/格式规则
- [ ] 没有代码片段（改用文件引用）
- [ ] 所有命令都已验证可用
- [ ] 对复杂项目使用了 progressive disclosure
- [ ] 记录了关键 gotchas
- [ ] 没有与 README.md 重复

## Output Format

### For `create` or default:

1. 分析项目
2. 按上述结构起草 CLAUDE.md
3. 展示草稿供审阅
4. 用户确认后写入对应位置

### For `update`:

1. 读取现有 CLAUDE.md
2. 依据最佳实践进行审计
3. 识别：
   - 应移除的内容（风格规则、代码片段、任务专属说明）
   - 应压缩精简的内容
   - 缺失的关键内容
4. 展示修改建议供审阅
5. 用户确认后再应用修改

### For `audit`:

1. 读取现有 CLAUDE.md
2. 生成报告，包括：
   - 当前行数与目标行数对比
   - 具有普适性的内容比例
   - 发现的 anti-pattern 列表
   - 改进建议
3. **不要修改文件，只输出报告**

## AGENTS.md Handling

如果用户要求创建或更新 AGENTS.md：

AGENTS.md 用来定义专门的 agent 行为。它和 CLAUDE.md 不同，CLAUDE.md 是项目上下文文件，而 AGENTS.md 通常定义：
- 自定义 agent 角色与能力
- agent 专属说明与约束
- 多 agent 协作场景下的工作流定义

同样适用类似原则：
- 保持聚焦和简洁
- 使用 progressive disclosure
- 优先引用外部文档，而不是把所有内容都嵌进去

## Notes

- 把命令写进去之前，始终先验证能运行
- 拿不准时宁缺毋滥，越少越精
- 系统提醒里已经告诉 Claude：CLAUDE.md “可能相关，也可能不相关” ，噪声越多，它越容易被忽略
- 对 monorepo 来说，清晰的 WHAT/WHY/HOW 结构尤其重要
- 目录级 CLAUDE.md 应该比根级更聚焦
