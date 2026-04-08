<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-code-guide-logo-dark.svg">
  <img alt="Claude Code Guide" src="../resources/logos/claude-code-guide-logo.svg">
</picture>

# Hooks

Hooks 是在 Claude Code session 中，针对特定事件自动执行的脚本。它们可用于自动化、校验、权限管理和自定义工作流。

## Overview

Hooks 是自动化动作（shell commands、HTTP webhooks、LLM prompts 或 subagent evaluations），当 Claude Code 中发生特定事件时会自动触发。它们通过 JSON 输入接收上下文，并通过退出码和 JSON 输出与 Claude Code 通信。

**Key features:**
- 事件驱动自动化
- 基于 JSON 的输入/输出
- 支持 command、prompt、HTTP 和 agent 四类 hook
- 支持针对具体工具的模式匹配

## Configuration

Hooks 通过 settings 文件中的特定结构进行配置：

- `~/.claude/settings.json` - 用户级设置（所有项目）
- `.claude/settings.json` - 项目级设置（可共享、可提交）
- `.claude/settings.local.json` - 本地项目设置（不提交）
- Managed policy - 组织级设置
- Plugin `hooks/hooks.json` - 插件作用域 hooks
- Skill/Agent frontmatter - 组件生命周期 hooks

### Basic Configuration Structure

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {
            "type": "command",
            "command": "your-command-here",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

**Key fields:**

| Field | Description | Example |
|-------|-------------|---------|
| `matcher` | 用于匹配工具名的模式（区分大小写） | `"Write"`、`"Edit\|Write"`、`"*"` |
| `hooks` | hook 定义数组 | `[{ "type": "command", ... }]` |
| `type` | Hook 类型：`"command"`（bash）、`"prompt"`（LLM）、`"http"`（webhook）或 `"agent"`（subagent） | `"command"` |
| `command` | 要执行的 shell command | `"$CLAUDE_PROJECT_DIR/.claude/hooks/format.sh"` |
| `timeout` | 可选超时时间（秒，默认 60） | `30` |
| `once` | 如果为 `true`，则该 hook 每个 session 只运行一次 | `true` |

### Matcher Patterns

| Pattern | Description | Example |
|---------|-------------|---------|
| Exact string | 匹配某个具体工具 | `"Write"` |
| Regex pattern | 匹配多个工具 | `"Edit\|Write"` |
| Wildcard | 匹配所有工具 | `"*"` 或 `""` |
| MCP tools | 按 server 和 tool 模式匹配 | `"mcp__memory__.*"` |

## Hook Types

Claude Code 支持四种 hook 类型：

### Command Hooks

默认 hook 类型。执行 shell command，并通过 JSON stdin/stdout 和退出码通信。

```json
{
  "type": "command",
  "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate.py\"",
  "timeout": 60
}
```

### HTTP Hooks

> Added in v2.1.63.

远程 webhook endpoint，接收与 command hook 相同的 JSON 输入。HTTP hook 会向 URL 发起 JSON POST，并接收 JSON 响应。启用 sandbox 时，HTTP hook 会通过 sandbox 路由。为了安全，URL 中如果要插入环境变量，必须显式声明 `allowedEnvVars` 列表。

```json
{
  "hooks": {
    "PostToolUse": [{
      "type": "http",
      "url": "https://my-webhook.example.com/hook",
      "matcher": "Write"
    }]
  }
}
```

**Key properties:**
- `"type": "http"` -- 表示这是一个 HTTP hook
- `"url"` -- webhook endpoint 地址
- 当 sandbox 启用时，会通过 sandbox 路由
- 如果 URL 中使用环境变量插值，必须显式设置 `allowedEnvVars`

### Prompt Hooks

由 LLM 评估的 hook，hook 内容本身是一个 prompt，由 Claude 来判断。主要用于 `Stop` 和 `SubagentStop` 事件，做更智能的任务完成性检查。

```json
{
  "type": "prompt",
  "prompt": "Evaluate if Claude completed all requested tasks.",
  "timeout": 30
}
```

LLM 会评估该 prompt，并返回结构化决策（详见 [Prompt-Based Hooks](#prompt-based-hooks)）。

### Agent Hooks

基于 subagent 的校验型 hook，会启动一个专门的 agent 来做判断或执行复杂检查。和 prompt hook（单轮 LLM 评估）不同，agent hook 可以使用工具，并执行多步骤推理。

```json
{
  "type": "agent",
  "prompt": "Verify the code changes follow our architecture guidelines. Check the relevant design docs and compare.",
  "timeout": 120
}
```

**Key properties:**
- `"type": "agent"` -- 表示这是一个 agent hook
- `"prompt"` -- 发给 subagent 的任务说明
- agent 可以使用工具（Read、Grep、Bash 等）来完成检查
- 返回与 prompt hook 类似的结构化决策

## Hook Events

Claude Code 目前支持 **25 个 hook events**：

| Event | When Triggered | Matcher Input | Can Block | Common Use |
|-------|---------------|---------------|-----------|------------|
| **SessionStart** | session 开始 / 恢复 / clear / compact 时 | startup/resume/clear/compact | No | 环境初始化 |
| **InstructionsLoaded** | CLAUDE.md 或 rules 文件加载后 | (none) | No | 修改 / 过滤说明 |
| **UserPromptSubmit** | 用户提交 prompt 时 | (none) | Yes | 校验 prompt |
| **PreToolUse** | 工具执行前 | Tool name | Yes (allow/deny/ask) | 校验、修改输入 |
| **PermissionRequest** | 权限对话框出现时 | Tool name | Yes | 自动允许 / 拒绝 |
| **PostToolUse** | 工具成功执行后 | Tool name | No | 添加上下文、反馈 |
| **PostToolUseFailure** | 工具执行失败后 | Tool name | No | 错误处理、记录日志 |
| **Notification** | 发送通知时 | Notification type | No | 自定义通知 |
| **SubagentStart** | subagent 启动时 | Agent type name | No | subagent 初始化 |
| **SubagentStop** | subagent 结束时 | Agent type name | Yes | subagent 校验 |
| **Stop** | Claude 完成回复时 | (none) | Yes | 任务完成检查 |
| **StopFailure** | API 错误导致当前轮结束时 | (none) | No | 错误恢复、记录日志 |
| **TeammateIdle** | agent team 中的 teammate 空闲时 | (none) | Yes | teammate 协调 |
| **TaskCompleted** | task 被标记完成时 | (none) | Yes | 任务后处理 |
| **TaskCreated** | 通过 TaskCreate 创建任务时 | (none) | No | 任务跟踪、记录日志 |
| **ConfigChange** | 配置文件变化时 | (none) | Yes（policy 除外） | 响应配置变更 |
| **CwdChanged** | 工作目录变化时 | (none) | No | 目录级初始化 |
| **FileChanged** | 被监听文件变化时 | (none) | No | 文件监控、重建 |
| **PreCompact** | 上下文压缩前 | manual/auto | No | 压缩前操作 |
| **PostCompact** | 压缩完成后 | (none) | No | 压缩后操作 |
| **WorktreeCreate** | worktree 创建中 | (none) | Yes（可返回路径） | worktree 初始化 |
| **WorktreeRemove** | worktree 移除中 | (none) | No | worktree 清理 |
| **Elicitation** | MCP server 请求用户输入时 | (none) | Yes | 输入校验 |
| **ElicitationResult** | 用户响应 elicitation 后 | (none) | Yes | 响应处理 |
| **SessionEnd** | session 终止时 | (none) | No | 清理、最终日志 |

### PreToolUse

在 Claude 生成好工具参数、但尚未执行前触发。适合用于校验或修改工具输入。

**Configuration:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py"
          }
        ]
      }
    ]
  }
}
```

**Common matchers:** `Task`、`Bash`、`Glob`、`Grep`、`Read`、`Edit`、`Write`、`WebFetch`、`WebSearch`

**Output control:**
- `permissionDecision`: `"allow"`、`"deny"` 或 `"ask"`
- `permissionDecisionReason`: 决策原因
- `updatedInput`: 修改后的工具输入参数

### PostToolUse

在工具成功执行后立刻触发。适合做验证、日志记录，或把额外上下文反馈给 Claude。

**Configuration:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.py"
          }
        ]
      }
    ]
  }
}
```

