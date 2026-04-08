---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
argument-hint: [message]
description: 结合上下文创建 git commit
---

## Context

- Current git status: !`git status`
- Current git diff: !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

基于以上变更，创建一个单独的 git commit。

如果通过参数提供了提交信息，就直接使用它：$ARGUMENTS

否则，请分析这些变更，并按照 conventional commits 格式生成合适的 commit message：
- `feat:` 用于新功能
- `fix:` 用于缺陷修复
- `docs:` 用于文档改动
- `refactor:` 用于代码重构
- `test:` 用于新增测试
- `chore:` 用于维护性任务
