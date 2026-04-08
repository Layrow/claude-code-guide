<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-code-guide-logo-dark.svg">
  <img alt="Claude Code Guide" src="../resources/logos/claude-code-guide-logo.svg">
</picture>

# MCP (Model Context Protocol)

这个文件夹包含了关于 MCP server 配置方式以及如何在 Claude Code 中使用 MCP 的完整文档与示例。

## Overview

MCP（Model Context Protocol）是一种标准化协议，让 Claude 可以访问外部工具、API 和实时数据源。和 Memory 不同，MCP 提供的是对**动态变化数据**的实时访问能力。

关键特性：
- 对外部服务的实时访问
- 实时数据同步
- 可扩展架构
- 安全认证
- 基于工具的交互方式

## MCP Architecture

```mermaid
graph TB
    A["Claude"]
    B["MCP Server"]
    C["External Service"]

    A -->|Request: list_issues| B
    B -->|Query| C
    C -->|Data| B
    B -->|Response| A

    A -->|Request: create_issue| B
    B -->|Action| C
    C -->|Result| B
    B -->|Response| A

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#e8f5e9,stroke:#333,color:#333
```

## MCP Ecosystem

```mermaid
graph TB
    A["Claude"] -->|MCP| B["Filesystem<br/>MCP Server"]
    A -->|MCP| C["GitHub<br/>MCP Server"]
    A -->|MCP| D["Database<br/>MCP Server"]
    A -->|MCP| E["Slack<br/>MCP Server"]
    A -->|MCP| F["Google Docs<br/>MCP Server"]

    B -->|File I/O| G["Local Files"]
    C -->|API| H["GitHub Repos"]
    D -->|Query| I["PostgreSQL/MySQL"]
    E -->|Messages| J["Slack Workspace"]
    F -->|Docs| K["Google Drive"]

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#f3e5f5,stroke:#333,color:#333
    style G fill:#e8f5e9,stroke:#333,color:#333
    style H fill:#e8f5e9,stroke:#333,color:#333
    style I fill:#e8f5e9,stroke:#333,color:#333
    style J fill:#e8f5e9,stroke:#333,color:#333
    style K fill:#e8f5e9,stroke:#333,color:#333
```

## MCP Installation Methods

Claude Code 支持多种传输协议来连接 MCP servers：

### HTTP Transport (Recommended)

```bash
# 基础 HTTP 连接
claude mcp add --transport http notion https://mcp.notion.com/mcp

# 带认证请求头的 HTTP 连接
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"
```

### Stdio Transport (Local)

适用于本地运行的 MCP server：

```bash
# 本地 Node.js server
claude mcp add --transport stdio myserver -- npx @myorg/mcp-server

# 带环境变量
claude mcp add --transport stdio myserver --env KEY=value -- npx server
```

### SSE Transport (Deprecated)

SSE（Server-Sent Events）传输方式已被 `http` 取代，但仍然受支持：

```bash
claude mcp add --transport sse legacy-server https://example.com/sse
```

### WebSocket Transport

WebSocket 适用于需要长连接双向通信的场景：

```bash
claude mcp add --transport ws realtime-server wss://example.com/mcp
```

### Windows-Specific Note

在原生 Windows（非 WSL）中，针对 npx 命令请使用 `cmd /c`：

```bash
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package
```

### OAuth 2.0 Authentication

Claude Code 支持需要 OAuth 2.0 的 MCP server。连接启用了 OAuth 的 server 时，Claude Code 会处理完整认证流程：

```bash
# 连接到启用 OAuth 的 MCP server（交互式流程）
claude mcp add --transport http my-service https://my-service.example.com/mcp

# 预先配置 OAuth 凭据，用于非交互式设置
claude mcp add --transport http my-service https://my-service.example.com/mcp \
  --client-id "your-client-id" \
  --client-secret "your-client-secret" \
  --callback-port 8080
```

| Feature | Description |
|---------|-------------|
| **Interactive OAuth** | 使用 `/mcp` 触发基于浏览器的 OAuth 流程 |
| **Pre-configured OAuth clients** | 内置常见服务（如 Notion、Stripe 等）的 OAuth client（v2.1.30+） |
| **Pre-configured credentials** | 使用 `--client-id`、`--client-secret`、`--callback-port` 做自动化配置 |
| **Token storage** | Token 会安全存储在系统 keychain 中 |
| **Step-up auth** | 支持对高权限操作做 step-up authentication |
| **Discovery caching** | 会缓存 OAuth discovery metadata，加快重连 |
| **Metadata override** | 可通过 `.mcp.json` 中的 `oauth.authServerMetadataUrl` 覆盖默认 OAuth metadata discovery 地址 |

