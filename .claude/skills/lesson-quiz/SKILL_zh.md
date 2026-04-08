---
name: lesson-quiz
version: 1.0.0
description: 面向 Claude Code 教程的互动式单课测验。围绕某一节课程（01-10）用 8-10 道题混合考察概念理解与实操能力。可在学习前做预检、学习中检查进度、学习后验证掌握度。适用于用户说出 “quiz me on hooks”、“test my knowledge of lesson 3”、“lesson quiz”、“practice quiz for MCP” 或 “do I understand skills” 这类请求时。
---

# Lesson Quiz

这是一个交互式测验，用 8-10 道题测试你对某一节 Claude Code 课程的理解，提供逐题反馈，并指出需要回看的地方。

## Instructions

### Step 1: 确定课程

如果用户已经以参数形式提供课程（例如 `/lesson-quiz hooks` 或 `/lesson-quiz 03`），就把它映射到对应课程目录：

**课程映射：**
- `01`、`slash-commands`、`commands` → 01-slash-commands
- `02`、`memory` → 02-memory
- `03`、`skills` → 03-skills
- `04`、`subagents`、`agents` → 04-subagents
- `05`、`mcp` → 05-mcp
- `06`、`hooks` → 06-hooks
- `07`、`plugins` → 07-plugins
- `08`、`checkpoints`、`checkpoint` → 08-checkpoints
- `09`、`advanced`、`advanced-features` → 09-advanced-features
- `10`、`cli` → 10-cli

如果没有提供参数，请使用 AskUserQuestion 给出选择提示：

**Question 1**（header: "Lesson"）
"你想测验哪一课？"
Options:
1. "Slash Commands (01)" — 自定义命令、skills、frontmatter、参数
2. "Memory (02)" — CLAUDE.md、记忆层级、规则、自动记忆
3. "Skills (03)" — Progressive disclosure、自动调用、SKILL.md
4. "Subagents (04)" — 任务委派、agent 配置、上下文隔离

**Question 2**（header: "Lesson"）
"你想测验哪一课？（继续）"
Options:
1. "MCP (05)" — 外部集成、传输方式、servers、tool search
2. "Hooks (06)" — 事件自动化、PreToolUse、退出码、JSON I/O
3. "Plugins (07)" — 打包方案、marketplace、plugin.json
4. "More lessons..." — Checkpoints、Advanced Features、CLI

如果用户选择 "More lessons..."，继续展示：

**Question 3**（header: "Lesson"）
"请选择你的课程："
Options:
1. "Checkpoints (08)" — Rewind、恢复、安全试验
2. "Advanced Features (09)" — Planning、permissions、print mode、thinking
3. "CLI Reference (10)" — Flags、输出格式、脚本化、管道

### Step 2: 读取课程内容

读取课程的 README.md 以刷新上下文：
- Read file: `<lesson-directory>/README.md`

然后使用 `references/question-bank.md` 中该课对应的题库。题库里已经预写好每课 10 道题，并带有正确答案和解释。

### Step 3: 展示测验

先询问用户当前所处的学习时机：

使用 AskUserQuestion（header: "Timing"）：
"这次测验与你学习该课程的时间点是什么关系？"
Options:
1. "Before (pre-test)" — 我还没看这节课，先测一下已有认知
2. "During (progress check)" — 我学到一半，想检查一下进度
3. "After (mastery check)" — 我已经学完，想验证是否掌握

这个上下文会影响结果的表述方式（见 Step 5）。

### Step 4: 分轮出题

从题库中抽取 10 道题，按每轮 2 道题展示（总共 5 轮）。每道题都用 AskUserQuestion 展示问题文本和 3-4 个选项。

**重要**：每个问题最多 4 个选项；每轮 2 道题。

每轮出 2 道题。全部 5 轮结束后，再进入计分阶段。

**每题格式：**

题库中的每道题都包含：
- `question`：题目文本
- `options`：3-4 个选项（其中一个正确，在题库中有标注）
- `correct`：正确答案标签
- `explanation`：为什么这是正确答案
- `category`："conceptual" 或 "practical"

