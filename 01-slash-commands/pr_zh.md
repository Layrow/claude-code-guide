---
description: 清理代码、暂存变更，并准备 pull request
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(npm test:*), Bash(npm run lint:*)
---

# Pull Request Preparation Checklist

在创建 PR 之前，请执行以下步骤：

1. 运行 lint：`prettier --write .`
2. 运行测试：`npm test`
3. 检查 git diff：`git diff HEAD`
4. 暂存变更：`git add .`
5. 按照 conventional commits 创建 commit message：
   - `fix:` 用于修复缺陷
   - `feat:` 用于新增功能
   - `docs:` 用于文档更新
   - `refactor:` 用于代码结构重整
   - `test:` 用于新增测试
   - `chore:` 用于维护性工作

6. 生成 PR 摘要，内容包括：
   - 改了什么
   - 为什么改
   - 做了哪些测试
   - 可能带来的影响
