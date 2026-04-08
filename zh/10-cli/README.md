<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude Code Guide" src="../resources/logos/claude-howto-logo.svg">
</picture>

# CLI 参考

## 概览

Claude Code CLI（命令行界面）是与 Claude Code 交互的主要方式。它提供了强大的选项，可用于运行查询、管理会话、配置模型，以及把 Claude 集成进你的开发工作流。

## 架构

```mermaid
graph TD
    A["用户终端"] -->|"claude [options] [query]"| B["Claude Code CLI"]
    B -->|交互式| C["REPL 模式"]
    B -->|"--print"| D["Print 模式（SDK）"]
    B -->|"--resume"| E["恢复会话"]
    C -->|对话| F["Claude API"]
    D -->|单次查询| F
    E -->|加载上下文| F
    F -->|响应| G["输出"]
    G -->|text/json/stream-json| H["终端/管道"]
```

## CLI 命令

| Command | Description | Example |
|---------|-------------|---------|
| `claude` | 启动交互式 REPL | `claude` |
| `claude "query"` | 以初始提示启动 REPL | `claude "explain this project"` |
| `claude -p "query"` | Print 模式，执行查询后退出 | `claude -p "explain this function"` |
| `cat file \| claude -p "query"` | 处理管道输入内容 | `cat logs.txt \| claude -p "explain"` |
| `claude -c` | 继续最近一次对话 | `claude -c` |
| `claude -c -p "query"` | 在 print 模式下继续会话 | `claude -c -p "check for type errors"` |
| `claude -r "<session>" "query"` | 按 ID 或名称恢复会话 | `claude -r "auth-refactor" "finish this PR"` |
| `claude update` | 更新到最新版本 | `claude update` |
| `claude mcp` | 配置 MCP servers | 见 [MCP documentation](../05-mcp/) |
| `claude mcp serve` | 将 Claude Code 作为 MCP server 运行 | `claude mcp serve` |
| `claude agents` | 列出所有已配置 subagents | `claude agents` |
| `claude auto-mode defaults` | 以 JSON 输出 auto mode 默认规则 | `claude auto-mode defaults` |
| `claude remote-control` | 启动 Remote Control server | `claude remote-control` |
| `claude plugin` | 管理 plugins（安装、启用、禁用） | `claude plugin install my-plugin` |
| `claude auth login` | 登录（支持 `--email`、`--sso`） | `claude auth login --email user@example.com` |
| `claude auth logout` | 登出当前账号 | `claude auth logout` |
| `claude auth status` | 检查认证状态（已登录返回 0，未登录返回 1） | `claude auth status` |

## 核心参数

| Flag | Description | Example |
|------|-------------|---------|
| `-p, --print` | 输出响应但不进入交互模式 | `claude -p "query"` |
| `-c, --continue` | 加载最近一次对话 | `claude --continue` |
| `-r, --resume` | 按 ID 或名称恢复指定会话 | `claude --resume auth-refactor` |
| `-v, --version` | 输出版本号 | `claude -v` |
| `-w, --worktree` | 在隔离的 git worktree 中启动 | `claude -w` |
| `-n, --name` | 会话显示名称 | `claude -n "auth-refactor"` |
| `--from-pr <number>` | 恢复与 GitHub PR 关联的会话 | `claude --from-pr 42` |
| `--remote "task"` | 在 claude.ai 上创建 Web 会话 | `claude --remote "implement API"` |
| `--remote-control, --rc` | 以 Remote Control 方式启动交互式会话 | `claude --rc` |
| `--teleport` | 在本地恢复 Web 会话 | `claude --teleport` |
| `--teammate-mode` | Agent team 显示模式 | `claude --teammate-mode tmux` |
| `--bare` | 极简模式（跳过 hooks、skills、plugins、MCP、auto memory、CLAUDE.md） | `claude --bare` |
| `--enable-auto-mode` | 解锁 auto 权限模式 | `claude --enable-auto-mode` |
| `--channels` | 订阅 MCP channel plugins | `claude --channels discord,telegram` |
| `--chrome` / `--no-chrome` | 启用/禁用 Chrome 浏览器集成 | `claude --chrome` |
| `--effort` | 设置思考强度等级 | `claude --effort high` |
| `--init` / `--init-only` | 运行初始化 hooks | `claude --init` |
| `--maintenance` | 运行 maintenance hooks 后退出 | `claude --maintenance` |
| `--disable-slash-commands` | 禁用所有 skills 和 slash commands | `claude --disable-slash-commands` |
| `--no-session-persistence` | 禁用会话保存（print 模式） | `claude -p --no-session-persistence "query"` |

