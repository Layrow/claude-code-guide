#!/bin/bash
# 校验用户 prompt
# Hook: UserPromptSubmit
#
# 从 stdin 的 JSON 中读取用户 prompt，并拦截危险操作。
#
# 兼容平台：macOS、Linux、Windows（Git Bash）

# 从 stdin 读取 JSON 输入（Claude Code hook 协议）
INPUT=$(cat)

# 从 JSON 输入中提取 prompt 文本
# Claude Code 在 UserPromptSubmit 中发送字段 "user_prompt"（若没有则回退到 "prompt"）
PROMPT=$(echo "$INPUT" | sed -n 's/.*"user_prompt"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
if [ -z "$PROMPT" ]; then
  PROMPT=$(echo "$INPUT" | sed -n 's/.*"prompt"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
fi

if [ -z "$PROMPT" ]; then
  exit 0
fi

# 检查危险操作
DANGEROUS_PATTERNS=(
  "rm -rf /"
  "delete database"
  "drop database"
  "format disk"
  "dd if="
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$PROMPT" | grep -qi "$pattern"; then
    printf '{"decision": "block", "reason": "检测到危险操作：%s"}' "$pattern"
    exit 0
  fi
done

# 检查生产环境部署
if echo "$PROMPT" | grep -qiE "(deploy|push).*production"; then
  if [ ! -f ".deployment-approved" ]; then
    echo '{"decision": "block", "reason": "生产环境部署需要审批。请先创建 .deployment-approved 文件后再继续。"}'
    exit 0
  fi
fi

# 在某些操作中检查是否缺少必要上下文
if echo "$PROMPT" | grep -qi "refactor"; then
  if [ ! -d "tests" ] && [ ! -d "test" ]; then
    printf '{"additionalContext": "警告：在没有测试的情况下进行重构存在风险。建议先补充测试。"}'
  fi
fi

exit 0