#### Overriding OAuth Metadata Discovery

如果某个 MCP server 在标准 OAuth metadata 端点（`/.well-known/oauth-authorization-server`）上返回错误，但提供了可正常使用的 OIDC 端点，你可以告诉 Claude Code 从特定 URL 获取 OAuth metadata。在 server 配置的 `oauth` 对象中设置 `authServerMetadataUrl`：

```json
{
  "mcpServers": {
    "my-server": {
      "type": "http",
      "url": "https://mcp.example.com/mcp",
      "oauth": {
        "authServerMetadataUrl": "https://auth.example.com/.well-known/openid-configuration"
      }
    }
  }
}
```

该 URL 必须使用 `https://`。这个功能要求 Claude Code v2.1.64 或更高版本。

### Claude.ai MCP Connectors

你在 Claude.ai 账号中配置的 MCP servers 会自动在 Claude Code 中可用。这意味着你通过 Claude.ai Web 界面建立的 MCP 连接，不需要额外配置就能在 Claude Code 中访问。

Claude.ai MCP connectors 也支持 `--print` 模式（v2.1.83+），方便非交互和脚本化使用。

如果你想在 Claude Code 中禁用 Claude.ai MCP servers，可以把 `ENABLE_CLAUDEAI_MCP_SERVERS` 环境变量设为 `false`：

```bash
ENABLE_CLAUDEAI_MCP_SERVERS=false claude
```

> **Note:** 该功能仅对使用 Claude.ai 账号登录的用户可用。

## MCP Setup Process

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Config as Config File
    participant Service as External Service

    User->>Claude: Type /mcp
    Claude->>Claude: List available MCP servers
    Claude->>User: Show options
    User->>Claude: Select GitHub MCP
    Claude->>Config: Update configuration
    Config->>Claude: Activate connection
    Claude->>Service: Test connection
    Service-->>Claude: Authentication successful
    Claude->>User: ✅ MCP connected!
```

## MCP Tool Search

当 MCP 工具描述超过上下文窗口的 10% 时，Claude Code 会自动启用 tool search，以便高效选择正确工具，而不会让模型上下文被大量工具说明淹没。

| Setting | Value | Description |
|---------|-------|-------------|
| `ENABLE_TOOL_SEARCH` | `auto` (default) | 当工具描述超过上下文 10% 时自动启用 |
| `ENABLE_TOOL_SEARCH` | `auto:<N>` | 在工具数量达到自定义阈值 `N` 时自动启用 |
| `ENABLE_TOOL_SEARCH` | `true` | 始终启用，不管工具数量多少 |
| `ENABLE_TOOL_SEARCH` | `false` | 禁用；所有工具描述都会完整发送 |

> **Note:** Tool search 需要 Sonnet 4+ 或 Opus 4+。Haiku 不支持 tool search。

## Dynamic Tool Updates

Claude Code 支持 MCP `list_changed` 通知。当某个 MCP server 动态新增、删除或修改可用工具时，Claude Code 会接收更新并自动调整工具列表，无需重连或重启。

## MCP Elicitation

MCP server 可以通过交互式对话框向用户请求结构化输入（v2.1.49+）。这允许 MCP server 在工作流中途请求额外信息，例如：确认操作、从选项中选择、填写必需字段，从而让 MCP 交互具备更强的可交互性。

## Tool Description and Instruction Cap

从 v2.1.84 开始，Claude Code 会对每个 MCP server 的工具描述和说明强制施加 **2 KB 上限**。这样可以防止单个 server 使用冗长工具定义占据过多上下文，降低上下文膨胀风险，并保持交互效率。

## MCP Prompts as Slash Commands

MCP server 可以暴露 prompts，并在 Claude Code 中显示为 slash commands。命名格式如下：

```
/mcp__<server>__<prompt>
```

例如，如果一个名为 `github` 的 server 暴露了一个名为 `review` 的 prompt，那么你就可以通过 `/mcp__github__review` 来调用它。

## Server Deduplication

当同一个 MCP server 在多个作用域（local、project、user）中都有定义时，local 配置优先。这使你可以用本地配置覆盖 project 或 user 级配置，而不会发生冲突。

## MCP Resources via @ Mentions

你可以通过 `@` 引用语法在 prompt 中直接引用 MCP resource：

```
@server-name:protocol://resource/path
```

例如，引用一个数据库资源：

```
@database:postgres://mydb/users
```

这样 Claude 就能获取该 MCP resource 的内容，并把它直接纳入当前对话上下文。

## MCP Scopes

MCP 配置可存储在不同作用域中，对应不同共享范围：

| Scope | Location | Description | Shared With | Requires Approval |
|-------|----------|-------------|-------------|------------------|
| **Local** (default) | `~/.claude.json` (under project path) | 当前用户、当前项目私有（旧版本中叫 `project`） | 仅你自己 | No |
| **Project** | `.mcp.json` | 会提交进 git 仓库 | 团队成员 | Yes（首次使用） |
| **User** | `~/.claude.json` | 跨所有项目可用（旧版本中叫 `global`） | 仅你自己 | No |

### Using Project Scope

将项目级 MCP 配置保存在 `.mcp.json`：

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.github.com/mcp"
    }
  }
}
```