### 交互模式 vs Print 模式

```mermaid
graph LR
    A["claude"] -->|默认| B["交互式 REPL"]
    A -->|"-p flag"| C["Print 模式"]
    B -->|特性| D["多轮对话<br>Tab 补全<br>历史记录<br>Slash commands"]
    C -->|特性| E["单次查询<br>可脚本化<br>可管道化<br>JSON 输出"]
```

**交互模式**（默认）：
```bash
# 启动交互式会话
claude

# 带初始提示启动
claude "explain the authentication flow"
```

**Print 模式**（非交互）：
```bash
# 单次查询后退出
claude -p "what does this function do?"

# 处理文件内容
cat error.log | claude -p "explain this error"

# 与其他工具串联
claude -p "list todos" | grep "URGENT"
```

## 模型与配置

| Flag | Description | Example |
|------|-------------|---------|
| `--model` | 设置模型（sonnet、opus、haiku 或完整模型名） | `claude --model opus` |
| `--fallback-model` | 过载时自动回退的模型 | `claude -p --fallback-model sonnet "query"` |
| `--agent` | 为当前会话指定 agent | `claude --agent my-custom-agent` |
| `--agents` | 通过 JSON 定义自定义 subagents | 见 [工作区与目录](#工作区与目录) |
| `--effort` | 设置 effort 等级（low、medium、high、max） | `claude --effort high` |

### 模型选择示例

```bash
# 使用 Opus 4.6 处理复杂任务
claude --model opus "design a caching strategy"

# 使用 Haiku 4.5 处理快速任务
claude --model haiku -p "format this JSON"

# 使用完整模型名
claude --model claude-sonnet-4-6-20250929 "review this code"

# 加入 fallback 提高稳定性
claude -p --model opus --fallback-model sonnet "analyze architecture"

# 使用 opusplan（Opus 负责规划，Sonnet 负责执行）
claude --model opusplan "design and implement the caching layer"
```

## System Prompt 自定义

| Flag | Description | Example |
|------|-------------|---------|
| `--system-prompt` | 替换整个默认 prompt | `claude --system-prompt "You are a Python expert"` |
| `--system-prompt-file` | 从文件加载 prompt（仅 print 模式） | `claude -p --system-prompt-file ./prompt.txt "query"` |
| `--append-system-prompt` | 追加到默认 prompt 后面 | `claude --append-system-prompt "Always use TypeScript"` |

### System Prompt 示例

```bash
# 完全自定义 persona
claude --system-prompt "You are a senior security engineer. Focus on vulnerabilities."

# 追加特定说明
claude --append-system-prompt "Always include unit tests with code examples"

# 从文件加载复杂 prompt
claude -p --system-prompt-file ./prompts/code-reviewer.txt "review main.py"
```

### System Prompt 参数对比

| Flag | Behavior | Interactive | Print |
|------|----------|-------------|-------|
| `--system-prompt` | 替换整个默认 system prompt | ✅ | ✅ |
| `--system-prompt-file` | 用文件中的 prompt 替换 | ❌ | ✅ |
| `--append-system-prompt` | 追加到默认 system prompt 后 | ✅ | ✅ |

**`--system-prompt-file` 只能用于 print 模式。交互模式请使用 `--system-prompt` 或 `--append-system-prompt`。**

## 工具与权限管理

| Flag | Description | Example |
|------|-------------|---------|
| `--tools` | 限制可用的内置工具 | `claude -p --tools "Bash,Edit,Read" "query"` |
| `--allowedTools` | 无需提示即可执行的工具 | `"Bash(git log:*)" "Read"` |
| `--disallowedTools` | 从上下文中移除的工具 | `"Bash(rm:*)" "Edit"` |
| `--dangerously-skip-permissions` | 跳过所有权限提示 | `claude --dangerously-skip-permissions` |
| `--permission-mode` | 以指定权限模式启动 | `claude --permission-mode auto` |
| `--permission-prompt-tool` | 用于权限处理的 MCP 工具 | `claude -p --permission-prompt-tool mcp_auth "query"` |
| `--enable-auto-mode` | 解锁 auto 权限模式 | `claude --enable-auto-mode` |

### 权限示例

```bash
# 只读模式，适合代码评审
claude --permission-mode plan "review this codebase"

# 仅允许安全工具
claude --tools "Read,Grep,Glob" -p "find all TODO comments"

# 允许特定 git 命令无需确认
claude --allowedTools "Bash(git status:*)" "Bash(git log:*)"

# 阻止危险操作
claude --disallowedTools "Bash(rm -rf:*)" "Bash(git push --force:*)"
```

## 输出与格式

| Flag | Description | Options | Example |
|------|-------------|---------|---------|
| `--output-format` | 指定输出格式（print 模式） | `text`, `json`, `stream-json` | `claude -p --output-format json "query"` |
| `--input-format` | 指定输入格式（print 模式） | `text`, `stream-json` | `claude -p --input-format stream-json` |
| `--verbose` | 启用详细日志 | | `claude --verbose` |
| `--include-partial-messages` | 包含流式事件 | 需要 `stream-json` | `claude -p --output-format stream-json --include-partial-messages "query"` |
| `--json-schema` | 获取符合 schema 的校验后 JSON | | `claude -p --json-schema '{"type":"object"}' "query"` |
| `--max-budget-usd` | print 模式的最大费用预算 | | `claude -p --max-budget-usd 5.00 "query"` |

### 输出格式示例

```bash
# 纯文本（默认）
claude -p "explain this code"

# 供程序使用的 JSON
claude -p --output-format json "list all functions in main.py"

# 实时处理用的流式 JSON
claude -p --output-format stream-json "generate a long report"

# 带 schema 校验的结构化输出
claude -p --json-schema '{"type":"object","properties":{"bugs":{"type":"array"}}}' \
  "find bugs in this code and return as JSON"
```

## 工作区与目录

| Flag | Description | Example |
|------|-------------|---------|
| `--add-dir` | 添加额外工作目录 | `claude --add-dir ../apps ../lib` |
| `--setting-sources` | 逗号分隔的 setting sources | `claude --setting-sources user,project` |
| `--settings` | 从文件或 JSON 加载 settings | `claude --settings ./settings.json` |
| `--plugin-dir` | 从目录加载 plugins（可重复） | `claude --plugin-dir ./my-plugin` |

### 多目录示例

```bash
# 跨多个项目目录工作
claude --add-dir ../frontend ../backend ../shared "find all API endpoints"

# 加载自定义 settings
claude --settings '{"model":"opus","verbose":true}' "complex task"
```

## MCP 配置

| Flag | Description | Example |
|------|-------------|---------|
| `--mcp-config` | 从 JSON 加载 MCP servers | `claude --mcp-config ./mcp.json` |
| `--strict-mcp-config` | 仅使用指定的 MCP 配置 | `claude --strict-mcp-config --mcp-config ./mcp.json` |
| `--channels` | 订阅 MCP channel plugins | `claude --channels discord,telegram` |

### MCP 示例

```bash
# 加载 GitHub MCP server
claude --mcp-config ./github-mcp.json "list open PRs"

# 严格模式，仅使用指定 servers
claude --strict-mcp-config --mcp-config ./production-mcp.json "deploy to staging"
```

## 会话管理

| Flag | Description | Example |
|------|-------------|---------|
| `--session-id` | 使用指定会话 ID（UUID） | `claude --session-id "550e8400-..."` |
| `--fork-session` | 恢复会话时创建新会话 | `claude --resume abc123 --fork-session` |

### 会话示例

```bash
# 继续最近一次对话
claude -c

# 恢复具名会话
claude -r "feature-auth" "continue implementing login"

# fork 会话以尝试另一种方案
claude --resume feature-auth --fork-session "try alternative approach"

# 使用指定 session ID
claude --session-id "550e8400-e29b-41d4-a716-446655440000" "continue"
```

### Session Fork

从已有会话分出一个分支，用于试验：

```bash
# fork 一个会话，尝试不同实现
claude --resume abc123 --fork-session "try alternative implementation"

# fork 并附带自定义消息
claude -r "feature-auth" --fork-session "test with different architecture"
```

**适用场景：**
- 尝试替代实现，而不影响原会话
- 并行试验不同方案
- 从成功工作的基础上派生多个变体
- 在不影响主会话的前提下测试破坏性改动

原会话保持不变，fork 出来的会成为一个新的独立会话。

## 高价值使用场景

### 1. CI/CD 集成

在 CI/CD 流水线中使用 Claude Code 完成自动化代码评审、测试和文档生成。

**GitHub Actions 示例：**

```yaml
name: AI Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: Run Code Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude -p --output-format json \
            --max-turns 1 \
            "Review the changes in this PR for:
            - Security vulnerabilities
            - Performance issues
            - Code quality
            Output as JSON with 'issues' array" > review.json

      - name: Post Review Comment
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const review = JSON.parse(fs.readFileSync('review.json', 'utf8'));
            // 处理并发布 review comments
```

**Jenkins Pipeline：**

```groovy
pipeline {
    agent any
    stages {
        stage('AI Review') {
            steps {
                sh '''
                    claude -p --output-format json \
                      --max-turns 3 \
                      "Analyze test coverage and suggest missing tests" \
                      > coverage-analysis.json
                '''
            }
        }
    }
}
```

### 2. 脚本管道处理

把文件、日志和数据通过 Claude 做分析。

**日志分析：**

```bash
# 分析错误日志
tail -1000 /var/log/app/error.log | claude -p "summarize these errors and suggest fixes"

# 从访问日志中找模式
cat access.log | claude -p "identify suspicious access patterns"

# 分析 git 历史
git log --oneline -50 | claude -p "summarize recent development activity"
```

**代码处理：**

```bash
# 评审单个文件
cat src/auth.ts | claude -p "review this authentication code for security issues"

# 生成文档
cat src/api/*.ts | claude -p "generate API documentation in markdown"

# 找 TODO 并排序优先级
grep -r "TODO" src/ | claude -p "prioritize these TODOs by importance"
```

### 3. 多会话工作流

用多个对话线程管理复杂项目。

```bash
# 启动一个 feature branch 会话
claude -r "feature-auth" "let's implement user authentication"

# 之后继续这个会话
claude -r "feature-auth" "add password reset functionality"

# fork 出另一种方案
claude --resume feature-auth --fork-session "try OAuth instead"

# 在不同 feature 会话之间切换
claude -r "feature-payments" "continue with Stripe integration"
```

### 4. 自定义 Agent 配置

为团队工作流定义专用 agents。

```bash
# 将 agents 配置保存到文件
cat > ~/.claude/agents.json << 'EOF'
{
  "reviewer": {
    "description": "Code reviewer for PR reviews",
    "prompt": "Review code for quality, security, and maintainability.",
    "model": "opus"
  },
  "documenter": {
    "description": "Documentation specialist",
    "prompt": "Generate clear, comprehensive documentation.",
    "model": "sonnet"
  },
  "refactorer": {
    "description": "Code refactoring expert",
    "prompt": "Suggest and implement clean code refactoring.",
    "tools": ["Read", "Edit", "Glob"]
  }
}
EOF

# 在会话中使用 agents
claude --agents "$(cat ~/.claude/agents.json)" "review the auth module"
```

### 5. 批处理

用一致的设置批量处理多个查询。

```bash
# 处理多个文件
for file in src/*.ts; do
  echo "Processing $file..."
  claude -p --model haiku "summarize this file: $(cat $file)" >> summaries.md
done

# 批量代码评审
find src -name "*.py" -exec sh -c '
  echo "## $1" >> review.md
  cat "$1" | claude -p "brief code review" >> review.md
' _ {} \;

# 为所有模块生成测试
for module in $(ls src/modules/); do
  claude -p "generate unit tests for src/modules/$module" > "tests/$module.test.ts"
done
```

### 6. 面向安全的开发

使用权限控制实现更安全的操作方式。

```bash
# 只读安全审计
claude --permission-mode plan \
  --tools "Read,Grep,Glob" \
  "audit this codebase for security vulnerabilities"

# 阻止危险命令
claude --disallowedTools "Bash(rm:*)" "Bash(curl:*)" "Bash(wget:*)" \
  "help me clean up this project"

# 受限自动化
claude -p --max-turns 2 \
  --allowedTools "Read" "Glob" \
  "find all hardcoded credentials"
```

### 7. JSON API 集成

通过 `jq` 解析，把 Claude 当作可编程 API 使用。

```bash
# 获取结构化分析结果
claude -p --output-format json \
  --json-schema '{"type":"object","properties":{"functions":{"type":"array"},"complexity":{"type":"string"}}}' \
  "analyze main.py and return function list with complexity rating"

# 配合 jq 做处理
claude -p --output-format json "list all API endpoints" | jq '.endpoints[]'

# 在脚本中使用
RESULT=$(claude -p --output-format json "is this code secure? answer with {secure: boolean, issues: []}" < code.py)
if echo "$RESULT" | jq -e '.secure == false' > /dev/null; then
  echo "Security issues found!"
  echo "$RESULT" | jq '.issues[]'
fi
```

### jq 解析示例

使用 `jq` 解析并处理 Claude 输出的 JSON：

```bash
# 提取指定字段
claude -p --output-format json "analyze this code" | jq '.result'

# 过滤数组元素
claude -p --output-format json "list issues" | jq -r '.issues[] | select(.severity=="high")'

# 提取多个字段
claude -p --output-format json "describe the project" | jq -r '.{name, version, description}'

# 转成 CSV
claude -p --output-format json "list functions" | jq -r '.functions[] | [.name, .lineCount] | @csv'

# 条件处理
claude -p --output-format json "check security" | jq 'if .vulnerabilities | length > 0 then "UNSAFE" else "SAFE" end'

# 提取嵌套值
claude -p --output-format json "analyze performance" | jq '.metrics.cpu.usage'

# 处理整个数组
claude -p --output-format json "find todos" | jq '.todos | length'

# 转换输出结构
claude -p --output-format json "list improvements" | jq 'map({title: .title, priority: .priority})'
```

---

## Models

Claude Code 支持多个模型，它们有不同的能力特点：

| Model | ID | Context Window | Notes |
|-------|-----|----------------|-------|
| Opus 4.6 | `claude-opus-4-6` | 1M tokens | 能力最强，支持自适应 effort levels |
| Sonnet 4.6 | `claude-sonnet-4-6` | 1M tokens | 在速度和能力之间取得平衡 |
| Haiku 4.5 | `claude-haiku-4-5` | 1M tokens | 速度最快，适合快速任务 |

### 模型选择

```bash
# 使用短名称
claude --model opus "complex architectural review"
claude --model sonnet "implement this feature"
claude --model haiku -p "format this JSON"

# 使用 opusplan 别名（Opus 规划，Sonnet 执行）
claude --model opusplan "design and implement the API"

# 在会话中切换 fast mode
/fast
```

### Effort Levels（Opus 4.6）

Opus 4.6 支持自适应推理和 effort level：

```bash
# 通过 CLI 参数设置 effort level
claude --effort high "complex review"

# 通过 slash command 设置 effort level
/effort high

# 通过环境变量设置 effort level
export CLAUDE_CODE_EFFORT_LEVEL=high   # low, medium, high, or max (Opus 4.6 only)
```

提示词中的 “ultrathink” 关键字会激活深度推理。`max` effort level 仅 Opus 4.6 支持。

---

## 关键环境变量

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_API_KEY` | 用于认证的 API key |
| `ANTHROPIC_MODEL` | 覆盖默认模型 |
| `ANTHROPIC_CUSTOM_MODEL_OPTION` | API 的自定义模型选项 |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | 覆盖默认 Opus 模型 ID |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | 覆盖默认 Sonnet 模型 ID |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | 覆盖默认 Haiku 模型 ID |
| `MAX_THINKING_TOKENS` | 设置扩展思考 token 预算 |
| `CLAUDE_CODE_EFFORT_LEVEL` | 设置 effort level（`low`/`medium`/`high`/`max`） |
| `CLAUDE_CODE_SIMPLE` | 极简模式，由 `--bare` 启用 |
| `CLAUDE_CODE_DISABLE_AUTO_MEMORY` | 禁用自动 CLAUDE.md 更新 |
| `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS` | 禁用后台任务执行 |
| `CLAUDE_CODE_DISABLE_CRON` | 禁用定时/cron 任务 |
| `CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS` | 禁用 git 相关说明 |
| `CLAUDE_CODE_DISABLE_TERMINAL_TITLE` | 禁用终端标题更新 |
| `CLAUDE_CODE_DISABLE_1M_CONTEXT` | 禁用 1M token 上下文窗口 |
| `CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK` | 禁用非流式 fallback |
| `CLAUDE_CODE_ENABLE_TASKS` | 启用任务列表功能 |
| `CLAUDE_CODE_TASK_LIST_ID` | 跨会话共享的命名任务目录 |
| `CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION` | 打开/关闭 prompt suggestions（`true`/`false`） |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | 启用实验性的 agent teams |
| `CLAUDE_CODE_NEW_INIT` | 使用新的初始化流程 |
| `CLAUDE_CODE_SUBAGENT_MODEL` | subagent 执行所用模型 |
| `CLAUDE_CODE_PLUGIN_SEED_DIR` | plugin seed 文件目录 |
| `CLAUDE_CODE_SUBPROCESS_ENV_SCRUB` | 从子进程中清理掉的环境变量 |
| `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` | 覆盖自动压缩百分比 |
| `CLAUDE_STREAM_IDLE_TIMEOUT_MS` | 流空闲超时时间（毫秒） |
| `SLASH_COMMAND_TOOL_CHAR_BUDGET` | slash command 工具字符预算 |
| `ENABLE_TOOL_SEARCH` | 启用工具搜索能力 |
| `MAX_MCP_OUTPUT_TOKENS` | MCP 工具输出的最大 token 数 |

---

## 快速参考

### 最常用命令

```bash
# 交互式会话
claude

# 快速提问
claude -p "how do I..."

# 继续对话
claude -c

# 处理文件
cat file.py | claude -p "review this"

# 供脚本使用的 JSON 输出
claude -p --output-format json "query"
```

### 常见参数组合

| Use Case | Command |
|----------|---------|
| 快速代码评审 | `cat file | claude -p "review"` |
| 结构化输出 | `claude -p --output-format json "query"` |
| 安全探索 | `claude --permission-mode plan` |
| 带安全护栏的自主执行 | `claude --enable-auto-mode --permission-mode auto` |
| CI/CD 集成 | `claude -p --max-turns 3 --output-format json` |
| 恢复工作 | `claude -r "session-name"` |
| 自定义模型 | `claude --model opus "complex task"` |
| 极简模式 | `claude --bare "quick query"` |
| 费用受限运行 | `claude -p --max-budget-usd 2.00 "analyze code"` |

---

## 故障排查

### 找不到命令

**Problem:** `claude: command not found`

**Solutions:**
- 安装 Claude Code：`npm install -g @anthropic-ai/claude-code`
- 检查 PATH 是否包含 npm 全局 bin 目录
- 尝试使用完整路径运行：`npx claude`

### API Key 问题

**Problem:** 认证失败

**Solutions:**
- 设置 API key：`export ANTHROPIC_API_KEY=your-key`
- 检查 key 是否有效，且额度是否足够
- 确认 key 是否有权使用所请求的模型

### 找不到会话

**Problem:** 无法恢复会话

**Solutions:**
- 列出可用会话，确认正确的名称/ID
- 会话可能在长时间不活跃后过期
- 使用 `-c` 继续最近一次会话

### 输出格式问题

**Problem:** JSON 输出格式不正确

**Solutions:**
- 使用 `--json-schema` 强制输出结构
- 在 prompt 中补充更明确的 JSON 要求
- 使用 `--output-format json`，不要只是在 prompt 里口头要求输出 JSON

### 权限被拒绝

**Problem:** 工具执行被阻止

**Solutions:**
- 检查 `--permission-mode` 设置
- 查看 `--allowedTools` 和 `--disallowedTools` 参数
- 做自动化时可谨慎使用 `--dangerously-skip-permissions`

---

## 更多资源

- **[Official CLI Reference](https://code.claude.com/docs/en/cli-reference)** - 完整命令参考
- **[Headless Mode Documentation](https://code.claude.com/docs/en/headless)** - 自动化执行
- **[Slash Commands](../01-slash-commands/)** - Claude 内部的自定义快捷命令
- **[Memory Guide](../02-memory/)** - 通过 CLAUDE.md 提供持久上下文
- **[MCP Protocol](../05-mcp/)** - 外部工具集成
- **[Advanced Features](../09-advanced-features/)** - 规划模式、扩展思考等
- **[Subagents Guide](../04-subagents/)** - 委派式任务执行

---

*属于 [Claude Code Guide](../) 指南系列的一部分*