**Output control:**
- `"block"` 决策会带着反馈重新提示 Claude
- `additionalContext`: 额外添加给 Claude 的上下文

### UserPromptSubmit

在用户提交 prompt 后、Claude 开始处理前触发。

**Configuration:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-prompt.py"
          }
        ]
      }
    ]
  }
}
```

**Output control:**
- `decision`: `"block"` 表示阻止处理
- `reason`: 被阻止时的说明
- `additionalContext`: 附加到 prompt 的上下文

### Stop and SubagentStop

当 Claude 完成回复（Stop）或 subagent 完成任务（SubagentStop）时触发。支持基于 prompt 的评估，用于智能判断任务是否真正完成。

**Additional input field:** `Stop` 和 `SubagentStop` 在其 JSON 输入中都会收到一个 `last_assistant_message` 字段，包含 Claude 或该 subagent 在停止前的最后一条消息。这对评估任务完成度很有帮助。

**Configuration:**
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Evaluate if Claude completed all requested tasks.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### SubagentStart

在 subagent 开始执行时触发。matcher 输入为 agent type name，因此可以针对特定 subagent 类型设置 hook。

**Configuration:**
```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "code-review",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/subagent-init.sh"
          }
        ]
      }
    ]
  }
}
```

### SessionStart

在 session 启动或恢复时触发。可以用于持久化环境变量。

**Matchers:** `startup`、`resume`、`clear`、`compact`

**Special feature:** 使用 `CLAUDE_ENV_FILE` 可以持久保存环境变量（`CwdChanged` 和 `FileChanged` hook 中也可用）：

```bash
#!/bin/bash
if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=development' >> "$CLAUDE_ENV_FILE"
fi
exit 0
```

### SessionEnd

在 session 结束时触发，用于清理或记录最终日志。不能阻止 session 终止。

**Reason field values:**
- `clear` - 用户清空了 session
- `logout` - 用户退出登录
- `prompt_input_exit` - 用户通过 prompt 输入退出
- `other` - 其他原因

**Configuration:**
```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-cleanup.sh\""
          }
        ]
      }
    ]
  }
}
```

### Notification Event

Notification 事件更新后的 matcher 值：
- `permission_prompt` - 权限请求通知
- `idle_prompt` - 空闲状态通知
- `auth_success` - 认证成功
- `elicitation_dialog` - 向用户展示对话框

## Component-Scoped Hooks

你可以把 hooks 直接挂到具体组件（skills、agents、commands）的 frontmatter 上：

**In SKILL.md, agent.md, or command.md:**

```yaml
---
name: secure-operations
description: Perform operations with security checks
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/check.sh"
          once: true  # 每个 session 只运行一次
