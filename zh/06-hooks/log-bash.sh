#!/bin/bash
# 记录所有 bash 命令
# Hook: PostToolUse:Bash
#
# 从 stdin 的 JSON 中读取已执行命令，并将其写入日志文件。
#
# 兼容平台：macOS、Linux、Windows（Git Bash）

# 从 stdin 读取 JSON 输入（Claude Code hook 协议）
INPUT=$(cat)

# 从 tool_input 中提取 bash 命令
# 注意：sed 的 [^"]* 在遇到 JSON 中被转义的双引号时会提前停止；
# 如果命令里包含双引号字符串，只会捕获到第一个 \" 之前的部分——
# 这是使用 sed 解析 JSON 的已知限制，但对于记录日志来说可以接受。
COMMAND=$(echo "$INPUT" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$COMMAND" ]; then
  exit 0
fi

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="$HOME/.claude/bash-commands.log"

# 如果日志目录不存在，则先创建
mkdir -p "$(dirname "$LOGFILE")"

# 记录命令
echo "[$TIMESTAMP] $COMMAND" >> "$LOGFILE"

exit 0