用 AskUserQuestion 展示每题，并记录用户答案。

### Step 5: 计分并展示结果

全部轮次完成后，计算分数并展示结果。

**计分规则：**
- 每答对一题 = 1 分
- 总分 = 10 分

**等级划分：**
- 9-10：Mastered —— 理解非常扎实
- 7-8：Proficient —— 掌握良好，只有少量缺口
- 5-6：Developing —— 基础概念已懂，但仍需回顾
- 3-4：Beginning —— 缺口较多，建议重点复习
- 0-2：Not yet —— 建议从这节课开头重新学起

**输出格式：**

```markdown
## Lesson Quiz Results: [Lesson Name]

**Score: N/10** — [Grade label]
**Quiz timing**: [Before / During / After] the lesson
**Question breakdown**: N conceptual correct, N practical correct

### Per-Question Results

| # | Category | Question (short) | Your Answer | Result |
|---|----------|-----------------|-------------|--------|
| 1 | Conceptual | [abbreviated question] | [their answer] | [Correct / Incorrect] |
| 2 | Practical | ... | ... | ... |
| ... | ... | ... | ... | ... |

### Incorrect Answers — Review These

[For each incorrect answer, show:]

**Q[N]: [Full question text]**
- Your answer: [what they chose]
- Correct answer: [correct option]
- Explanation: [why it's correct]
- Review: [specific section of the lesson README to re-read]

### [Timing-specific message]

[If pre-test]:
**Pre-test score: N/10.** 这会作为你的基线！学习时请重点关注答错的主题。学完课程后再测一次，看看自己进步了多少。

[If during]:
**Progress check: N/10.** [如果 7+：进度不错，继续；如果 4-6：建议先回看答错的主题再往下学；如果 <4：建议从头重新看一遍。]

[If after]:
**Mastery check: N/10.** [如果 9-10：你已经掌握这节课了，可以继续下一课；如果 7-8：差一点就完全掌握了，回看遗漏点再测一次；如果 <7：建议再花些时间学习本课，尤其是上面标出的章节。]

### Recommended Next Steps

[Based on score and timing:]
- [If mastered]: Proceed to the next lesson in the roadmap: [next lesson link]
- [If proficient]: Review these specific sections, then retake: [list sections]
- [If developing or below]: Re-read the full lesson: [lesson link]. Focus on: [list weak categories]
- [Offer]: "Would you like to retake this quiz, try a different lesson, or get help with a specific topic?"
```

### Step 6: 提供后续选项

结果展示完后，再用 AskUserQuestion 询问用户下一步：

"你接下来想做什么？"
Options:
1. "Retake this quiz" — 重新测同一课
2. "Quiz another lesson" — 换另一课测试
3. "Explain a topic I missed" — 详细解释一道答错的知识点
4. "Done" — 结束这次测验

如果选择 **Retake**：回到 Step 4（跳过 timing 问题，沿用原 timing）。
如果选择 **Quiz another lesson**：回到 Step 1。
如果选择 **Explain a topic**：询问题号，然后读取对应课程 README.md 中相关章节，并用示例解释。

## Error Handling

### 无效的课程参数
如果参数无法匹配任何课程，展示可用课程列表，并请用户重新选择。

### 用户中途想退出
如果用户在任何一轮中表示想停止，则针对已作答题目输出部分结果。

### 找不到课程 README
如果预期路径下不存在 README.md，告知用户，并建议检查仓库结构。

## Validation

### Triggering test suite

**Should trigger:**
- "quiz me on hooks"
- "lesson quiz"
- "test my knowledge of lesson 3"
- "practice quiz for MCP"
- "do I understand skills"
- "quiz me on slash commands"
- "lesson-quiz 06"
- "test me on checkpoints"
- "how well do I know the CLI"
- "quiz me before I start the memory lesson"

**Should NOT trigger:**
- "assess my overall level"（应使用 /self-assessment）
- "explain hooks to me"
- "create a hook"
- "what is MCP"
- "review my code"