---
```

**组件级 hooks 支持的事件：** `PreToolUse`、`PostToolUse`、`Stop`

这样就能把 hook 直接和使用它的组件放在一起，便于维护。

### Hooks in Subagent Frontmatter

如果在 subagent frontmatter 中定义了 `Stop` hook，它会自动转换成一个只作用于该 subagent 的 `SubagentStop` hook。这样它只会在该 subagent 完成时触发，而不会在主 session 停止时触发。

```yaml
---
name: code-review-agent
description: Automated code review subagent
hooks:
  Stop:
    - hooks:
        - type: prompt
          prompt: "Verify the code review is thorough and complete."
  # 上面的 Stop hook 会自动转换成该 subagent 的 SubagentStop
---
```

## PermissionRequest Event

处理权限请求时，使用自定义输出格式：

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow|deny",
      "updatedInput": {},
      "message": "Custom message",
      "interrupt": false
    }
  }
}
```

## Hook Input and Output

### JSON Input (via stdin)

所有 hooks 都通过 stdin 接收 JSON 输入：

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/directory",
  "permission_mode": "default",
  "hook_event_name": "PreToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.js",
    "content": "..."
  },
  "tool_use_id": "toolu_01ABC123...",
  "agent_id": "agent-abc123",
  "agent_type": "main",
  "worktree": "/path/to/worktree"
}
```

**Common fields:**

| Field | Description |
|-------|-------------|
| `session_id` | 当前 session 的唯一标识 |
| `transcript_path` | 对话 transcript 文件路径 |
| `cwd` | 当前工作目录 |
| `hook_event_name` | 触发该 hook 的事件名 |
| `agent_id` | 当前执行该 hook 的 agent 标识 |
| `agent_type` | agent 类型（`"main"`、subagent 类型名等） |
| `worktree` | 若 agent 在 git worktree 中运行，则为其路径 |

### Exit Codes

| Exit Code | Meaning | Behavior |
|-----------|---------|----------|
| **0** | Success | 继续执行，并解析 stdout 中的 JSON |
| **2** | Blocking error | 阻止当前操作，并把 stderr 作为错误展示 |
| **Other** | Non-blocking error | 继续执行，仅在 verbose 模式下显示 stderr |

### JSON Output (stdout, exit code 0)

```json
{
  "continue": true,
  "stopReason": "Optional message if stopping",
  "suppressOutput": false,
  "systemMessage": "Optional warning message",
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "File is in allowed directory",
    "updatedInput": {
      "file_path": "/modified/path.js"
    }
  }
}
```

## Environment Variables

| Variable | Availability | Description |
|----------|-------------|-------------|
| `CLAUDE_PROJECT_DIR` | 所有 hooks | 项目根目录的绝对路径 |
| `CLAUDE_ENV_FILE` | SessionStart、CwdChanged、FileChanged | 用于持久保存环境变量的文件路径 |
| `CLAUDE_CODE_REMOTE` | 所有 hooks | 如果在远程环境中运行，则值为 `"true"` |
| `${CLAUDE_PLUGIN_ROOT}` | Plugin hooks | 插件目录路径 |
| `${CLAUDE_PLUGIN_DATA}` | Plugin hooks | 插件数据目录路径 |
| `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` | SessionEnd hooks | SessionEnd hooks 的超时时间（毫秒），可覆盖默认值 |

## Prompt-Based Hooks

对于 `Stop` 和 `SubagentStop` 事件，你可以使用基于 LLM 的评估：

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Review if all tasks are complete. Return your decision.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

**LLM Response Schema:**
```json
{
  "decision": "approve",
  "reason": "All tasks completed successfully",
  "continue": false,
  "stopReason": "Task complete"
}
```

## Examples

### Example 1: Bash Command Validator (PreToolUse)

**File:** `.claude/hooks/validate-bash.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"\brm\s+-rf\s+/", "拦截危险的 rm -rf / 命令"),
    (r"\bsudo\s+rm", "拦截 sudo rm 命令"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name != "Bash":
        sys.exit(0)

    command = input_data.get("tool_input", {}).get("command", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, command):
            print(message, file=sys.stderr)
            sys.exit(2)  # Exit 2 = 阻塞性错误

    sys.exit(0)

if __name__ == "__main__":
    main()
```

**Configuration:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py\""
          }
        ]
      }
    ]
  }
}
```

### Example 2: Security Scanner (PostToolUse)

**File:** `.claude/hooks/security-scan.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

SECRET_PATTERNS = [
    (r"password\s*=\s*['\"][^'\"]+['\"]", "可能存在硬编码密码"),
    (r"api[_-]?key\s*=\s*['\"][^'\"]+['\"]", "可能存在硬编码 API key"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name not in ["Write", "Edit"]:
        sys.exit(0)

    tool_input = input_data.get("tool_input", {})
    content = tool_input.get("content", "") or tool_input.get("new_string", "")
    file_path = tool_input.get("file_path", "")

    warnings = []
    for pattern, message in SECRET_PATTERNS:
        if re.search(pattern, content, re.IGNORECASE):
            warnings.append(message)

    if warnings:
        output = {
            "hookSpecificOutput": {
                "hookEventName": "PostToolUse",
                "additionalContext": f"{file_path} 的安全扫描发现警告：" + "; ".join(warnings)
            }
        }
        print(json.dumps(output))

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### Example 3: Auto-Format Code (PostToolUse)

**File:** `.claude/hooks/format-code.sh`

```bash
#!/bin/bash

# 从 stdin 读取 JSON
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))")
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('file_path', ''))")