团队成员在首次使用 project MCP 时会看到审批提示。

## MCP Configuration Management

### Adding MCP Servers

```bash
# 添加基于 HTTP 的 server
claude mcp add --transport http github https://api.github.com/mcp

# 添加本地 stdio server
claude mcp add --transport stdio database -- npx @company/db-server

# 列出所有 MCP servers
claude mcp list

# 查看某个 server 的详细信息
claude mcp get github

# 删除某个 MCP server
claude mcp remove github

# 重置项目级审批选择
claude mcp reset-project-choices

# 从 Claude Desktop 导入
claude mcp add-from-claude-desktop
```

## Available MCP Servers Table

| MCP Server | Purpose | Common Tools | Auth | Real-time |
|------------|---------|--------------|------|-----------|
| **Filesystem** | 文件操作 | read, write, delete | OS permissions | ✅ Yes |
| **GitHub** | 仓库管理 | list_prs, create_issue, push | OAuth | ✅ Yes |
| **Slack** | 团队沟通 | send_message, list_channels | Token | ✅ Yes |
| **Database** | SQL 查询 | query, insert, update | Credentials | ✅ Yes |
| **Google Docs** | 文档访问 | read, write, share | OAuth | ✅ Yes |
| **Asana** | 项目管理 | create_task, update_status | API Key | ✅ Yes |
| **Stripe** | 支付数据 | list_charges, create_invoice | API Key | ✅ Yes |
| **Memory** | 持久记忆 | store, retrieve, delete | Local | ❌ No |

## Practical Examples

### Example 1: GitHub MCP Configuration

**File:** `.mcp.json`（项目根目录）

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Available GitHub MCP Tools:**

#### Pull Request Management
- `list_prs` - 列出仓库中的所有 PR
- `get_pr` - 获取 PR 详情，包括 diff
- `create_pr` - 创建新 PR
- `update_pr` - 更新 PR 描述或标题
- `merge_pr` - 将 PR 合并到主分支
- `review_pr` - 添加 review 评论

**Example request:**
```
/mcp__github__get_pr 456

# 返回：
Title: Add dark mode support
Author: @alice
Description: Implements dark theme using CSS variables
Status: OPEN
Reviewers: @bob, @charlie
```

#### Issue Management
- `list_issues` - 列出所有 issues
- `get_issue` - 获取 issue 详情
- `create_issue` - 创建新 issue
- `close_issue` - 关闭 issue
- `add_comment` - 给 issue 添加评论

#### Repository Information
- `get_repo_info` - 仓库详情
- `list_files` - 文件树结构
- `get_file_content` - 读取文件内容
- `search_code` - 在代码库中搜索

#### Commit Operations
- `list_commits` - 提交历史
- `get_commit` - 获取指定 commit 的详情
- `create_commit` - 创建新 commit

**Setup**:
```bash
export GITHUB_TOKEN="your_github_token"
# 或者直接通过 CLI 添加：
claude mcp add --transport stdio github -- npx @modelcontextprotocol/server-github
```

### Environment Variable Expansion in Configuration

