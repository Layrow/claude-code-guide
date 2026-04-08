---
description: 暂存所有变更、创建 commit，并推送到远端（请谨慎使用）
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git push:*), Bash(git diff:*), Bash(git log:*), Bash(git pull:*)
---

# Commit and Push Everything

⚠️ **注意**：会暂存**所有**变更、创建 commit，并推送到远端。只有在你确认这些改动都应该一起提交时才使用。

## Workflow

### 1. Analyze Changes
并行运行：
- `git status` - 显示已修改/新增/删除/未跟踪文件
- `git diff --stat` - 显示变更统计
- `git log -1 --oneline` - 查看最近一次提交，参考提交信息风格

### 2. Safety Checks

**❌ 如果检测到以下情况，必须停止并发出警告：**
- Secrets: `.env*`, `*.key`, `*.pem`, `credentials.json`, `secrets.yaml`, `id_rsa`, `*.p12`, `*.pfx`, `*.cer`
- API Keys: 任何带真实值的 `*_API_KEY`、`*_SECRET`、`*_TOKEN` 变量（不包括 `your-api-key`、`xxx`、`placeholder` 这类占位符）
- Large files: 未使用 Git LFS 且 `>10MB`
- Build artifacts: `node_modules/`, `dist/`, `build/`, `__pycache__/`, `*.pyc`, `.venv/`
- Temp files: `.DS_Store`, `thumbs.db`, `*.swp`, `*.tmp`

**API Key Validation:**
检查修改过的文件中是否包含如下模式：
```bash
OPENAI_API_KEY=sk-proj-xxxxx  # ❌ 检测到真实 key！
AWS_SECRET_KEY=AKIA...         # ❌ 检测到真实 key！
STRIPE_API_KEY=sk_live_...    # ❌ 检测到真实 key！

# ✅ 可接受的占位符：
API_KEY=your-api-key-here
SECRET_KEY=placeholder
TOKEN=xxx
API_KEY=<your-key>
SECRET=${YOUR_SECRET}
```

**✅ 需要确认：**
- `.gitignore` 配置正确
- 没有 merge conflict
- 当前分支正确（如果是 main/master 要发出警告）
- API keys 仅为占位符

### 3. Request Confirmation

展示摘要：
```
📊 Changes Summary:
- X files modified, Y added, Z deleted
- Total: +AAA insertions, -BBB deletions

🔒 Safety: ✅ No secrets | ✅ No large files | ⚠️ [warnings]
🌿 Branch: [name] → origin/[name]

I will: git add . → commit → push

Type 'yes' to proceed or 'no' to cancel.
```

**必须等待用户明确输入 `yes` 后才能继续。**

### 4. Execute (After Confirmation)

按顺序运行：
```bash
git add .
git status  # Verify staging
```

### 5. Generate Commit Message

分析变更并生成 conventional commit：

**格式：**
```
[type]: 简要摘要（不超过 72 个字符）

- 关键改动 1
- 关键改动 2
- 关键改动 3
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`

**示例：**
```
docs: Update concept README files with comprehensive documentation

- Add architecture diagrams and tables
- Include practical examples
- Expand best practices sections
```

### 6. Commit and Push

```bash
git commit -m "$(cat <<'EOF'
[Generated commit message]
EOF
)"
git push  # If fails: git pull --rebase && git push
git log -1 --oneline --decorate  # Verify
```

### 7. Confirm Success

```
✅ Successfully pushed to remote!

Commit: [hash] [message]
Branch: [branch] → origin/[branch]
Files changed: X (+insertions, -deletions)
```

## Error Handling

- **git add fails**: 检查权限、文件锁，确认仓库已初始化
- **git commit fails**: 修复 pre-commit hooks，检查 git config（`user.name`/`user.email`）
- **git push fails**:
  - 非 fast-forward：`git pull --rebase && git push`
  - 远端分支不存在：`git push -u origin [branch]`
  - 受保护分支：改走 PR 流程

## When to Use

✅ **适合：**
- 多文件文档更新
- 包含测试和文档的功能开发
- 跨多个文件的缺陷修复
- 项目范围的格式化或重构
- 配置变更

❌ **避免：**
- 不确定自己要提交什么
- 含有 secrets 或敏感数据
- 在受保护分支上直接提交且没有评审
- 存在 merge conflict
- 需要更细粒度的提交历史
- pre-commit hooks 仍在失败

## Alternatives

如果用户希望更细地控制，可以建议：
1. **Selective staging**: 只审查/暂存特定文件
2. **Interactive staging**: 使用 `git add -p` 按 patch 选择
3. **PR workflow**: 创建分支 → 推送 → 发起 PR（使用 `/pr` 命令）

**⚠️ 记住**：推送前始终先审查变更。如果拿不准，就改用单独的 git 命令来获得更高的可控性。