if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
    exit 0
fi

# 按文件扩展名执行格式化
case "$FILE_PATH" in
    *.js|*.jsx|*.ts|*.tsx|*.json)
        command -v prettier &>/dev/null && prettier --write "$FILE_PATH" 2>/dev/null
        ;;
    *.py)
        command -v black &>/dev/null && black "$FILE_PATH" 2>/dev/null
        ;;
    *.go)
        command -v gofmt &>/dev/null && gofmt -w "$FILE_PATH" 2>/dev/null
        ;;
esac

exit 0
```

### Example 4: Prompt Validator (UserPromptSubmit)

**File:** `.claude/hooks/validate-prompt.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"delete\s+(all\s+)?database", "危险：删除数据库"),
    (r"rm\s+-rf\s+/", "危险：删除根目录"),
]

def main():
    input_data = json.load(sys.stdin)
    prompt = input_data.get("user_prompt", "") or input_data.get("prompt", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, prompt, re.IGNORECASE):
            output = {
                "decision": "block",
                "reason": f"已拦截：{message}"
            }
            print(json.dumps(output))
            sys.exit(0)

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### Example 5: Intelligent Stop Hook (Prompt-Based)

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "检查 Claude 是否已完成所有请求任务。检查：1）是否创建/修改了所有文件？2）是否还有未解决错误？如果未完成，请说明缺少了什么。",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Example 6: Context Usage Tracker (Hook Pairs)