MCP 配置支持环境变量展开，并支持默认回退值。`${VAR}` 和 `${VAR:-default}` 语法可用于以下字段：`command`、`args`、`env`、`url` 和 `headers`。

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}",
        "X-Custom-Header": "${CUSTOM_HEADER:-default-value}"
      }
    },
    "local-server": {
      "command": "${MCP_BIN_PATH:-npx}",
      "args": ["${MCP_PACKAGE:-@company/mcp-server}"],
      "env": {
        "DB_URL": "${DATABASE_URL:-postgresql://localhost/dev}"
      }
    }
  }
}
```

变量在运行时展开：
- `${VAR}` - 使用环境变量；如果没设置就报错
- `${VAR:-default}` - 优先使用环境变量，未设置时回退到默认值

### Example 2: Database MCP Setup

**Configuration:**

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-database"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost/mydb"
      }
    }
  }
}
```

**Example Usage:**

```markdown
User: 获取所有订单数大于 10 的用户

Claude: 我来查询你的数据库并找出这些信息。

# 使用 MCP database 工具：
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# 结果：
- Alice: 15 orders
- Bob: 12 orders
- Charlie: 11 orders
```

**Setup**:
```bash
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
# 或者直接通过 CLI 添加：
claude mcp add --transport stdio database -- npx @modelcontextprotocol/server-database
```

### Example 3: Multi-MCP Workflow

**Scenario: Daily Report Generation**

```markdown
# 使用多个 MCP 生成日报

## Setup
1. GitHub MCP - 获取 PR 指标
2. Database MCP - 查询销售数据
3. Slack MCP - 发送报告
4. Filesystem MCP - 保存报告

## Workflow

### Step 1: 获取 GitHub 数据
/mcp__github__list_prs completed:true last:7days

输出：
- Total PRs: 42
- Average merge time: 2.3 hours
- Review turnaround: 1.1 hours

### Step 2: 查询数据库
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

输出：
- Sales: 247
- Revenue: $12,450

### Step 3: 生成报告
将数据整合为 HTML 报告

### Step 4: 保存到文件系统
将 report.html 写入 /reports/

### Step 5: 发送到 Slack
将摘要发送到 #daily-reports 频道

最终输出：
✅ Report generated and posted
📊 47 PRs merged this week
💰 $12,450 in daily sales
```

**Setup**:
```bash
export GITHUB_TOKEN="your_github_token"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="your_slack_token"
# 通过 CLI 添加每个 MCP server，或在 .mcp.json 中统一配置
```

### Example 4: Filesystem MCP Operations

**Configuration:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    }
  }
}
```

**Available Operations:**

| Operation | Command | Purpose |
|-----------|---------|---------|
| List files | `ls ~/projects` | 显示目录内容 |
| Read file | `cat src/main.ts` | 读取文件内容 |
| Write file | `create docs/api.md` | 创建新文件 |
| Edit file | `edit src/app.ts` | 修改文件 |
| Search | `grep "async function"` | 在文件中搜索 |
| Delete | `rm old-file.js` | 删除文件 |

**Setup**:
```bash
# 直接通过 CLI 添加：
claude mcp add --transport stdio filesystem -- npx @modelcontextprotocol/server-filesystem /home/user/projects
```

## MCP vs Memory: Decision Matrix

```mermaid
graph TD
    A["Need external data?"]
    A -->|No| B["Use Memory"]
    A -->|Yes| C["Does it change frequently?"]
    C -->|No/Rarely| B
    C -->|Yes/Often| D["Use MCP"]

    B -->|Stores| E["Preferences<br/>Context<br/>History"]
    D -->|Accesses| F["Live APIs<br/>Databases<br/>Services"]

    style A fill:#fff3e0,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#fff3e0,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#e8f5e9,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
```

## Request/Response Pattern

```mermaid
sequenceDiagram
    participant App as Claude
    participant MCP as MCP Server
    participant DB as Database

    App->>MCP: Request: "SELECT * FROM users WHERE id=1"
    MCP->>DB: Execute query
    DB-->>MCP: Result set
    MCP-->>App: Return parsed data
    App->>App: Process result
    App->>App: Continue task

    Note over MCP,DB: 实时访问<br/>无缓存
