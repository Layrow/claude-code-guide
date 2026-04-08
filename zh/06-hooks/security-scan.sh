#!/bin/bash
# 在文件写入后执行安全扫描
# Hook: PostToolUse:Write
#
# 扫描文件中是否存在硬编码 secrets、API keys 和凭据。
# 如果发现问题，会通过 additionalContext 输出一个非阻塞警告。
#
# 兼容平台：macOS、Linux、Windows（Git Bash）

# 从 stdin 读取 JSON 输入（Claude Code hook 协议）
INPUT=$(cat)

# 使用 sed 提取 file_path（兼容所有平台，包括 Windows Git Bash）
# 避免依赖 grep -P（Windows Git Bash 不支持）和 python3
FILE_PATH=$(echo "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# 跳过二进制文件、vendor 目录和构建产物
case "$FILE_PATH" in
  *.png|*.jpg|*.jpeg|*.gif|*.svg|*.ico|*.woff|*.woff2|*.ttf|*.eot) exit 0 ;;
  */node_modules/*|*/.git/*|*/dist/*|*/build/*) exit 0 ;;
esac

ISSUES=""

# 检查硬编码密码
# 同时支持 JSON 格式（"password": "value"）和代码格式（password = 'value'）
# 使用 \\n 作为分隔符——它是合法的 JSON 换行转义，且可安全通过 printf 传递
if grep -qiE '"password"[[:space:]]*:[[:space:]]*"[^"]+"' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- WARNING: 检测到可能的硬编码密码\\n"
elif grep -qiE '(password|passwd|pwd)\s*=\s*'"'"'[^'"'"']+'"'"'' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- WARNING: 检测到可能的硬编码密码\\n"
fi

# 检查硬编码 API key
if grep -qiE '"(api[_-]?key|apikey|access[_-]?token)"[[:space:]]*:[[:space:]]*"[^"]+"' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- WARNING: 检测到可能的硬编码 API key\\n"
fi

# 检查硬编码 secret 和 token
if grep -qiE '(secret|token)\s*=\s*['"'"'"][^'"'"'"]+['"'"'"]' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- WARNING: 检测到可能的硬编码 secret 或 token\\n"
fi

# 检查私钥
if grep -q "BEGIN.*PRIVATE KEY" "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- WARNING: 检测到私钥\\n"
fi

# 检查 AWS keys
if grep -qE "AKIA[0-9A-Z]{16}" "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- WARNING: 检测到 AWS access key\\n"
fi

# 如果可用，则使用 semgrep 扫描
if command -v semgrep &> /dev/null; then
  semgrep --config=auto "$FILE_PATH" --quiet 2>/dev/null
fi

# 如果可用，则使用 trufflehog 扫描
if command -v trufflehog &> /dev/null; then
  trufflehog filesystem "$FILE_PATH" --only-verified --quiet 2>/dev/null
fi

# 如果发现问题，则通过 additionalContext 输出（非阻塞警告）
# 使用 Claude Code PostToolUse 协议要求的 hookSpecificOutput 格式
if [ -n "$ISSUES" ]; then
  # 为 JSON 转义 file path（反斜杠和双引号）
  # ISSUES 已经使用 \\n 作为分隔符（合法 JSON 转义）——这里只需转义双引号
  SAFE_PATH=$(printf '%s' "$FILE_PATH" | sed 's/\\/\\\\/g; s/"/\\"/g')
  SAFE_ISSUES=$(printf '%s' "$ISSUES" | sed 's/"/\\"/g')
  printf '{"hookSpecificOutput": {"hookEventName": "PostToolUse", "additionalContext": "安全扫描在 %s 中发现问题:\\n%s请进行检查，并改用环境变量管理敏感信息。"}}' "$SAFE_PATH" "$SAFE_ISSUES"
fi

exit 0