通过组合 `UserPromptSubmit`（消息前）和 `Stop`（回复后）hooks，跟踪每次请求的 token 消耗。

**File:** `.claude/hooks/context-tracker.py`

```python
#!/usr/bin/env python3
"""
Context Usage Tracker - 跟踪每次请求的 token 消耗。

使用 UserPromptSubmit 作为“消息前” hook，使用 Stop 作为“回复后” hook，
从而计算每次请求的 token 增量。

Token 计数方法：
1. 字符估算（默认）：约 4 个字符 ≈ 1 个 token，无额外依赖
2. tiktoken（可选）：精度更高（约 90-95%），需先安装：pip install tiktoken
"""
import json
import os
import sys
import tempfile

# 配置
CONTEXT_LIMIT = 128000  # Claude 的上下文窗口（按你的模型调整）
USE_TIKTOKEN = False    # 如果已安装 tiktoken，可设为 True 获得更高精度


def get_state_file(session_id: str) -> str:
    """获取用于保存消息前 token 数的临时文件路径，并按 session 隔离。"""
    return os.path.join(tempfile.gettempdir(), f"claude-context-{session_id}.json")


def count_tokens(text: str) -> int:
    """
    统计文本中的 token 数。

    如果可用，优先使用 tiktoken + p50k_base 编码（约 90-95% 精度），
    否则回退到字符估算（约 80-90% 精度）。
    """
    if USE_TIKTOKEN:
        try:
            import tiktoken
            enc = tiktoken.get_encoding("p50k_base")
            return len(enc.encode(text))
        except ImportError:
            pass  # 回退到估算方式

    # 基于字符的估算：英文里大约 4 个字符对应 1 个 token
    return len(text) // 4


def read_transcript(transcript_path: str) -> str:
    """读取 transcript 文件中的所有内容并拼接。"""
    if not transcript_path or not os.path.exists(transcript_path):
        return ""

    content = []
    with open(transcript_path, "r") as f:
        for line in f:
            try:
                entry = json.loads(line.strip())
                # 从不同消息格式中提取文本内容
                if "message" in entry:
                    msg = entry["message"]
                    if isinstance(msg.get("content"), str):
                        content.append(msg["content"])
                    elif isinstance(msg.get("content"), list):
                        for block in msg["content"]:
                            if isinstance(block, dict) and block.get("type") == "text":
                                content.append(block.get("text", ""))
            except json.JSONDecodeError:
                continue

    return "\n".join(content)


def handle_user_prompt_submit(data: dict) -> None:
    """消息前 hook：保存当前 token 数，用作后续对比。"""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # 保存到临时文件，供稍后对比
    state_file = get_state_file(session_id)
    with open(state_file, "w") as f:
        json.dump({"pre_tokens": current_tokens}, f)


def handle_stop(data: dict) -> None:
    """回复后 hook：计算并输出 token 增量。"""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # 读取消息前的 token 数
    state_file = get_state_file(session_id)
    pre_tokens = 0
    if os.path.exists(state_file):
        try:
            with open(state_file, "r") as f:
                state = json.load(f)
                pre_tokens = state.get("pre_tokens", 0)
        except (json.JSONDecodeError, IOError):
            pass

    # 计算增量
    delta_tokens = current_tokens - pre_tokens
    remaining = CONTEXT_LIMIT - current_tokens
    percentage = (current_tokens / CONTEXT_LIMIT) * 100

    # 输出使用情况
    method = "tiktoken" if USE_TIKTOKEN else "estimated"
    print(f"Context ({method}): ~{current_tokens:,} tokens ({percentage:.1f}% used, ~{remaining:,} remaining)", file=sys.stderr)
    if delta_tokens > 0:
        print(f"This request: ~{delta_tokens:,} tokens", file=sys.stderr)


def main():
    data = json.load(sys.stdin)
    event = data.get("hook_event_name", "")

    if event == "UserPromptSubmit":
        handle_user_prompt_submit(data)
    elif event == "Stop":
        handle_stop(data)

    sys.exit(0)


if __name__ == "__main__":
    main()
```

