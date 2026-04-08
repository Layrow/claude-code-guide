#!/bin/bash
# 在 commit 前运行测试
# Hook: PreToolUse（matcher: Bash） - 检查当前命令是否为 git commit
# 注意：Claude Code 没有 “PreCommit” 这个 hook 事件。应使用带 Bash matcher 的 PreToolUse，
# 然后通过检查命令内容来识别 git commit 操作。

echo "🧪 正在 commit 前运行测试..."

# 检查 package.json 是否存在（Node.js 项目）
if [ -f "package.json" ]; then
  if grep -q "\"test\":" package.json; then
    npm test
    if [ $? -ne 0 ]; then
      echo "❌ 测试失败！已阻止 commit。"
      exit 1
    fi
  fi
fi

# 检查 pytest 是否可用（Python 项目）
if [ -f "pytest.ini" ] || [ -f "setup.py" ]; then
  if command -v pytest &> /dev/null; then
    pytest
    if [ $? -ne 0 ]; then
      echo "❌ 测试失败！已阻止 commit。"
      exit 1
    fi
  fi
fi

# 检查 go.mod 是否存在（Go 项目）
if [ -f "go.mod" ]; then
  go test ./...
  if [ $? -ne 0 ]; then
    echo "❌ 测试失败！已阻止 commit。"
    exit 1
  fi
fi

# 检查 Cargo.toml 是否存在（Rust 项目）
if [ -f "Cargo.toml" ]; then
  cargo test
  if [ $? -ne 0 ]; then
    echo "❌ 测试失败！已阻止 commit。"
    exit 1
  fi
fi

echo "✅ 所有测试通过！继续执行 commit。"
exit 0
