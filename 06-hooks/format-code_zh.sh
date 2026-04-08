#!/bin/bash
# 在写入前自动格式化代码
# Hook: PreToolUse:Write
#
# 从 stdin 的 JSON 中读取目标文件路径，并对磁盘上已存在的文件
# 直接执行原地格式化。对于新文件，则通过后续的 PostToolUse hook
# 在 Claude 写入完成后再执行格式化。
#
# 兼容平台：macOS、Linux、Windows（Git Bash）

# 从 stdin 读取 JSON 输入（Claude Code hook 协议）
INPUT=$(cat)

# 使用 sed 提取 file_path（兼容所有平台）
FILE_PATH=$(echo "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# 检测文件类型并按对应格式化工具处理
case "$FILE_PATH" in
  *.js|*.jsx|*.ts|*.tsx)
    if command -v prettier &> /dev/null; then
      prettier --write "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.py)
    if command -v black &> /dev/null; then
      black "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.go)
    if command -v gofmt &> /dev/null; then
      gofmt -w "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.rs)
    if command -v rustfmt &> /dev/null; then
      rustfmt "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.java)
    if command -v google-java-format &> /dev/null; then
      google-java-format -i "$FILE_PATH" 2>/dev/null
    fi
    ;;
esac

exit 0