**Configuration:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ]
  }
}
```

**How it works:**
1. `UserPromptSubmit` 会在 prompt 被处理前触发 - 保存当前 token 数
2. `Stop` 会在 Claude 回复后触发 - 计算增量并汇报使用量
3. 每个 session 都通过临时文件名中的 `session_id` 做隔离

**Token Counting Methods:**

| Method | Accuracy | Dependencies | Speed |
|--------|----------|--------------|-------|
| Character estimation | ~80-90% | None | <1ms |
| tiktoken (p50k_base) | ~90-95% | `pip install tiktoken` | <10ms |

> **Note:** Anthropic 还没有发布官方离线 tokenizer。以上两种方法都只是近似估算。transcript 包含用户 prompt、Claude 回复和工具输出，但**不包含** system prompts 或内部上下文。

### Example 7: Seed Auto-Mode Permissions (One-Time Setup Script)

这是一个一次性初始化脚本，用于向 `~/.claude/settings.json` 注入大约 67 条安全权限规则，其效果等价于 Claude Code auto-mode 的默认安全基线——**不依赖 hook，也不会记住未来的选择**。运行一次即可；重复运行也安全（已存在规则会自动跳过）。

**File:** `09-advanced-features/setup-auto-mode-permissions.py`

```bash
# 预览将要添加的内容
python3 09-advanced-features/setup-auto-mode-permissions.py --dry-run

# 正式写入
python3 09-advanced-features/setup-auto-mode-permissions.py
```

**What gets added:**

| Category | Examples |
|----------|---------|
| Built-in tools | `Read(*)`, `Edit(*)`, `Write(*)`, `Glob(*)`, `Grep(*)`, `Agent(*)`, `WebSearch(*)` |
| Git read | `Bash(git status:*)`, `Bash(git log:*)`, `Bash(git diff:*)` |
| Git write (local) | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git checkout:*)` |
| Package managers | `Bash(npm install:*)`, `Bash(pip install:*)`, `Bash(cargo build:*)` |
| Build & test | `Bash(make:*)`, `Bash(pytest:*)`, `Bash(go test:*)` |
| Common shell | `Bash(ls:*)`, `Bash(cat:*)`, `Bash(find:*)`, `Bash(cp:*)`, `Bash(mv:*)` |
| GitHub CLI | `Bash(gh pr view:*)`, `Bash(gh pr create:*)`, `Bash(gh issue list:*)` |

**What is intentionally excluded**（该脚本绝不会添加）：
- `rm -rf`、`sudo`、force push、`git reset --hard`
- `DROP TABLE`、`kubectl delete`、`terraform destroy`
- `npm publish`、`curl | bash`、生产环境部署