```

## Environment Variables

请把敏感凭据放到环境变量中：

```bash
# ~/.bashrc or ~/.zshrc
export GITHUB_TOKEN="ghp_xxxxxxxxxxxxx"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="xoxb-xxxxxxxxxxxxx"
```

然后在 MCP 配置中引用：

```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

## Claude as MCP Server (`claude mcp serve`)

Claude Code 自己也可以作为 MCP server 供其他应用调用。这让外部工具、编辑器和自动化系统能够通过标准 MCP 协议使用 Claude 的能力。

```bash
# 通过 stdio 启动 Claude Code 作为 MCP server
claude mcp serve
```

其他应用随后就可以像连接普通 stdio MCP server 一样连接它。比如，在另一个 Claude Code 实例里把 Claude Code 本身添加成一个 MCP server：

```bash
claude mcp add --transport stdio claude-agent -- claude mcp serve
```

这在构建多 agent 工作流时很有用，比如一个 Claude 实例去编排另一个 Claude 实例。

## Managed MCP Configuration (Enterprise)

对于企业部署，IT 管理员可以通过 `managed-mcp.json` 配置文件来强制执行 MCP server 策略。这个文件可以完全控制组织范围内哪些 MCP server 被允许、哪些被禁止。

**Location:**
- macOS: `/Library/Application Support/ClaudeCode/managed-mcp.json`
- Linux: `~/.config/ClaudeCode/managed-mcp.json`
- Windows: `%APPDATA%\ClaudeCode\managed-mcp.json`

**Features:**
- `allowedMcpServers` -- 允许使用的 server 白名单
- `deniedMcpServers` -- 禁止使用的 server 黑名单
- 支持按 server 名称、命令和 URL 模式匹配
- 在用户配置之前先应用组织级 MCP 策略
- 阻止未授权 server 连接

**Example configuration:**

```json
{
  "allowedMcpServers": [
    {
      "serverName": "github",
      "serverUrl": "https://api.github.com/mcp"
    },
    {
      "serverName": "company-internal",
      "serverCommand": "company-mcp-server"
    }
  ],
  "deniedMcpServers": [
    {
      "serverName": "untrusted-*"
    },
    {
      "serverUrl": "http://*"
    }
  ]
}
```

> **Note:** 当 `allowedMcpServers` 和 `deniedMcpServers` 同时匹配某个 server 时，deny 规则优先。

## Plugin-Provided MCP Servers

插件可以自带自己的 MCP servers，安装插件后就会自动可用。插件提供的 MCP server 有两种定义方式：

1. **独立 `.mcp.json`** -- 在插件根目录放置 `.mcp.json`
2. **在 `plugin.json` 中内联定义** -- 直接写进插件 manifest

使用 `${CLAUDE_PLUGIN_ROOT}` 变量可以引用相对于插件安装目录的路径：

```json
{
  "mcpServers": {
    "plugin-tools": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/dist/mcp-server.js"],
      "env": {
        "CONFIG_PATH": "${CLAUDE_PLUGIN_ROOT}/config.json"
      }
    }
  }
}
```

## Subagent-Scoped MCP

你可以在 agent frontmatter 中通过 `mcpServers:` 直接内联定义 MCP servers，让它只作用于某个特定 subagent，而不是整个项目。当某个 agent 需要访问某个专用 MCP server，而其他 agent 不需要时，这非常有用。

```yaml
---
mcpServers:
  my-tool:
    type: http
    url: https://my-tool.example.com/mcp
---

You are an agent with access to my-tool for specialized operations.
```

subagent 作用域内的 MCP servers 只会在该 agent 的执行上下文中可用，不会共享给父 agent 或 sibling agents。

## MCP Output Limits

Claude Code 会对 MCP 工具输出施加限制，以防上下文溢出：

| Limit | Threshold | Behavior |
|-------|-----------|----------|
| **Warning** | 10,000 tokens | 输出过大时显示警告 |
| **Default max** | 25,000 tokens | 超过该限制的部分会被截断 |
| **Disk persistence** | 50,000 characters | 超过 50K 字符的结果会持久化到磁盘 |

最大输出限制可以通过 `MAX_MCP_OUTPUT_TOKENS` 环境变量调整：

```bash
# 将最大输出提高到 50,000 tokens
export MAX_MCP_OUTPUT_TOKENS=50000
```

## Solving Context Bloat with Code Execution