## Plugin Hooks

插件可以在 `hooks/hooks.json` 文件中携带 hooks：

**File:** `plugins/hooks/hooks.json`

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"
          }
        ]
      }
    ]
  }
}
```

**Environment Variables in Plugin Hooks:**
- `${CLAUDE_PLUGIN_ROOT}` - 插件目录路径
- `${CLAUDE_PLUGIN_DATA}` - 插件数据目录路径

这样插件就可以自带校验和自动化 hook。

## MCP Tool Hooks

MCP 工具遵循 `mcp__<server>__<tool>` 这种命名模式：

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__memory__.*",
        "hooks": [
          {
            "type": "command",
            "command": "echo '{\"systemMessage\": \"Memory operation logged\"}'"
          }
        ]
      }
    ]
  }
}
```

## Security Considerations

### Disclaimer

**风险自负**：Hooks 会执行任意 shell command。你需要自行负责：
- 你配置的命令本身
- 文件访问 / 修改权限
- 潜在的数据丢失或系统损坏
- 在进入生产环境前，先在安全环境中完成测试

### Security Notes

- **Workspace trust required:** 现在 `statusLine` 和 `fileSuggestion` hook 输出的命令，需要先接受 workspace trust 才会生效。
- **HTTP hooks and environment variables:** HTTP hooks 如果要在 URL 中插入环境变量，必须显式声明 `allowedEnvVars`。这可以防止敏感环境变量被意外发送到远端 endpoint。
- **Managed settings hierarchy:** `disableAllHooks` 现在会遵守 managed settings hierarchy，也就是说，组织级设置可以强制禁用 hooks，而个人用户无法覆盖。

### Best Practices

| Do | Don't |
|-----|-------|
| 校验并清洗所有输入 | 盲目信任输入数据 |
| 为 shell 变量加引号：`"$VAR"` | 使用未加引号的 `$VAR` |
| 阻止路径穿越（`..`） | 放行任意路径 |
| 使用带 `$CLAUDE_PROJECT_DIR` 的绝对路径 | 硬编码路径 |
| 跳过敏感文件（`.env`、`.git/`、keys） | 对所有文件一视同仁处理 |
| 先独立测试 hook | 未测试就直接部署 |
| 为 HTTP hooks 显式使用 `allowedEnvVars` | 把所有环境变量都暴露给 webhook |

## Debugging

### Enable Debug Mode

用 debug flag 启动 Claude，以查看详细 hook 日志：

```bash
claude --debug
```

### Verbose Mode

在 Claude Code 中按 `Ctrl+O` 开启 verbose mode，即可看到 hook 执行进度。

### Test Hooks Independently

```bash
# 使用示例 JSON 独立测试 hook
echo '{"tool_name": "Bash", "tool_input": {"command": "ls -la"}}' | python3 .claude/hooks/validate-bash.py

# 检查退出码
echo $?
```

## Complete Configuration Example

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py\"",
            "timeout": 10
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/format-code.sh\"",
            "timeout": 30
          },
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.py\"",
            "timeout": 10
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-prompt.py\""
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-init.sh\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Verify all tasks are complete before stopping.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

## Hook Execution Details

| Aspect | Behavior |
|--------|----------|
| **Timeout** | 默认 60 秒，可按命令单独配置 |
| **Parallelization** | 所有匹配到的 hooks 会并行执行 |
| **Deduplication** | 完全相同的 hook command 会去重 |
| **Environment** | 在当前目录下、继承 Claude Code 环境执行 |

## Troubleshooting

### Hook Not Executing
- 确认 JSON 配置语法正确
- 检查 matcher 是否真的匹配工具名
- 确保脚本存在且可执行：`chmod +x script.sh`
- 运行 `claude --debug` 查看 hook 执行日志
- 确认 hook 是从 stdin 读取 JSON，而不是从命令参数读取

### Hook Blocks Unexpectedly
- 用示例 JSON 独立测试：`echo '{"tool_name": "Write", ...}' | ./hook.py`
- 检查退出码：允许应为 0，阻止应为 2
- 检查 stderr 输出（exit code 为 2 时会展示）