随着 MCP 使用规模扩大，当你连接了几十个 server、上百甚至上千个工具时，会遇到一个非常棘手的问题：**context bloat（上下文膨胀）**。这几乎可以说是 MCP 在大规模使用场景下的最大问题之一，而 Anthropic 工程团队提出了一个很优雅的解决思路：**使用代码执行来代替直接工具调用**。

> **Source**: [Code Execution with MCP: Building More Efficient Agents](https://www.anthropic.com/engineering/code-execution-with-mcp) — Anthropic Engineering Blog

### The Problem: Two Sources of Token Waste

**1. 工具定义本身就会挤爆上下文窗口**

大多数 MCP client 会预先加载所有工具定义。当接入成千上万个工具时，模型甚至在看到用户请求之前，就先得处理数十万 token 的工具说明。

**2. 中间结果还会额外消耗 token**

每个中间工具结果都会经过模型上下文。比如把一个会议纪要从 Google Drive 转到 Salesforce，完整纪要会穿过上下文 **两次**：一次读取时，一次写入目标系统时。一个 2 小时会议的转录文本，可能就会额外消耗 50,000+ tokens。

```mermaid
graph LR
    A["Model"] -->|"Tool Call: getDocument"| B["MCP Server"]
    B -->|"Full transcript (50K tokens)"| A
    A -->|"Tool Call: updateRecord<br/>(re-sends full transcript)"| B
    B -->|"Confirmation"| A

    style A fill:#ffcdd2,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
```

### The Solution: MCP Tools as Code APIs

与其把工具定义和结果都塞进上下文，不如让 agent **写代码**，把 MCP 工具当成 API 来调用。代码在一个沙箱执行环境里运行，只有最终结果才返回给模型。

```mermaid
graph LR
    A["Model"] -->|"Writes code"| B["Code Execution<br/>Environment"]
    B -->|"Calls tools directly"| C["MCP Servers"]
    C -->|"Data stays in<br/>execution env"| B
    B -->|"Only final result<br/>(minimal tokens)"| A

    style A fill:#c8e6c9,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
```

#### How It Works

MCP tools 会被呈现成一个由 typed functions 组成的文件树：

```
servers/
├── google-drive/
│   ├── getDocument.ts
│   └── index.ts
├── salesforce/
│   ├── updateRecord.ts
│   └── index.ts
└── ...
```

每个工具文件都包含一个带类型的 wrapper：

```typescript
// ./servers/google-drive/getDocument.ts
import { callMCPTool } from "../../../client.js";

interface GetDocumentInput {
  documentId: string;
}

interface GetDocumentResponse {
  content: string;
}

export async function getDocument(
  input: GetDocumentInput
): Promise<GetDocumentResponse> {
  return callMCPTool<GetDocumentResponse>(
    'google_drive__get_document', input
  );
}
```

agent 然后会编写代码来编排这些工具：

```typescript
import * as gdrive from './servers/google-drive';
import * as salesforce from './servers/salesforce';

// 数据直接在工具之间流动——不会经过模型
const transcript = (
  await gdrive.getDocument({ documentId: 'abc123' })
).content;

await salesforce.updateRecord({
  objectType: 'SalesMeeting',
  recordId: '00Q5f000001abcXYZ',
  data: { Notes: transcript }
});
```

**结果：token 使用量从约 150,000 降到约 2,000，减少了 98.7%。**

### Key Benefits

| Benefit | Description |
|---------|-------------|
| **Progressive Disclosure** | agent 可以像浏览文件系统一样，只加载它真正需要的工具定义，而不是一开始就加载全部工具 |
| **Context-Efficient Results** | 数据会在执行环境中先过滤/转换，再返回给模型 |
| **Powerful Control Flow** | 循环、条件分支和错误处理都在代码里运行，不需要反复经过模型 |
| **Privacy Preservation** | 中间数据（PII、敏感记录）停留在执行环境中，不进入模型上下文 |
| **State Persistence** | agent 可以把中间结果存成文件，并构建可复用的 skill functions |

#### Example: Filtering Large Datasets

```typescript
// 不使用代码执行——全部 10,000 行数据都会进入上下文
// TOOL CALL: gdrive.getSheet(sheetId: 'abc123')
//   -> 在上下文中返回 10,000 行

// 使用代码执行——先在执行环境中完成过滤
const allRows = await gdrive.getSheet({ sheetId: 'abc123' });
const pendingOrders = allRows.filter(
  row => row["Status"] === 'pending'
);
console.log(`Found ${pendingOrders.length} pending orders`);
console.log(pendingOrders.slice(0, 5)); // 只有 5 行真正到达模型
```

#### Example: Loop Without Round-Tripping

```typescript
// 轮询部署通知——整个过程都在代码中运行
let found = false;
while (!found) {
  const messages = await slack.getChannelHistory({
    channel: 'C123456'
  });
  found = messages.some(
    m => m.text.includes('deployment complete')
  );
  if (!found) await new Promise(r => setTimeout(r, 5000));
}
console.log('Deployment notification received');
```

### Trade-offs to Consider

代码执行也会引入自己的复杂度。运行 agent 生成的代码通常意味着你需要：

- 一个**安全的沙箱执行环境**，并配置合适的资源限制
- 对执行代码进行**监控和日志记录**
- 相较于直接工具调用，承担额外的**基础设施成本**

因此，需要结合实际情况权衡收益和成本。对于只连接少量 MCP server 的 agent，直接工具调用可能更简单；但对于大规模场景（几十个 server、上百个工具），代码执行会是显著改进。

### MCPorter: A Runtime for MCP Tool Composition

[MCPorter](https://github.com/steipete/mcporter) 是一个 TypeScript runtime 和 CLI 工具集，可以让调用 MCP servers 变得更实际、更少样板代码，同时也通过按需暴露工具和 typed wrappers 帮助减少 context bloat。

**它解决什么问题：** 与其一开始就加载所有 MCP server 的所有工具定义，MCPorter 允许你按需发现、检查并调用特定工具，让上下文保持精简。

**Key features:**

| Feature | Description |
|---------|-------------|
| **Zero-config discovery** | 自动从 Cursor、Claude、Codex 或本地配置中发现 MCP servers |
| **Typed tool clients** | `mcporter emit-ts` 可生成 `.d.ts` 接口和可直接运行的 wrappers |
| **Composable API** | `createServerProxy()` 会把工具暴露成 camelCase 方法，并带 `.text()`、`.json()`、`.markdown()` 辅助方法 |
| **CLI generation** | `mcporter generate-cli` 可把任意 MCP server 转成一个独立 CLI，并支持 `--include-tools` / `--exclude-tools` 过滤 |
| **Parameter hiding** | 可选参数默认隐藏，以减少 schema 噪声 |

**Installation:**

```bash
npx mcporter list          # 无需安装——立即发现 servers
pnpm add mcporter          # 添加到项目中
brew install steipete/tap/mcporter  # 通过 Homebrew 安装到 macOS
```

**Example — composing tools in TypeScript:**

```typescript
import { createRuntime, createServerProxy } from "mcporter";

const runtime = await createRuntime();
const gdrive = createServerProxy(runtime, "google-drive");
const salesforce = createServerProxy(runtime, "salesforce");

// 数据在工具之间流动，不经过模型上下文
const doc = await gdrive.getDocument({ documentId: "abc123" });
await salesforce.updateRecord({
  objectType: "SalesMeeting",
  recordId: "00Q5f000001abcXYZ",
  data: { Notes: doc.text() }
});
```

**Example — CLI tool call:**

```bash
# 直接调用某个工具
npx mcporter call linear.create_comment issueId:ENG-123 body:'Looks good!'

# 列出可用 servers 和 tools
npx mcporter list
```

MCPorter 是对上面“代码执行”思路的很好补充：它提供了把 MCP 工具当成 typed APIs 来调用的运行时基础设施，从而更容易避免让中间数据进入模型上下文。

## Best Practices

### Security Considerations

#### Do's ✅
- 所有凭据都放进环境变量
- 定期轮换 token 和 API key（建议每月）
- 能用只读 token 时就用只读 token
- 将 MCP server 的访问范围限制到最小
- 监控 MCP server 使用情况和访问日志
- 外部服务优先使用 OAuth
- 对 MCP 请求实施 rate limiting
- 上生产前先测试 MCP 连接
- 记录所有正在使用的 MCP 连接
- 保持 MCP server package 为最新版本

#### Don'ts ❌
- 不要把凭据硬编码进配置文件
- 不要把 token 或 secrets 提交进 git
- 不要在团队聊天或邮件里分享 token
- 不要把个人 token 用在团队项目里
- 不要授予不必要权限
- 不要忽略认证错误
- 不要把 MCP endpoint 暴露到公网
- 不要用 root/admin 权限运行 MCP server
- 不要在日志中缓存敏感数据
- 不要禁用认证机制

### Configuration Best Practices

1. **Version Control**：可以把 `.mcp.json` 放进 git，但 secret 必须通过环境变量注入
2. **Least Privilege**：每个 MCP server 只给最少必要权限
3. **Isolation**：条件允许时，让不同 MCP server 在不同进程中运行
4. **Monitoring**：记录所有 MCP 请求和错误，便于审计
5. **Testing**：部署到生产前，先验证所有 MCP 配置

### Performance Tips

- 在应用层缓存高频访问数据
- 尽量使用更具体的 MCP 查询，减少数据传输
- 监控 MCP 操作响应时间
- 对外部 API 适当做 rate limiting
- 批量执行多个操作时优先使用 batching

## Installation Instructions

### Prerequisites
- 已安装 Node.js 和 npm
- 已安装 Claude Code CLI
- 已准备外部服务所需 API token / 凭据

### Step-by-Step Setup

1. **通过 CLI 添加你的第一个 MCP server**（例如 GitHub）：
```bash
claude mcp add --transport stdio github -- npx @modelcontextprotocol/server-github
```

   或者在项目根目录创建 `.mcp.json`：
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

2. **设置环境变量：**
```bash
export GITHUB_TOKEN="your_github_personal_access_token"
```

3. **测试连接：**
```bash
claude /mcp
```

4. **使用 MCP 工具：**
```bash
/mcp__github__list_prs
/mcp__github__create_issue "Title" "Description"
```

### Installation for Specific Services

**GitHub MCP:**
```bash
npm install -g @modelcontextprotocol/server-github
```

**Database MCP:**
```bash
npm install -g @modelcontextprotocol/server-database
```

**Filesystem MCP:**
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**Slack MCP:**
```bash
npm install -g @modelcontextprotocol/server-slack
```

## Troubleshooting

### MCP Server Not Found
```bash
# 确认 MCP server 已安装
npm list -g @modelcontextprotocol/server-github

# 如果缺失则安装
npm install -g @modelcontextprotocol/server-github
```

### Authentication Failed
```bash
# 确认环境变量已设置
echo $GITHUB_TOKEN

# 如有需要重新导出
export GITHUB_TOKEN="your_token"

# 确认 token 具备正确权限
# 在这里检查 GitHub token scopes: https://github.com/settings/tokens
```

### Connection Timeout
- 检查网络连通性：`ping api.github.com`
- 确认 API endpoint 可访问
- 检查 API 的 rate limits
- 尝试在配置中增加 timeout
- 检查是否有防火墙或代理问题

### MCP Server Crashes
- 查看 MCP server 日志：`~/.claude/logs/`
- 确认所有环境变量都已设置
- 确保文件权限正确
- 尝试重新安装 MCP server package
- 检查是否有其他进程占用了同一端口

## Related Concepts

### Memory vs MCP
- **Memory**：存储持久、相对不变的数据（偏好、上下文、历史）
- **MCP**：访问实时、动态变化的数据（API、数据库、实时服务）

### When to Use Each
- **Use Memory** for：用户偏好、对话历史、沉淀下来的上下文
- **Use MCP** for：当前 GitHub issues、实时数据库查询、动态外部数据

### Integration with Other Claude Features
- 把 MCP 和 Memory 组合起来，可以形成更丰富的上下文
- 在 prompt 中调用 MCP 工具，可以让 Claude 有更强的推理基础
- 利用多个 MCP server 构建复杂工作流

## Additional Resources

- [Official MCP Documentation](https://code.claude.com/docs/en/mcp)
- [MCP Protocol Specification](https://modelcontextprotocol.io/specification)
- [MCP GitHub Repository](https://github.com/modelcontextprotocol/servers)
- [Available MCP Servers](https://github.com/modelcontextprotocol/servers)
- [MCPorter](https://github.com/steipete/mcporter) — 用于调用 MCP servers 的 TypeScript runtime 和 CLI，几乎无需样板代码
- [Code Execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) — Anthropic 关于解决 context bloat 的工程博客
- [Claude Code CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Claude API Documentation](https://docs.anthropic.com/en/docs/claude-code/overview)
