<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-code-guide-logo-dark.svg">
  <img alt="Claude Code Guide" src="resources/logos/claude-code-guide-logo.svg">
</picture>

# Claude 核心概念完整指南

这是一份完整的参考指南，覆盖 Slash Commands、Subagents、Memory、MCP Protocol 和 Agent Skills，并配有表格、图示和真实示例。

---
## 目录

1. [Slash Commands](#slash-commands)
2. [Subagents](#subagents)
3. [Memory](#memory)
4. [MCP Protocol](#mcp-protocol)
5. [Agent Skills](#agent-skills)
6. [Plugins](#claude-code-plugins)
7. [Hooks](#hooks)
8. [Checkpoints and Rewind](#checkpoints-and-rewind)
9. [Advanced Features](#advanced-features)
10. [Comparison & Integration](#comparison--integration)

---

## Slash Commands

### Overview

Slash commands 是由用户手动触发的快捷命令，以 Markdown 文件形式存储，Claude Code 可以直接执行。它让团队能够把高频使用的 prompts 和工作流标准化。

### Architecture

```mermaid
graph TD
    A["User Input: /command-name"] -->|Triggers| B["Search .claude/commands/"]
    B -->|Finds| C["command-name.md"]
    C -->|Loads| D["Markdown Content"]
    D -->|Executes| E["Claude Processes Prompt"]
    E -->|Returns| F["Result in Context"]
```

### File Structure

```mermaid
graph LR
    A["Project Root"] -->|contains| B[".claude/commands/"]
    B -->|contains| C["optimize.md"]
    B -->|contains| D["test.md"]
    B -->|contains| E["docs/"]
    E -->|contains| F["generate-api-docs.md"]
    E -->|contains| G["generate-readme.md"]
```

### Command Organization Table

| Location | Scope | Availability | Use Case | Git Tracked |
|----------|-------|--------------|----------|-------------|
| `.claude/commands/` | 项目级 | 团队成员 | 团队工作流、共享规范 | ✅ Yes |
| `~/.claude/commands/` | 个人级 | 单个用户 | 跨项目复用的个人快捷方式 | ❌ No |
| Subdirectories | 命名空间分组 | 取决于上级目录 | 按类别组织命令 | ✅ Yes |

### Features & Capabilities

| Feature | Example | Supported |
|---------|---------|-----------|
| Shell script execution | `bash scripts/deploy.sh` | ✅ Yes |
| File references | `@path/to/file.js` | ✅ Yes |
| Bash integration | `$(git log --oneline)` | ✅ Yes |
| Arguments | `/pr --verbose` | ✅ Yes |
| MCP commands | `/mcp__github__list_prs` | ✅ Yes |

### Practical Examples

#### Example 1: Code Optimization Command

**File:** `.claude/commands/optimize.md`

```markdown
---
name: Code Optimization
description: Analyze code for performance issues and suggest optimizations
tags: performance, analysis
---

# Code Optimization

Review the provided code for the following issues in order of priority:

1. **Performance bottlenecks** - identify O(n²) operations, inefficient loops
2. **Memory leaks** - find unreleased resources, circular references
3. **Algorithm improvements** - suggest better algorithms or data structures
4. **Caching opportunities** - identify repeated computations
5. **Concurrency issues** - find race conditions or threading problems

Format your response with:
- Issue severity (Critical/High/Medium/Low)
- Location in code
- Explanation
- Recommended fix with code example
```

**Usage:**
```bash
# 用户在 Claude Code 中输入
/optimize

# Claude 会加载 prompt，并等待用户提供代码
```

#### Example 2: Pull Request Helper Command

**File:** `.claude/commands/pr.md`

```markdown
---
name: Prepare Pull Request
description: Clean up code, stage changes, and prepare a pull request
tags: git, workflow
---

# Pull Request Preparation Checklist

Before creating a PR, execute these steps:

1. Run linting: `prettier --write .`
2. Run tests: `npm test`
3. Review git diff: `git diff HEAD`
4. Stage changes: `git add .`
5. Create commit message following conventional commits:
   - `fix:` for bug fixes
   - `feat:` for new features
   - `docs:` for documentation
   - `refactor:` for code restructuring
   - `test:` for test additions
   - `chore:` for maintenance

6. Generate PR summary including:
   - What changed
   - Why it changed
   - Testing performed
   - Potential impacts
```

**Usage:**
```bash
/pr

# Claude 会按清单逐项检查，并协助准备 PR
```

#### Example 3: Hierarchical Documentation Generator

**File:** `.claude/commands/docs/generate-api-docs.md`

```markdown
---
name: Generate API Documentation
description: Create comprehensive API documentation from source code
tags: documentation, api
---

# API Documentation Generator

Generate API documentation by:

1. Scanning all files in `/src/api/`
2. Extracting function signatures and JSDoc comments
3. Organizing by endpoint/module
4. Creating markdown with examples
5. Including request/response schemas
6. Adding error documentation

Output format:
- Markdown file in `/docs/api.md`
- Include curl examples for all endpoints
- Add TypeScript types
```

### Command Lifecycle Diagram

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant FS as File System
    participant CLI as Shell/Bash

    User->>Claude: Types /optimize
    Claude->>FS: Searches .claude/commands/
    FS-->>Claude: Returns optimize.md
    Claude->>Claude: Loads Markdown content
    Claude->>User: Displays prompt context
    User->>Claude: Provides code to analyze
    Claude->>CLI: (May execute scripts)
    CLI-->>Claude: Results
    Claude->>User: Returns analysis
```

### Best Practices

| ✅ Do | ❌ Don't |
|------|---------|
| 使用清晰、面向动作的名称 | 不要为一次性任务创建命令 |
| 在 description 中写清触发词 | 不要把复杂逻辑塞进 command 里 |
| 让每个 command 聚焦单一任务 | 不要创建重复 command |
| 将项目级 commands 纳入版本控制 | 不要硬编码敏感信息 |
| 用子目录做分组整理 | 不要堆出冗长的 command 列表 |
| Prompt 保持简单、易读 | 不要使用缩写或晦涩表达 |

---

## Subagents

### Overview

Subagents 是带有隔离上下文窗口和定制 system prompt 的专用 AI 助手。它们能在保持职责边界清晰的前提下完成任务委派。

### Architecture Diagram

```mermaid
graph TB
    User["👤 User"]
    Main["🎯 Main Agent<br/>(Coordinator)"]
    Reviewer["🔍 Code Reviewer<br/>Subagent"]
    Tester["✅ Test Engineer<br/>Subagent"]
    Docs["📝 Documentation<br/>Subagent"]

    User -->|asks| Main
    Main -->|delegates| Reviewer
    Main -->|delegates| Tester
    Main -->|delegates| Docs
    Reviewer -->|returns result| Main
    Tester -->|returns result| Main
    Docs -->|returns result| Main
    Main -->|synthesizes| User
```

### Subagent Lifecycle

```mermaid
sequenceDiagram
    participant User
    participant MainAgent as Main Agent
    participant CodeReviewer as Code Reviewer<br/>Subagent
    participant Context as Separate<br/>Context Window

    User->>MainAgent: "Build new auth feature"
    MainAgent->>MainAgent: Analyze task
    MainAgent->>CodeReviewer: "Review this code"
    CodeReviewer->>Context: Initialize clean context
    Context->>CodeReviewer: Load reviewer instructions
    CodeReviewer->>CodeReviewer: Perform review
    CodeReviewer-->>MainAgent: Return findings
    MainAgent->>MainAgent: Incorporate results
    MainAgent-->>User: Provide synthesis
```

### Subagent Configuration Table

| Configuration | Type | Purpose | Example |
|---------------|------|---------|---------|
| `name` | String | Agent 标识符 | `code-reviewer` |
| `description` | String | 用途与触发语义 | `Comprehensive code quality analysis` |
| `tools` | List/String | 允许使用的能力范围 | `read, grep, diff, lint_runner` |
| `system_prompt` | Markdown | 行为说明 | 自定义规则与约束 |

### Tool Access Hierarchy

```mermaid
graph TD
    A["Subagent Configuration"] -->|Option 1| B["Inherit All Tools<br/>from Main Thread"]
    A -->|Option 2| C["Specify Individual Tools"]
    B -->|Includes| B1["File Operations"]
    B -->|Includes| B2["Shell Commands"]
    B -->|Includes| B3["MCP Tools"]
    C -->|Explicit List| C1["read, grep, diff"]
    C -->|Explicit List| C2["Bash(npm:*), Bash(test:*)"]
```

### Practical Examples

#### Example 1: Complete Subagent Setup

**File:** `.claude/agents/code-reviewer.md`

```yaml
---
name: code-reviewer
description: Comprehensive code quality and maintainability analysis
tools: read, grep, diff, lint_runner
---

# Code Reviewer Agent

You are an expert code reviewer specializing in:
- Performance optimization
- Security vulnerabilities
- Code maintainability
- Testing coverage
- Design patterns

## Review Priorities (in order)

1. **Security Issues** - Authentication, authorization, data exposure
2. **Performance Problems** - O(n²) operations, memory leaks, inefficient queries
3. **Code Quality** - Readability, naming, documentation
4. **Test Coverage** - Missing tests, edge cases
5. **Design Patterns** - SOLID principles, architecture

## Review Output Format

For each issue:
- **Severity**: Critical / High / Medium / Low
- **Category**: Security / Performance / Quality / Testing / Design
- **Location**: File path and line number
- **Issue Description**: What's wrong and why
- **Suggested Fix**: Code example
- **Impact**: How this affects the system

## Example Review

### Issue: N+1 Query Problem
- **Severity**: High
- **Category**: Performance
- **Location**: src/user-service.ts:45
- **Issue**: Loop executes database query in each iteration
- **Fix**: Use JOIN or batch query
```

**File:** `.claude/agents/test-engineer.md`

```yaml
---
name: test-engineer
description: Test strategy, coverage analysis, and automated testing
tools: read, write, bash, grep
---

# Test Engineer Agent

You are expert at:
- Writing comprehensive test suites
- Ensuring high code coverage (>80%)
- Testing edge cases and error scenarios
- Performance benchmarking
- Integration testing

## Testing Strategy

1. **Unit Tests** - Individual functions/methods
2. **Integration Tests** - Component interactions
3. **End-to-End Tests** - Complete workflows
4. **Edge Cases** - Boundary conditions
5. **Error Scenarios** - Failure handling

## Test Output Requirements

- Use Jest for JavaScript/TypeScript
- Include setup/teardown for each test
- Mock external dependencies
- Document test purpose
- Include performance assertions when relevant

## Coverage Requirements

- Minimum 80% code coverage
- 100% for critical paths
- Report missing coverage areas
```

**File:** `.claude/agents/documentation-writer.md`

```yaml
---
name: documentation-writer
description: Technical documentation, API docs, and user guides
tools: read, write, grep
---

# Documentation Writer Agent

You create:
- API documentation with examples
- User guides and tutorials
- Architecture documentation
- Changelog entries
- Code comment improvements

## Documentation Standards

1. **Clarity** - Use simple, clear language
2. **Examples** - Include practical code examples
3. **Completeness** - Cover all parameters and returns
4. **Structure** - Use consistent formatting
5. **Accuracy** - Verify against actual code

## Documentation Sections

### For APIs
- Description
- Parameters (with types)
- Returns (with types)
- Throws (possible errors)
- Examples (curl, JavaScript, Python)
- Related endpoints

### For Features
- Overview
- Prerequisites
- Step-by-step instructions
- Expected outcomes
- Troubleshooting
- Related topics
```

#### Example 2: Subagent Delegation in Action

```markdown
# Scenario: Building a Payment Feature

## User Request
"Build a secure payment processing feature that integrates with Stripe"

## Main Agent Flow

1. **Planning Phase**
   - Understands requirements
   - Determines tasks needed
   - Plans architecture

2. **Delegates to Code Reviewer Subagent**
   - Task: "Review the payment processing implementation for security"
   - Context: Auth, API keys, token handling
   - Reviews for: SQL injection, key exposure, HTTPS enforcement

3. **Delegates to Test Engineer Subagent**
   - Task: "Create comprehensive tests for payment flows"
   - Context: Success scenarios, failures, edge cases
   - Creates tests for: Valid payments, declined cards, network failures, webhooks

4. **Delegates to Documentation Writer Subagent**
   - Task: "Document the payment API endpoints"
   - Context: Request/response schemas
   - Produces: API docs with curl examples, error codes

5. **Synthesis**
   - Main agent collects all outputs
   - Integrates findings
   - Returns complete solution to user
```

#### Example 3: Tool Permission Scoping

**Restrictive Setup - Limited to Specific Commands**

```yaml
---
name: secure-reviewer
description: Security-focused code review with minimal permissions
tools: read, grep
---

# Secure Code Reviewer

Reviews code for security vulnerabilities only.

This agent:
- ✅ Reads files to analyze
- ✅ Searches for patterns
- ❌ Cannot execute code
- ❌ Cannot modify files
- ❌ Cannot run tests

This ensures the reviewer doesn't accidentally break anything.
```

**Extended Setup - All Tools for Implementation**

```yaml
---
name: implementation-agent
description: Full implementation capabilities for feature development
tools: read, write, bash, grep, edit, glob
---

# Implementation Agent

Builds features from specifications.

This agent:
- ✅ Reads specifications
- ✅ Writes new code files
- ✅ Runs build commands
- ✅ Searches codebase
- ✅ Edits existing files
- ✅ Finds files matching patterns

Full capabilities for independent feature development.
```

### Subagent Context Management

```mermaid
graph TB
    A["Main Agent Context<br/>50,000 tokens"]
    B["Subagent 1 Context<br/>20,000 tokens"]
    C["Subagent 2 Context<br/>20,000 tokens"]
    D["Subagent 3 Context<br/>20,000 tokens"]

    A -->|Clean slate| B
    A -->|Clean slate| C
    A -->|Clean slate| D

    B -->|Results only| A
    C -->|Results only| A
    D -->|Results only| A

    style A fill:#e1f5ff
    style B fill:#fff9c4
    style C fill:#fff9c4
    style D fill:#fff9c4
```

### When to Use Subagents

| Scenario | Use Subagent | Why |
|----------|--------------|-----|
| 复杂功能、步骤很多 | ✅ Yes | 可拆分职责，避免上下文污染 |
| 快速代码评审 | ❌ No | 额外开销不值得 |
| 并行任务执行 | ✅ Yes | 每个 subagent 都有自己的上下文 |
| 需要专用领域能力 | ✅ Yes | 可定制 system prompt |
| 长时间分析任务 | ✅ Yes | 避免主上下文被耗尽 |
| 单一步骤任务 | ❌ No | 会无谓增加延迟 |

### Agent Teams

Agent Teams 用来协调多个 agent 一起处理相关任务。它不是一次只委派一个 subagent，而是让主 agent 编排一组会协作的 agents，使它们共享中间结果并共同完成目标。这很适合全栈功能开发这类大型任务，比如前端 agent、后端 agent 和测试 agent 并行协作。

---

## Memory

### Overview

Memory 让 Claude 能在多次会话和多轮对话之间保留上下文。它有两种形态：一种是 claude.ai 中自动合成的 memory，另一种是 Claude Code 中基于文件系统的 `CLAUDE.md`。

### Memory Architecture

```mermaid
graph TB
    A["Claude Session"]
    B["User Input"]
    C["Memory System"]
    D["Memory Storage"]

    B -->|User provides info| C
    C -->|Synthesizes every 24h| D
    D -->|Loads automatically| A
    A -->|Uses context| C
```

### Memory Hierarchy in Claude Code（7 Tiers）

Claude Code 会按优先级从高到低加载 7 层 memory：

```mermaid
graph TD
    A["1. Managed Policy<br/>Enterprise admin policies"] --> B["2. Project Memory<br/>./CLAUDE.md"]
    B --> C["3. Project Rules<br/>.claude/rules/*.md"]
    C --> D["4. User Memory<br/>~/.claude/CLAUDE.md"]
    D --> E["5. User Rules<br/>~/.claude/rules/*.md"]
    E --> F["6. Local Memory<br/>.claude/local/CLAUDE.md"]
    F --> G["7. Auto Memory<br/>Automatically captured preferences"]

    style A fill:#fce4ec,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#e1f5fe,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
    style G fill:#fff3e0,stroke:#333,color:#333
```

### Memory Locations Table

| Tier | Location | Scope | Priority | Shared | Best For |
|------|----------|-------|----------|--------|----------|
| 1. Managed Policy | Enterprise admin | Organization | Highest | All org users | 合规、安全策略 |
| 2. Project | `./CLAUDE.md` | Project | High | Team (Git) | 团队规范、架构说明 |
| 3. Project Rules | `.claude/rules/*.md` | Project | High | Team (Git) | 模块化项目约定 |
| 4. User | `~/.claude/CLAUDE.md` | Personal | Medium | Individual | 个人偏好 |
| 5. User Rules | `~/.claude/rules/*.md` | Personal | Medium | Individual | 模块化个人规则 |
| 6. Local | `.claude/local/CLAUDE.md` | Local | Low | Not shared | 机器特定设置 |
| 7. Auto Memory | Automatic | Session | Lowest | Individual | 学到的偏好与模式 |

### Auto Memory

Auto Memory 会自动捕获会话中观察到的用户偏好与模式。Claude 会从你的交互中学习并记住：

- 编码风格偏好
- 你经常做出的修正
- 常用框架与工具选择
- 沟通风格偏好

Auto Memory 在后台工作，不需要手动配置。

### Memory Update Lifecycle

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Editor as File System
    participant Memory as CLAUDE.md

    User->>Claude: "Remember: use async/await"
    Claude->>User: "Which memory file?"
    User->>Claude: "Project memory"
    Claude->>Editor: Open ~/.claude/settings.json
    Claude->>Memory: Write to ./CLAUDE.md
    Memory-->>Claude: File saved
    Claude->>Claude: Load updated memory
    Claude-->>User: "Memory saved!"
```

### Practical Examples

#### Example 1: Project Memory Structure

**File:** `./CLAUDE.md`

```markdown
# Project Configuration

## Project Overview
- **Name**: E-commerce Platform
- **Tech Stack**: Node.js, PostgreSQL, React 18, Docker
- **Team Size**: 5 developers
- **Deadline**: Q4 2025

## Architecture
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## Development Standards

### Code Style
- Use Prettier for formatting
- Use ESLint with airbnb config
- Maximum line length: 100 characters
- Use 2-space indentation

### Naming Conventions
- **Files**: kebab-case (user-controller.js)
- **Classes**: PascalCase (UserService)
- **Functions/Variables**: camelCase (getUserById)
- **Constants**: UPPER_SNAKE_CASE (API_BASE_URL)
- **Database Tables**: snake_case (user_accounts)

### Git Workflow
- Branch names: `feature/description` or `fix/description`
- Commit messages: Follow conventional commits
- PR required before merge
- All CI/CD checks must pass
- Minimum 1 approval required

### Testing Requirements
- Minimum 80% code coverage
- All critical paths must have tests
- Use Jest for unit tests
- Use Cypress for E2E tests
- Test filenames: `*.test.ts` or `*.spec.ts`

### API Standards
- RESTful endpoints only
- JSON request/response
- Use HTTP status codes correctly
- Version API endpoints: `/api/v1/`
- Document all endpoints with examples

### Database
- Use migrations for schema changes
- Never hardcode credentials
- Use connection pooling
- Enable query logging in development
- Regular backups required

### Deployment
- Docker-based deployment
- Kubernetes orchestration
- Blue-green deployment strategy
- Automatic rollback on failure
- Database migrations run before deploy

## Common Commands

| Command | Purpose |
|---------|---------|
| `npm run dev` | Start development server |
| `npm test` | Run test suite |
| `npm run lint` | Check code style |
| `npm run build` | Build for production |
| `npm run migrate` | Run database migrations |

## Team Contacts
- Tech Lead: Sarah Chen (@sarah.chen)
- Product Manager: Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## Known Issues & Workarounds
- PostgreSQL connection pooling limited to 20 during peak hours
- Workaround: Implement query queuing
- Safari 14 compatibility issues with async generators
- Workaround: Use Babel transpiler

## Related Projects
- Analytics Dashboard: `/projects/analytics`
- Mobile App: `/projects/mobile`
- Admin Panel: `/projects/admin`
```

#### Example 2: Directory-Specific Memory

**File:** `./src/api/CLAUDE.md`

~~~~markdown
# API Module Standards

This file overrides root CLAUDE.md for everything in /src/api/

## API-Specific Standards

### Request Validation
- Use Zod for schema validation
- Always validate input
- Return 400 with validation errors
- Include field-level error details

### Authentication
- All endpoints require JWT token
- Token in Authorization header
- Token expires after 24 hours
- Implement refresh token mechanism

### Response Format

All responses must follow this structure:

```json
{
  "success": true,
  "data": { /* actual data */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

### Error responses:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "User message",
    "details": { /* field errors */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### Pagination
- Use cursor-based pagination (not offset)
- Include `hasMore` boolean
- Limit max page size to 100
- Default page size: 20

### Rate Limiting
- 1000 requests per hour for authenticated users
- 100 requests per hour for public endpoints
- Return 429 when exceeded
- Include retry-after header

### Caching
- Use Redis for session caching
- Cache duration: 5 minutes default
- Invalidate on write operations
- Tag cache keys with resource type
~~~~

#### Example 3: Personal Memory

**File:** `~/.claude/CLAUDE.md`

~~~~markdown
# My Development Preferences

## About Me
- **Experience Level**: 8 years full-stack development
- **Preferred Languages**: TypeScript, Python
- **Communication Style**: Direct, with examples
- **Learning Style**: Visual diagrams with code

## Code Preferences

### Error Handling
I prefer explicit error handling with try-catch blocks and meaningful error messages.
Avoid generic errors. Always log errors for debugging.

### Comments
Use comments for WHY, not WHAT. Code should be self-documenting.
Comments should explain business logic or non-obvious decisions.

### Testing
I prefer TDD (test-driven development).
Write tests first, then implementation.
Focus on behavior, not implementation details.

### Architecture
I prefer modular, loosely-coupled design.
Use dependency injection for testability.
Separate concerns (Controllers, Services, Repositories).

## Debugging Preferences
- Use console.log with prefix: `[DEBUG]`
- Include context: function name, relevant variables
- Use stack traces when available
- Always include timestamps in logs

## Communication
- Explain complex concepts with diagrams
- Show concrete examples before explaining theory
- Include before/after code snippets
- Summarize key points at the end

## Project Organization
I organize my projects as:
```
project/
  ├── src/
  │   ├── api/
  │   ├── services/
  │   ├── models/
  │   └── utils/
  ├── tests/
  ├── docs/
  └── docker/
```

## Tooling
- **IDE**: VS Code with vim keybindings
- **Terminal**: Zsh with Oh-My-Zsh
- **Format**: Prettier (100 char line length)
- **Linter**: ESLint with airbnb config
- **Test Framework**: Jest with React Testing Library
~~~~

#### Example 4: Memory Update During Session

**Session Interaction:**

```markdown
User: Remember that I prefer using React hooks instead of class components
     for all new components.

Claude: I'm adding that to your memory. Which memory file should this go in?
        1. Project memory (./CLAUDE.md)
        2. Personal memory (~/.claude/CLAUDE.md)

User: Project memory

Claude: ✅ Memory saved!

Added to ./CLAUDE.md:
---

### Component Development
- Use functional components with React Hooks
- Prefer hooks over class components
- Custom hooks for reusable logic
- Use useCallback for event handlers
- Use useMemo for expensive computations
```

### Memory in Claude Web/Desktop

#### Memory Synthesis Timeline

```mermaid
graph LR
    A["Day 1: User<br/>Conversations"] -->|24 hours| B["Day 2: Memory<br/>Synthesis"]
    B -->|Automatic| C["Memory Updated<br/>Summarized"]
    C -->|Loaded in| D["Day 2-N:<br/>New Conversations"]
    D -->|Add to| E["Memory"]
    E -->|24 hours later| F["Memory Refreshed"]
```

**Example Memory Summary:**

```markdown
## Claude's Memory of User

### Professional Background
- Senior full-stack developer with 8 years experience
- Focus on TypeScript/Node.js backends and React frontends
- Active open source contributor
- Interested in AI and machine learning

### Project Context
- Currently building e-commerce platform
- Tech stack: Node.js, PostgreSQL, React 18, Docker
- Working with team of 5 developers
- Using CI/CD and blue-green deployments

### Communication Preferences
- Prefers direct, concise explanations
- Likes visual diagrams and examples
- Appreciates code snippets
- Explains business logic in comments

### Current Goals
- Improve API performance
- Increase test coverage to 90%
- Implement caching strategy
- Document architecture
```

### Memory Features Comparison

| Feature | Claude Web/Desktop | Claude Code (CLAUDE.md) |
|---------|-------------------|------------------------|
| Auto-synthesis | ✅ Every 24h | ❌ 手动 |
| Cross-project | ✅ Shared | ❌ 仅项目内 |
| Team access | ✅ Shared projects | ✅ 可用 Git 跟踪 |
| Searchable | ✅ Built-in | ✅ 通过 `/memory` |
| Editable | ✅ In-chat | ✅ 直接编辑文件 |
| Import/Export | ✅ Yes | ✅ Copy/paste |
| Persistent | ✅ 24h+ | ✅ 长期有效 |

---

## MCP Protocol

### Overview

MCP（Model Context Protocol）是一种标准化方式，让 Claude 可以访问外部工具、API 和实时数据源。和 Memory 不同，MCP 提供的是对会变化数据的实时访问能力。

### MCP Architecture

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
```

### MCP Ecosystem

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
```

### MCP Setup Process

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

### Available MCP Servers Table

| MCP Server | Purpose | Common Tools | Auth | Real-time |
|------------|---------|--------------|------|-----------|
| **Filesystem** | 文件操作 | read、write、delete | OS permissions | ✅ Yes |
| **GitHub** | 仓库管理 | list_prs、create_issue、push | OAuth | ✅ Yes |
| **Slack** | 团队沟通 | send_message、list_channels | Token | ✅ Yes |
| **Database** | SQL 查询 | query、insert、update | Credentials | ✅ Yes |
| **Google Docs** | 文档访问 | read、write、share | OAuth | ✅ Yes |
| **Asana** | 项目管理 | create_task、update_status | API Key | ✅ Yes |
| **Stripe** | 支付数据 | list_charges、create_invoice | API Key | ✅ Yes |
| **Memory** | 持久 memory | store、retrieve、delete | Local | ❌ No |

### Practical Examples

#### Example 1: GitHub MCP Configuration

**File:** `.mcp.json`（项目级）或 `~/.claude.json`（用户级）

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

~~~~markdown
# GitHub MCP Tools

## Pull Request Management
- `list_prs` - List all PRs in repository
- `get_pr` - Get PR details including diff
- `create_pr` - Create new PR
- `update_pr` - Update PR description/title
- `merge_pr` - Merge PR to main branch
- `review_pr` - Add review comments

Example request:
```
/mcp__github__get_pr 456

# Returns:
Title: Add dark mode support
Author: @alice
Description: Implements dark theme using CSS variables
Status: OPEN
Reviewers: @bob, @charlie
```

## Issue Management
- `list_issues` - List all issues
- `get_issue` - Get issue details
- `create_issue` - Create new issue
- `close_issue` - Close issue
- `add_comment` - Add comment to issue

## Repository Information
- `get_repo_info` - Repository details
- `list_files` - File tree structure
- `get_file_content` - Read file contents
- `search_code` - Search across codebase

## Commit Operations
- `list_commits` - Commit history
- `get_commit` - Specific commit details
- `create_commit` - Create new commit
~~~~

#### Example 2: Database MCP Setup

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
User: Fetch all users with more than 10 orders

Claude: I'll query your database to find that information.

# Using MCP database tool:
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# Results:
- Alice: 15 orders
- Bob: 12 orders
- Charlie: 11 orders
```

#### Example 3: Multi-MCP Workflow

**Scenario: Daily Report Generation**

```markdown
# Daily Report Workflow using Multiple MCPs

## Setup
1. GitHub MCP - fetch PR metrics
2. Database MCP - query sales data
3. Slack MCP - post report
4. Filesystem MCP - save report

## Workflow

### Step 1: Fetch GitHub Data
/mcp__github__list_prs completed:true last:7days

Output:
- Total PRs: 42
- Average merge time: 2.3 hours
- Review turnaround: 1.1 hours

### Step 2: Query Database
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

Output:
- Sales: 247
- Revenue: $12,450

### Step 3: Generate Report
Combine data into HTML report

### Step 4: Save to Filesystem
Write report.html to /reports/

### Step 5: Post to Slack
Send summary to #daily-reports channel

Final Output:
✅ Report generated and posted
📊 47 PRs merged this week
💰 $12,450 in daily sales
```

#### Example 4: Filesystem MCP Operations

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

### MCP vs Memory: Decision Matrix

```mermaid
graph TD
    A["Need external data?"]
    A -->|No| B["Use Memory"]
    A -->|Yes| C["Does it change frequently?"]
    C -->|No/Rarely| B
    C -->|Yes/Often| D["Use MCP"]

    B -->|Stores| E["Preferences<br/>Context<br/>History"]
    D -->|Accesses| F["Live APIs<br/>Databases<br/>Services"]

    style B fill:#e1f5ff
    style D fill:#fff9c4
```

### Request/Response Pattern

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

    Note over MCP,DB: Real-time access<br/>No caching
```

---

## Agent Skills

### 概述

Agent Skills 是可复用、由模型主动调用的能力包，通常以文件夹形式组织，里面包含说明、脚本和资源。Claude 会自动检测并使用相关的 Skills。

### Skill 架构

```mermaid
graph TB
    A["Skill Directory"]
    B["SKILL.md"]
    C["YAML Metadata"]
    D["Instructions"]
    E["Scripts"]
    F["Templates"]

    A --> B
    B --> C
    B --> D
    E --> A
    F --> A
```

### Skill 加载流程

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude
    participant System as System
    participant Skill as Skill

    User->>Claude: "Create Excel report"
    Claude->>System: Scan available skills
    System->>System: Load skill metadata
    Claude->>Claude: Match user request to skills
    Claude->>Skill: Load xlsx skill SKILL.md
    Skill-->>Claude: Return instructions + tools
    Claude->>Claude: Execute skill
    Claude->>User: Generate Excel file
```

### Skill 类型与位置表

| Type | Location | Scope | Shared | Sync | Best For |
|------|----------|-------|--------|------|----------|
| Pre-built | Built-in | 全局 | 所有用户 | 自动 | 文档创建 |
| Personal | `~/.claude/skills/` | 个人 | 否 | 手动 | 个人自动化 |
| Project | `.claude/skills/` | 团队 | 是 | Git | 团队标准 |
| Plugin | Via plugin install | 视情况而定 | 视情况而定 | 自动 | 集成功能 |

### 预构建 Skills

```mermaid
graph TB
    A["Pre-built Skills"]
    B["PowerPoint (pptx)"]
    C["Excel (xlsx)"]
    D["Word (docx)"]
    E["PDF"]

    A --> B
    A --> C
    A --> D
    A --> E

    B --> B1["Create presentations"]
    B --> B2["Edit slides"]
    C --> C1["Create spreadsheets"]
    C --> C2["Analyze data"]
    D --> D1["Create documents"]
    D --> D2["Format text"]
    E --> E1["Generate PDFs"]
    E --> E2["Fill forms"]
```

### 内置 Skills

Claude Code 现在开箱即带 5 个可直接使用的内置 skill：

| Skill | Command | Purpose |
|-------|---------|---------|
| **Simplify** | `/simplify` | 简化复杂代码或说明 |
| **Batch** | `/batch` | 跨多个文件或条目执行批量操作 |
| **Debug** | `/debug` | 以根因分析方式系统性排查问题 |
| **Loop** | `/loop` | 按定时器安排循环任务 |
| **Claude API** | `/claude-api` | 直接与 Anthropic API 交互 |

这些内置 skills 始终可用，不需要额外安装或配置。

### 实用示例

#### 示例 1：自定义代码审查 Skill

**目录结构：**

```
~/.claude/skills/code-review/
├── SKILL.md
├── templates/
│   ├── review-checklist.md
│   └── finding-template.md
└── scripts/
    ├── analyze-metrics.py
    └── compare-complexity.py
```

**文件：** `~/.claude/skills/code-review/SKILL.md`

```yaml
---
name: Code Review Specialist
description: Comprehensive code review with security, performance, and quality analysis
version: "1.0.0"
tags:
  - code-review
  - quality
  - security
when_to_use: 当用户要求审查代码、分析代码质量或评估 pull request 时使用
effort: high
shell: bash
---

# Code Review Skill

这个 skill 提供了全面的代码审查能力，重点关注：

1. **Security Analysis**
   - 身份认证 / 授权问题
   - 数据暴露风险
   - 注入类漏洞
   - 加密薄弱点
   - 敏感数据日志记录

2. **Performance Review**
   - 算法效率（Big O 分析）
   - 内存优化
   - 数据库查询优化
   - 缓存机会
   - 并发问题

3. **Code Quality**
   - SOLID 原则
   - 设计模式
   - 命名规范
   - 文档质量
   - 测试覆盖率

4. **Maintainability**
   - 代码可读性
   - 函数大小（应小于 50 行）
   - 圈复杂度
   - 依赖管理
   - 类型安全

## Review Template

对每一段被审查的代码，请提供：

### Summary
- 整体质量评估（1-5）
- 关键发现数量
- 推荐优先关注的领域

### Critical Issues (if any)
- **Issue**: 清晰描述问题
- **Location**: 文件和行号
- **Impact**: 为什么这很重要
- **Severity**: Critical/High/Medium
- **Fix**: 代码示例

### Findings by Category

#### Security (if issues found)
列出安全漏洞，并给出示例

#### Performance (if issues found)
列出性能问题，并附带复杂度分析

#### Quality (if issues found)
列出代码质量问题，并给出重构建议

#### Maintainability (if issues found)
列出可维护性问题，并给出改进方式
```

## Python Script: analyze-metrics.py

```python
#!/usr/bin/env python3
import re
import sys

def analyze_code_metrics(code):
    """分析代码的常见指标。"""

    # 统计函数数量
    functions = len(re.findall(r'^def\s+\w+', code, re.MULTILINE))

    # 统计类数量
    classes = len(re.findall(r'^class\s+\w+', code, re.MULTILINE))

    # 平均行长度
    lines = code.split('\n')
    avg_length = sum(len(l) for l in lines) / len(lines) if lines else 0

    # 估算复杂度
    complexity = len(re.findall(r'\b(if|elif|else|for|while|and|or)\b', code))

    return {
        'functions': functions,
        'classes': classes,
        'avg_line_length': avg_length,
        'complexity_score': complexity
    }

if __name__ == '__main__':
    with open(sys.argv[1], 'r') as f:
        code = f.read()
    metrics = analyze_code_metrics(code)
    for key, value in metrics.items():
        print(f"{key}: {value:.2f}")
```

## Python Script: compare-complexity.py

```python
#!/usr/bin/env python3
"""
比较代码变更前后的圈复杂度。
帮助判断重构是否真的让代码结构更简单。
"""

import re
import sys
from typing import Dict, Tuple

class ComplexityAnalyzer:
    """分析代码复杂度指标。"""

    def __init__(self, code: str):
        self.code = code
        self.lines = code.split('\n')

    def calculate_cyclomatic_complexity(self) -> int:
        """
        使用 McCabe 方法计算圈复杂度。
        统计决策点：if、elif、else、for、while、except、and、or
        """
        complexity = 1  # 基础复杂度

        # 统计决策点
        decision_patterns = [
            r'\bif\b',
            r'\belif\b',
            r'\bfor\b',
            r'\bwhile\b',
            r'\bexcept\b',
            r'\band\b(?!$)',
            r'\bor\b(?!$)'
        ]

        for pattern in decision_patterns:
            matches = re.findall(pattern, self.code)
            complexity += len(matches)

        return complexity

    def calculate_cognitive_complexity(self) -> int:
        """
        计算认知复杂度，即代码理解起来有多难。
        基于嵌套深度和控制流进行估算。
        """
        cognitive = 0
        nesting_depth = 0

        for line in self.lines:
            # 跟踪嵌套深度
            if re.search(r'^\s*(if|for|while|def|class|try)\b', line):
                nesting_depth += 1
                cognitive += nesting_depth
            elif re.search(r'^\s*(elif|else|except|finally)\b', line):
                cognitive += nesting_depth

            # 取消缩进时降低嵌套层级
            if line and not line[0].isspace():
                nesting_depth = 0

        return cognitive

    def calculate_maintainability_index(self) -> float:
        """
        可维护性指数范围是 0-100。
        > 85: Excellent
        > 65: Good
        > 50: Fair
        < 50: Poor
        """
        lines = len(self.lines)
        cyclomatic = self.calculate_cyclomatic_complexity()
        cognitive = self.calculate_cognitive_complexity()

        # 简化版 MI 计算
        mi = 171 - 5.2 * (cyclomatic / lines) - 0.23 * (cognitive) - 16.2 * (lines / 1000)

        return max(0, min(100, mi))

    def get_complexity_report(self) -> Dict:
        """生成完整的复杂度报告。"""
        return {
            'cyclomatic_complexity': self.calculate_cyclomatic_complexity(),
            'cognitive_complexity': self.calculate_cognitive_complexity(),
            'maintainability_index': round(self.calculate_maintainability_index(), 2),
            'lines_of_code': len(self.lines),
            'avg_line_length': round(sum(len(l) for l in self.lines) / len(self.lines), 2) if self.lines else 0
        }


def compare_files(before_file: str, after_file: str) -> None:
    """比较两个代码版本之间的复杂度指标。"""

    with open(before_file, 'r') as f:
        before_code = f.read()

    with open(after_file, 'r') as f:
        after_code = f.read()

    before_analyzer = ComplexityAnalyzer(before_code)
    after_analyzer = ComplexityAnalyzer(after_code)

    before_metrics = before_analyzer.get_complexity_report()
    after_metrics = after_analyzer.get_complexity_report()

    print("=" * 60)
    print("CODE COMPLEXITY COMPARISON")
    print("=" * 60)

    print("\nBEFORE:")
    print(f"  Cyclomatic Complexity:    {before_metrics['cyclomatic_complexity']}")
    print(f"  Cognitive Complexity:     {before_metrics['cognitive_complexity']}")
    print(f"  Maintainability Index:    {before_metrics['maintainability_index']}")
    print(f"  Lines of Code:            {before_metrics['lines_of_code']}")
    print(f"  Avg Line Length:          {before_metrics['avg_line_length']}")

    print("\nAFTER:")
    print(f"  Cyclomatic Complexity:    {after_metrics['cyclomatic_complexity']}")
    print(f"  Cognitive Complexity:     {after_metrics['cognitive_complexity']}")
    print(f"  Maintainability Index:    {after_metrics['maintainability_index']}")
    print(f"  Lines of Code:            {after_metrics['lines_of_code']}")
    print(f"  Avg Line Length:          {after_metrics['avg_line_length']}")

    print("\nCHANGES:")
    cyclomatic_change = after_metrics['cyclomatic_complexity'] - before_metrics['cyclomatic_complexity']
    cognitive_change = after_metrics['cognitive_complexity'] - before_metrics['cognitive_complexity']
    mi_change = after_metrics['maintainability_index'] - before_metrics['maintainability_index']
    loc_change = after_metrics['lines_of_code'] - before_metrics['lines_of_code']

    print(f"  Cyclomatic Complexity:    {cyclomatic_change:+d}")
    print(f"  Cognitive Complexity:     {cognitive_change:+d}")
    print(f"  Maintainability Index:    {mi_change:+.2f}")
    print(f"  Lines of Code:            {loc_change:+d}")

    print("\nASSESSMENT:")
    if mi_change > 0:
        print("  ✅ 代码的可维护性更高了")
    elif mi_change < 0:
        print("  ⚠️  代码的可维护性降低了")
    else:
        print("  ➡️  可维护性没有变化")

    if cyclomatic_change < 0:
        print("  ✅ 复杂度下降了")
    elif cyclomatic_change > 0:
        print("  ⚠️  复杂度上升了")
    else:
        print("  ➡️  复杂度没有变化")

    print("=" * 60)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python compare-complexity.py <before_file> <after_file>")
        sys.exit(1)

    compare_files(sys.argv[1], sys.argv[2])
```

## Template: review-checklist.md

```markdown
# Code Review Checklist

## Security Checklist
- [ ] 没有硬编码凭据或密钥
- [ ] 对所有用户输入做了校验
- [ ] 防止 SQL 注入（参数化查询）
- [ ] 对变更状态的操作有 CSRF 防护
- [ ] 通过正确转义防止 XSS
- [ ] 受保护端点具备认证检查
- [ ] 资源具备授权检查
- [ ] 使用安全的密码哈希（bcrypt、argon2）
- [ ] 日志中没有敏感数据
- [ ] 强制使用 HTTPS

## Performance Checklist
- [ ] 没有 N+1 查询
- [ ] 合理使用索引
- [ ] 在有收益的地方实现缓存
- [ ] 主线程上没有阻塞操作
- [ ] 正确使用 Async/await
- [ ] 大数据集已分页
- [ ] 数据库连接已池化
- [ ] 正则表达式已优化
- [ ] 没有不必要的对象创建
- [ ] 已防止内存泄漏

## Quality Checklist
- [ ] 函数长度 < 50 行
- [ ] 变量命名清晰
- [ ] 没有重复代码
- [ ] 错误处理完善
- [ ] 注释解释 WHY，而不是 WHAT
- [ ] 生产环境中没有 console.log
- [ ] 有类型检查（TypeScript/JSDoc）
- [ ] 遵循 SOLID 原则
- [ ] 正确应用设计模式
- [ ] 代码具备自解释性

## Testing Checklist
- [ ] 已编写单元测试
- [ ] 覆盖了边界情况
- [ ] 测试了错误场景
- [ ] 存在集成测试
- [ ] 覆盖率 > 80%
- [ ] 没有脆弱测试
- [ ] 对外部依赖做了 mock
- [ ] 测试名称清晰
```

## Template: finding-template.md

~~~~markdown
# Code Review Finding Template

在记录代码审查中发现的每个问题时，请使用这个模板。

---

## Issue: [TITLE]

### Severity
- [ ] Critical（阻塞部署）
- [ ] High（应在合并前修复）
- [ ] Medium（应尽快修复）
- [ ] Low（有更好，但不紧急）

### Category
- [ ] Security
- [ ] Performance
- [ ] Code Quality
- [ ] Maintainability
- [ ] Testing
- [ ] Design Pattern
- [ ] Documentation

### Location
**File:** `src/components/UserCard.tsx`

**Lines:** 45-52

**Function/Method:** `renderUserDetails()`

### Issue Description

**What:** 描述问题是什么。

**Why it matters:** 解释影响，以及为什么需要修复。

**Current behavior:** 展示有问题的代码或行为。

**Expected behavior:** 说明正确情况下应该发生什么。

### Code Example

#### Current (Problematic)

```typescript
// 展示 N+1 查询问题
const users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // 每个用户都查一次！
  renderUserPosts(posts);
});
```

#### Suggested Fix

```typescript
// 使用 JOIN 查询进行优化
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### Impact Analysis

| Aspect | Impact | Severity |
|--------|--------|----------|
| Performance | 20 个用户会触发 100+ 次查询 | High |
| User Experience | 页面加载很慢 | High |
| Scalability | 规模上来后会崩 | Critical |
| Maintainability | 很难排查 | Medium |

### Related Issues

- `AdminUserList.tsx` 第 120 行也有类似问题
- 相关 PR：#456
- 相关 issue：#789

### Additional Resources

- [N+1 Query Problem](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Database Join Documentation](https://docs.example.com/joins)

### Reviewer Notes

- 这是这个代码库里一个常见模式
- 可以考虑把它加入代码风格指南
- 也许值得抽成一个辅助函数

### Author Response (for feedback)

*由代码作者填写：*

- [ ] 修复已在提交中实现：`abc123`
- [ ] 修复状态：Complete / In Progress / Needs Discussion
- [ ] 问题或顾虑：（描述）

---

## Finding Statistics (for Reviewer)

当审查多个问题时，请跟踪：

- **Total Issues Found:** X
- **Critical:** X
- **High:** X
- **Medium:** X
- **Low:** X

**Recommendation:** ✅ Approve / ⚠️ Request Changes / 🔄 Needs Discussion

**Overall Code Quality:** 1-5 stars
~~~~

## Usage Example

~~~~markdown
User: Review this React component code

Claude: 我会使用我的 Code Review Skill 对这段代码进行一次全面审查。

[Loads SKILL.md]
[Analyzes code against checklist]
[Runs Python metrics script]
[Applies templates]

## Code Review Results

### Summary
Quality Score: 3.5/5
Key Findings: 7 items
Priority Areas: 性能优化、错误处理

### Critical Issues: 1

**Issue**: N+1 Query Problem
**Location**: UserComponent.tsx, lines 45-52
**Impact**: 对一个包含 20 个用户的列表会触发 100+ 次数据库查询
**Severity**: High
**Fix**:
```javascript
// Before: N+1 查询
const users = fetchUsers();
users.forEach(user => fetchUserPosts(user.id)); // 20+ 次查询

// After: 使用 JOIN 的单次查询
const users = fetchUsersWithPosts(); // 1 次查询
```

### Performance Findings
- 大列表缺少分页
- 建议：对列表项使用 React.memo()
- 数据库查询：可以通过索引优化

### Quality Findings
- 第 20 行的函数有 127 行（上限：50）
- 缺少错误边界
- Props 应该添加 TypeScript 类型
~~~~

#### 示例 2：品牌语气 Skill

**目录结构：**

```
.claude/skills/brand-voice/
├── SKILL.md
├── brand-guidelines.md
├── tone-examples.md
└── templates/
    ├── email-template.txt
    ├── social-post-template.txt
    └── blog-post-template.md
```

**文件：** `.claude/skills/brand-voice/SKILL.md`

```yaml
---
name: Brand Voice Consistency
description: Ensure all communication matches brand voice and tone guidelines
tags:
  - brand
  - writing
  - consistency
when_to_use: 在创建营销文案、客户沟通内容或面向公众的内容时使用
---

# Brand Voice Skill

## Overview
这个 skill 用来确保所有沟通内容都保持一致的品牌语气、语调和信息表达。

## Brand Identity

### Mission
帮助团队用 AI 自动化其开发工作流

### Values
- **Simplicity**：把复杂的事情变简单
- **Reliability**：稳定可靠地执行
- **Empowerment**：赋能人的创造力

### Tone of Voice
- **Friendly but professional** - 亲切，但不随便
- **Clear and concise** - 避免术语堆砌，用简单方式解释技术概念
- **Confident** - 我们知道自己在做什么
- **Empathetic** - 理解用户需求和痛点

## Writing Guidelines

### Do's ✅
- 在面向读者时使用 “you”
- 使用主动语态：“Claude generates reports”，而不是 “Reports are generated by Claude”
- 开头先讲价值主张
- 使用具体示例
- 句子尽量控制在 20 个词以内
- 用列表提高清晰度
- 包含清晰的行动号召

### Don'ts ❌
- 不要使用企业黑话
- 不要居高临下，也不要过度简化
- 不要使用 “we believe” 或 “we think”
- 不要使用全大写，除非是为了强调
- 不要写成大段文字墙
- 不要假设读者已有技术背景

## Vocabulary

### ✅ Preferred Terms
- Claude（不要写成 “the Claude AI”）
- Code generation（不要写成 “auto-coding”）
- Agent（不要写成 “bot”）
- Streamline（不要写成 “revolutionize”）
- Integrate（不要写成 “synergize”）

### ❌ Avoid Terms
- "Cutting-edge"（过度使用）
- "Game-changer"（太空泛）
- "Leverage"（企业腔）
- "Utilize"（用 "use" 即可）
- "Paradigm shift"（含义不清）
```

## Examples

### ✅ Good Example
"Claude automates your code review process. Instead of manually checking each PR, Claude reviews security, performance, and quality—saving your team hours every week."

Why it works: 价值清晰、收益具体、以行动为导向

### ❌ Bad Example
"Claude leverages cutting-edge AI to provide comprehensive software development solutions."

Why it doesn't work: 太空泛、企业黑话重、没有具体价值

## Template: Email

```
Subject: [清晰、以收益为导向的标题]

Hi [Name],

[Opening: 这件事对他们的价值是什么]

[Body: 它如何工作 / 他们会得到什么]

[Specific example or benefit]

[Call to action: 清晰的下一步]

Best regards,
[Name]
```

## Template: Social Media

```
[Hook: 第一行抓住注意力]
[2-3 lines: 价值点或有趣事实]
[Call to action: 链接、提问或互动]
[Emoji: 最多 1-2 个，用于增强视觉吸引力]
```

## File: tone-examples.md
```
Exciting announcement:
"每周节省 8 小时代码审查时间。Claude 会自动审查你的 PR。"

Empathetic support:
"我们知道部署会让人紧张。Claude 会处理测试，让你不用为此担心。"

Confident product feature:
"Claude 不只是给出代码建议。它还理解你的架构，并保持整体一致性。"

Educational blog post:
"让我们一起看看 agents 是如何改进代码审查工作流的。以下是我们的经验总结……"
```

#### 示例 3：文档生成 Skill

**文件：** `.claude/skills/doc-generator/SKILL.md`

~~~~yaml
---
name: API Documentation Generator
description: Generate comprehensive, accurate API documentation from source code
version: "1.0.0"
tags:
  - documentation
  - api
  - automation
when_to_use: 在创建或更新 API 文档时使用
---

# API Documentation Generator Skill

## Generates

- OpenAPI/Swagger 规范
- API endpoint 文档
- SDK 使用示例
- 集成指南
- 错误码参考
- 鉴权说明

## Documentation Structure

### For Each Endpoint

```markdown
## GET /api/v1/users/:id

### Description
简要说明这个 endpoint 的作用

### Parameters

| Name | Type | Required | Description |
|------|------|----------|-------------|
| id | string | Yes | 用户 ID |

### Response

**200 Success**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 Not Found**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "用户不存在"
}
```

### Examples

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```

## Python Script: generate-docs.py

```python
#!/usr/bin/env python3
import ast
import json
from typing import Dict, List

class APIDocExtractor(ast.NodeVisitor):
    """从 Python 源代码中提取 API 文档。"""

    def __init__(self):
        self.endpoints = []

    def visit_FunctionDef(self, node):
        """提取函数文档。"""
        if node.name.startswith('get_') or node.name.startswith('post_'):
            doc = ast.get_docstring(node)
            endpoint = {
                'name': node.name,
                'docstring': doc,
                'params': [arg.arg for arg in node.args.args],
                'returns': self._extract_return_type(node)
            }
            self.endpoints.append(endpoint)
        self.generic_visit(node)

    def _extract_return_type(self, node):
        """从函数注解中提取返回类型。"""
        if node.returns:
            return ast.unparse(node.returns)
        return "Any"

def generate_markdown_docs(endpoints: List[Dict]) -> str:
    """根据 endpoints 生成 markdown 文档。"""
    docs = "# API Documentation\n\n"

    for endpoint in endpoints:
        docs += f"## {endpoint['name']}\n\n"
        docs += f"{endpoint['docstring']}\n\n"
        docs += f"**Parameters**: {', '.join(endpoint['params'])}\n\n"
        docs += f"**Returns**: {endpoint['returns']}\n\n"
        docs += "---\n\n"

    return docs

if __name__ == '__main__':
    import sys
    with open(sys.argv[1], 'r') as f:
        tree = ast.parse(f.read())

    extractor = APIDocExtractor()
    extractor.visit(tree)

    markdown = generate_markdown_docs(extractor.endpoints)
    print(markdown)
~~~~

### Skill 发现与调用

```mermaid
graph TD
    A["User Request"] --> B["Claude Analyzes"]
    B -->|Scans| C["Available Skills"]
    C -->|Metadata check| D["Skill Description Match?"]
    D -->|Yes| E["Load SKILL.md"]
    D -->|No| F["Try next skill"]
    F -->|More skills?| D
    F -->|No more| G["Use general knowledge"]
    E --> H["Extract Instructions"]
    H --> I["Execute Skill"]
    I --> J["Return Results"]
```

### Skill 与其他特性的关系

```mermaid
graph TB
    A["Extending Claude"]
    B["Slash Commands"]
    C["Subagents"]
    D["Memory"]
    E["MCP"]
    F["Skills"]

    A --> B
    A --> C
    A --> D
    A --> E
    A --> F

    B -->|User-invoked| G["Quick shortcuts"]
    C -->|Auto-delegated| H["Isolated contexts"]
    D -->|Persistent| I["Cross-session context"]
    E -->|Real-time| J["External data access"]
    F -->|Auto-invoked| K["Autonomous execution"]
```

---

## Claude Code Plugins

### 概述

Claude Code Plugins 是一组打包在一起的自定义能力集合，包含 slash commands、subagents、MCP servers 和 hooks，可以通过一条命令完成安装。它们是最高层级的扩展机制，能把多个特性整合成一致、可共享的能力包。

### 架构

```mermaid
graph TB
    A["Plugin"]
    B["Slash Commands"]
    C["Subagents"]
    D["MCP Servers"]
    E["Hooks"]
    F["Configuration"]

    A -->|bundles| B
    A -->|bundles| C
    A -->|bundles| D
    A -->|bundles| E
    A -->|bundles| F
```

### Plugin 加载流程

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Plugin as Plugin Marketplace
    participant Install as Installation
    participant SlashCmds as Slash Commands
    participant Subagents
    participant MCPServers as MCP Servers
    participant Hooks
    participant Tools as Configured Tools

    User->>Claude: /plugin install pr-review
    Claude->>Plugin: Download plugin manifest
    Plugin-->>Claude: Return plugin definition
    Claude->>Install: Extract components
    Install->>SlashCmds: Configure
    Install->>Subagents: Configure
    Install->>MCPServers: Configure
    Install->>Hooks: Configure
    SlashCmds-->>Tools: Ready to use
    Subagents-->>Tools: Ready to use
    MCPServers-->>Tools: Ready to use
    Hooks-->>Tools: Ready to use
    Tools-->>Claude: Plugin installed ✅
```

### Plugin 类型与分发方式

| Type | Scope | Shared | Authority | Examples |
|------|-------|--------|-----------|----------|
| Official | 全局 | 所有用户 | Anthropic | PR Review、Security Guidance |
| Community | 公开 | 所有用户 | 社区 | DevOps、Data Science |
| Organization | 内部 | 团队成员 | 公司 | 内部标准、内部工具 |
| Personal | 个人 | 单个用户 | 开发者本人 | 自定义工作流 |

### Plugin 定义结构

```yaml
---
name: plugin-name
version: "1.0.0"
description: "这个插件的作用"
author: "Your Name"
license: MIT

# Plugin 元数据
tags:
  - category
  - use-case

# Requirements
requires:
  - claude-code: ">=1.0.0"

# 打包的组件
components:
  - type: commands
    path: commands/
  - type: agents
    path: agents/
  - type: mcp
    path: mcp/
  - type: hooks
    path: hooks/

# 配置
config:
  auto_load: true
  enabled_by_default: true
---
```

### Plugin 结构

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── task-1.md
│   ├── task-2.md
│   └── workflows/
├── agents/
│   ├── specialist-1.md
│   ├── specialist-2.md
│   └── configs/
├── skills/
│   ├── skill-1.md
│   └── skill-2.md
├── hooks/
│   └── hooks.json
├── .mcp.json
├── .lsp.json
├── settings.json
├── templates/
│   └── issue-template.md
├── scripts/
│   ├── helper-1.sh
│   └── helper-2.py
├── docs/
│   ├── README.md
│   └── USAGE.md
└── tests/
    └── plugin.test.js
```

### 实用示例

#### 示例 1：PR Review Plugin

**文件：** `.claude-plugin/plugin.json`

```json
{
  "name": "pr-review",
  "version": "1.0.0",
  "description": "Complete PR review workflow with security, testing, and docs",
  "author": {
    "name": "Anthropic"
  },
  "license": "MIT"
}
```

**文件：** `commands/review-pr.md`

```markdown
---
name: Review PR
description: Start comprehensive PR review with security and testing checks
---

# PR Review

这个命令会发起一次完整的 pull request 审查，包含：

1. 安全分析
2. 测试覆盖率验证
3. 文档更新检查
4. 代码质量检查
5. 性能影响评估
```

**文件：** `agents/security-reviewer.md`

```yaml
---
name: security-reviewer
description: Security-focused code review
tools: read, grep, diff
---

# Security Reviewer

专注于发现以下安全问题：
- 认证 / 授权问题
- 数据暴露
- 注入攻击
- 安全配置
```

**安装：**

```bash
/plugin install pr-review

# Result:
# ✅ 已安装 3 个 slash command
# ✅ 已配置 3 个 subagent
# ✅ 已连接 2 个 MCP server
# ✅ 已注册 4 个 hook
# ✅ 可以立即使用！
```

#### 示例 2：DevOps Plugin

**组件：**

```
devops-automation/
├── commands/
│   ├── deploy.md
│   ├── rollback.md
│   ├── status.md
│   └── incident.md
├── agents/
│   ├── deployment-specialist.md
│   ├── incident-commander.md
│   └── alert-analyzer.md
├── mcp/
│   ├── github-config.json
│   ├── kubernetes-config.json
│   └── prometheus-config.json
├── hooks/
│   ├── pre-deploy.js
│   ├── post-deploy.js
│   └── on-error.js
└── scripts/
    ├── deploy.sh
    ├── rollback.sh
    └── health-check.sh
```

#### 示例 3：Documentation Plugin

**打包的组件：**

```
documentation/
├── commands/
│   ├── generate-api-docs.md
│   ├── generate-readme.md
│   ├── sync-docs.md
│   └── validate-docs.md
├── agents/
│   ├── api-documenter.md
│   ├── code-commentator.md
│   └── example-generator.md
├── mcp/
│   ├── github-docs-config.json
│   └── slack-announce-config.json
└── templates/
    ├── api-endpoint.md
    ├── function-docs.md
    └── adr-template.md
```

### Plugin Marketplace

```mermaid
graph TB
    A["Plugin Marketplace"]
    B["Official<br/>Anthropic"]
    C["Community<br/>Marketplace"]
    D["Enterprise<br/>Registry"]

    A --> B
    A --> C
    A --> D

    B -->|Categories| B1["Development"]
    B -->|Categories| B2["DevOps"]
    B -->|Categories| B3["Documentation"]

    C -->|Search| C1["DevOps Automation"]
    C -->|Search| C2["Mobile Dev"]
    C -->|Search| C3["Data Science"]

    D -->|Internal| D1["Company Standards"]
    D -->|Internal| D2["Legacy Systems"]
    D -->|Internal| D3["Compliance"]
```

### Plugin 安装与生命周期

```mermaid
graph LR
    A["Discover"] -->|Browse| B["Marketplace"]
    B -->|Select| C["Plugin Page"]
    C -->|View| D["Components"]
    D -->|Install| E["/plugin install"]
    E -->|Extract| F["Configure"]
    F -->|Activate| G["Use"]
    G -->|Check| H["Update"]
    H -->|Available| G
    G -->|Done| I["Disable"]
    I -->|Later| J["Enable"]
    J -->|Back| G
```

### Plugin 特性对比

| Feature | Slash Command | Skill | Subagent | Plugin |
|---------|---------------|-------|----------|--------|
| **Installation** | 手动复制 | 手动复制 | 手动配置 | 一条命令 |
| **Setup Time** | 5 分钟 | 10 分钟 | 15 分钟 | 2 分钟 |
| **Bundling** | 单文件 | 单文件 | 单文件 | 多组件 |
| **Versioning** | 手动 | 手动 | 手动 | 自动 |
| **Team Sharing** | 复制文件 | 复制文件 | 复制文件 | Install ID |
| **Updates** | 手动 | 手动 | 手动 | 自动可用 |
| **Dependencies** | 无 | 无 | 无 | 可能包含 |
| **Marketplace** | 否 | 否 | 否 | 是 |
| **Distribution** | 仓库 | 仓库 | 仓库 | Marketplace |

### Plugin 使用场景

| Use Case | Recommendation | Why |
|----------|-----------------|-----|
| **Team Onboarding** | ✅ 使用 Plugin | 即装即用，全部配置一次到位 |
| **Framework Setup** | ✅ 使用 Plugin | 可打包框架专属命令 |
| **Enterprise Standards** | ✅ 使用 Plugin | 集中分发、便于版本控制 |
| **Quick Task Automation** | ❌ 用 Command | 用 Plugin 会过于复杂 |
| **Single Domain Expertise** | ❌ 用 Skill | Plugin 太重，更适合 Skill |
| **Specialized Analysis** | ❌ 用 Subagent | 手动创建或用 Skill 更合适 |
| **Live Data Access** | ❌ 用 MCP | 适合独立使用，不必打包 |

### 什么时候该创建 Plugin

```mermaid
graph TD
    A["Should I create a plugin?"]
    A -->|Need multiple components| B{"Multiple commands<br/>or subagents<br/>or MCPs?"}
    B -->|Yes| C["✅ Create Plugin"]
    B -->|No| D["Use Individual Feature"]
    A -->|Team workflow| E{"Share with<br/>team?"}
    E -->|Yes| C
    E -->|No| F["Keep as Local Setup"]
    A -->|Complex setup| G{"Needs auto<br/>configuration?"}
    G -->|Yes| C
    G -->|No| D
```

### 发布 Plugin

**发布步骤：**

1. 创建包含全部组件的 plugin 结构
2. 编写 `.claude-plugin/plugin.json` 清单文件
3. 创建带说明文档的 `README.md`
4. 使用 `/plugin install ./my-plugin` 本地测试
5. 提交到 plugin marketplace
6. 等待审核通过
7. 正式发布到 marketplace
8. 用户即可通过一条命令安装

**提交流程示例：**

~~~~markdown
# PR Review Plugin

## Description
完整的 PR 审查工作流，包含安全、测试和文档检查。

## What's Included
- 3 个面向不同审查类型的 slash command
- 3 个专用 subagent
- GitHub 和 CodeQL MCP 集成
- 自动化安全扫描 hooks

## Installation
```bash
/plugin install pr-review
```

## Features
✅ 安全分析
✅ 测试覆盖率检查
✅ 文档校验
✅ 代码质量评估
✅ 性能影响分析

## Usage
```bash
/review-pr
/check-security
/check-tests
```

## Requirements
- Claude Code 1.0+
- GitHub 访问权限
- CodeQL（可选）
~~~~

### Plugin 与手动配置的对比

**手动配置（2+ 小时）：**
- 逐个安装 slash command
- 单独创建 subagent
- 分别配置 MCP
- 手动设置 hooks
- 给所有内容写文档
- 分享给团队（并希望每个人都配置正确）

**使用 Plugin（2 分钟）：**
```bash
/plugin install pr-review
# ✅ 所有内容都已安装并配置完成
# ✅ 可立即开始使用
# ✅ 团队可以复现完全一致的配置
```

---

## Comparison & Integration

### 功能对比矩阵

| Feature | Invocation | Persistence | Scope | Use Case |
|---------|-----------|------------|-------|----------|
| **Slash Commands** | 手动（`/cmd`） | 仅会话内 | 单条命令 | 快速快捷操作 |
| **Subagents** | 自动委派 | 隔离上下文 | 专用任务 | 任务分发 |
| **Memory** | 自动加载 | 跨会话 | 用户 / 团队上下文 | 长期学习 |
| **MCP Protocol** | 自动查询 | 实时外部数据 | 实时数据访问 | 动态信息 |
| **Skills** | 自动调用 | 基于文件系统 | 可复用专长 | 自动化工作流 |

### 交互时间线

```mermaid
graph LR
    A["Session Start"] -->|Load| B["Memory (CLAUDE.md)"]
    B -->|Discover| C["Available Skills"]
    C -->|Register| D["Slash Commands"]
    D -->|Connect| E["MCP Servers"]
    E -->|Ready| F["User Interaction"]

    F -->|Type /cmd| G["Slash Command"]
    F -->|Request| H["Skill Auto-Invoke"]
    F -->|Query| I["MCP Data"]
    F -->|Complex task| J["Delegate to Subagent"]

    G -->|Uses| B
    H -->|Uses| B
    I -->|Uses| B
    J -->|Uses| B
```

### 实战集成示例：客户支持自动化

#### 架构

```mermaid
graph TB
    User["Customer Email"] -->|Receives| Router["Support Router"]

    Router -->|Analyze| Memory["Memory<br/>Customer history"]
    Router -->|Lookup| MCP1["MCP: Customer DB<br/>Previous tickets"]
    Router -->|Check| MCP2["MCP: Slack<br/>Team status"]

    Router -->|Route Complex| Sub1["Subagent: Tech Support<br/>Context: Technical issues"]
    Router -->|Route Simple| Sub2["Subagent: Billing<br/>Context: Payment issues"]
    Router -->|Route Urgent| Sub3["Subagent: Escalation<br/>Context: Priority handling"]

    Sub1 -->|Format| Skill1["Skill: Response Generator<br/>Brand voice maintained"]
    Sub2 -->|Format| Skill2["Skill: Response Generator"]
    Sub3 -->|Format| Skill3["Skill: Response Generator"]

    Skill1 -->|Generate| Output["Formatted Response"]
    Skill2 -->|Generate| Output
    Skill3 -->|Generate| Output

    Output -->|Post| MCP3["MCP: Slack<br/>Notify team"]
    Output -->|Send| Reply["Customer Reply"]
```

#### 请求流转

```markdown
## Customer Support Request Flow

### 1. Incoming Email
"I'm getting error 500 when trying to upload files. This is blocking my workflow!"

### 2. Memory Lookup
- 加载包含支持标准的 CLAUDE.md
- 检查客户历史：VIP 客户，本月第 3 次事故

### 3. MCP Queries
- GitHub MCP：列出 open issues（发现相关 bug report）
- Database MCP：检查系统状态（没有上报宕机）
- Slack MCP：检查工程团队是否已经知晓

### 4. Skill Detection & Loading
- 请求匹配到 "Technical Support" skill
- 从 Skill 中加载支持回复模板

### 5. Subagent Delegation
- 路由给 Tech Support Subagent
- 提供上下文：客户历史、错误细节、已知问题
- 该 Subagent 拥有对 `read`、`bash`、`grep` 工具的完整访问权

### 6. Subagent Processing
Tech Support Subagent:
- 在代码库中搜索文件上传相关的 500 错误
- 在 commit `8f4a2c` 中找到最近改动
- 编写临时解决方案说明

### 7. Skill Execution
Response Generator Skill:
- 使用品牌语气规范
- 以共情方式组织回复
- 包含 workaround 步骤
- 链接到相关文档

### 8. MCP Output
- 在 `#support` Slack 频道中发布更新
- @ 工程团队
- 通过 Jira MCP 更新工单

### 9. Response
客户收到：
- 体现共情的确认回复
- 问题原因说明
- 可立即使用的 workaround
- 永久修复的时间线
- 指向相关 issue 的链接
```

### 完整功能编排

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Memory as Memory<br/>CLAUDE.md
    participant MCP as MCP Servers
    participant Skills as Skills
    participant SubAgent as Subagents

    User->>Claude: Request: "Build auth system"
    Claude->>Memory: Load project standards
    Memory-->>Claude: Auth standards, team practices
    Claude->>MCP: Query GitHub for similar implementations
    MCP-->>Claude: Code examples, best practices
    Claude->>Skills: Detect matching Skills
    Skills-->>Claude: Security Review Skill + Testing Skill
    Claude->>SubAgent: Delegate implementation
    SubAgent->>SubAgent: Build feature
    Claude->>Skills: Apply Security Review Skill
    Skills-->>Claude: Security checklist results
    Claude->>SubAgent: Delegate testing
    SubAgent-->>Claude: Test results
    Claude->>User: Complete system delivered
```

### 什么时候用哪种特性

```mermaid
graph TD
    A["New Task"] --> B{Type of Task?}

    B -->|Repeated workflow| C["Slash Command"]
    B -->|Need real-time data| D["MCP Protocol"]
    B -->|Remember for next time| E["Memory"]
    B -->|Specialized subtask| F["Subagent"]
    B -->|Domain-specific work| G["Skill"]

    C --> C1["✅ Team shortcut"]
    D --> D1["✅ Live API access"]
    E --> E1["✅ Persistent context"]
    F --> F1["✅ Parallel execution"]
    G --> G1["✅ Auto-invoked expertise"]
```

### 选择决策树

```mermaid
graph TD
    Start["Need to extend Claude?"]

    Start -->|Quick repeated task| A{"Manual or Auto?"}
    A -->|Manual| B["Slash Command"]
    A -->|Auto| C["Skill"]

    Start -->|Need external data| D{"Real-time?"}
    D -->|Yes| E["MCP Protocol"]
    D -->|No/Cross-session| F["Memory"]

    Start -->|Complex project| G{"Multiple roles?"}
    G -->|Yes| H["Subagents"]
    G -->|No| I["Skills + Memory"]

    Start -->|Long-term context| J["Memory"]
    Start -->|Team workflow| K["Slash Command +<br/>Memory"]
    Start -->|Full automation| L["Skills +<br/>Subagents +<br/>MCP"]
```

---

## Summary Table

| Aspect | Slash Commands | Subagents | Memory | MCP | Skills | Plugins |
|--------|---|---|---|---|---|---|
| **Setup Difficulty** | 简单 | 中等 | 简单 | 中等 | 中等 | 简单 |
| **Learning Curve** | 低 | 中等 | 低 | 中等 | 中等 | 低 |
| **Team Benefit** | 高 | 高 | 中等 | 高 | 高 | 很高 |
| **Automation Level** | 低 | 高 | 中等 | 高 | 高 | 很高 |
| **Context Management** | 单会话 | 隔离 | 持久化 | 实时 | 持久化 | 覆盖全部特性 |
| **Maintenance Burden** | 低 | 中等 | 低 | 中等 | 中等 | 低 |
| **Scalability** | 好 | 极佳 | 好 | 极佳 | 极佳 | 极佳 |
| **Shareability** | 一般 | 一般 | 好 | 好 | 好 | 极佳 |
| **Versioning** | 手动 | 手动 | 手动 | 手动 | 手动 | 自动 |
| **Installation** | 手动复制 | 手动配置 | N/A | 手动配置 | 手动复制 | 一条命令 |

---

## Quick Start Guide

### 第 1 周：先从简单的开始
- 为常见任务创建 2-3 个 slash command
- 在 Settings 中启用 Memory
- 在 CLAUDE.md 中记录团队标准

### 第 2 周：加入实时访问能力
- 设置 1 个 MCP（GitHub 或 Database）
- 使用 `/mcp` 完成配置
- 在工作流中查询实时数据

### 第 3 周：分发工作
- 为某个特定角色创建第一个 Subagent
- 使用 `/agents` 命令
- 用简单任务测试委派效果

### 第 4 周：把自动化串起来
- 为重复性自动化创建第一个 Skill
- 使用 Skill marketplace，或自己构建
- 组合所有特性，形成完整工作流

### 持续进行
- 每月审查并更新 Memory
- 随着模式显现，增加新的 Skills
- 优化 MCP 查询
- 持续打磨 Subagent prompts

---

## Hooks

### 概述

Hooks 是事件驱动的 shell 命令，会在 Claude Code 事件发生时自动执行。它们可以在无需人工干预的情况下实现自动化、校验和自定义工作流。

### Hook 事件

Claude Code 支持分布在四类 hook 类型（command、http、prompt、agent）中的 **25 个 hook 事件**：

| Hook Event | Trigger | Use Cases |
|------------|---------|-----------|
| **SessionStart** | 会话开始 / 恢复 / 清空 / compact 时 | 环境初始化、启动设置 |
| **InstructionsLoaded** | 加载 CLAUDE.md 或规则文件时 | 校验、转换、增强 |
| **UserPromptSubmit** | 用户提交 prompt 时 | 输入校验、prompt 过滤 |
| **PreToolUse** | 任意工具运行前 | 校验、审批关口、日志记录 |
| **PermissionRequest** | 显示权限对话框时 | 自动批准 / 拒绝流程 |
| **PostToolUse** | 工具成功执行后 | 自动格式化、通知、清理 |
| **PostToolUseFailure** | 工具执行失败后 | 错误处理、日志记录 |
| **Notification** | 发送通知时 | 告警、外部集成 |
| **SubagentStart** | 启动 subagent 时 | 注入上下文、初始化 |
| **SubagentStop** | subagent 结束时 | 结果校验、日志记录 |
| **Stop** | Claude 回复完成时 | 生成总结、清理任务 |
| **StopFailure** | API 错误导致当前轮次结束时 | 错误恢复、日志记录 |
| **TeammateIdle** | agent 团队成员空闲时 | 工作分配、协作 |
| **TaskCompleted** | 任务被标记为完成时 | 任务后处理 |
| **TaskCreated** | 通过 TaskCreate 创建任务时 | 任务跟踪、日志记录 |
| **ConfigChange** | 配置文件变更时 | 校验、传播更新 |
| **CwdChanged** | 工作目录变化时 | 目录级初始化 |
| **FileChanged** | 被监控文件变化时 | 文件监听、重建触发 |
| **PreCompact** | 上下文 compact 前 | 状态保留 |
| **PostCompact** | compact 完成后 | compact 后动作 |
| **WorktreeCreate** | 创建 worktree 时 | 环境初始化、安装依赖 |
| **WorktreeRemove** | 移除 worktree 时 | 清理、释放资源 |
| **Elicitation** | MCP server 请求用户输入时 | 输入校验 |
| **ElicitationResult** | 用户响应 elicitation 时 | 结果处理 |
| **SessionEnd** | 会话终止时 | 清理、最终日志 |

### 常见 Hooks

Hooks 可以配置在 `~/.claude/settings.json`（用户级）或 `.claude/settings.json`（项目级）中：

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write $CLAUDE_FILE_PATH"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "eslint $CLAUDE_FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

### Hook 环境变量

- `$CLAUDE_FILE_PATH` - 正在编辑 / 写入的文件路径
- `$CLAUDE_TOOL_NAME` - 当前使用的工具名
- `$CLAUDE_SESSION_ID` - 当前会话标识符
- `$CLAUDE_PROJECT_DIR` - 项目目录路径

### 最佳实践

✅ **建议这样做：**
- 保持 hook 足够快（< 1 秒）
- 用 hook 做校验和自动化
- 优雅处理错误
- 使用绝对路径

❌ **不要这样做：**
- 不要让 hook 进入交互模式
- 不要用 hook 执行长时间运行任务
- 不要硬编码凭据

**参见**：[06-hooks/](06-hooks/) 获取更详细示例

---

## Checkpoints and Rewind

### 概述

Checkpoints 允许你保存对话状态，并回退到之前的时间点，从而安全地做实验，或探索多种实现路径。

### 关键概念

| Concept | Description |
|---------|-------------|
| **Checkpoint** | 对话状态的快照，包含消息、文件和上下文 |
| **Rewind** | 回到之前的 checkpoint，并丢弃之后的改动 |
| **Branch Point** | 从该 checkpoint 出发，探索多种方案的分叉点 |

### 访问 Checkpoints

每次用户发出 prompt 时，系统都会自动创建 checkpoint。要回退：

```bash
# 按两次 Esc 打开 checkpoint 浏览器
Esc + Esc

# 或使用 /rewind 命令
/rewind
```

选中某个 checkpoint 后，你可以从五个选项中选择：
1. **Restore code and conversation** -- 同时恢复代码和对话
2. **Restore conversation** -- 回退消息，保留当前代码
3. **Restore code** -- 回退文件，保留对话
4. **Summarize from here** -- 从该点开始压缩对话为摘要
5. **Never mind** -- 取消

### 使用场景

| Scenario | Workflow |
|----------|----------|
| **Exploring Approaches** | 保存 → 尝试方案 A → 保存 → 回退 → 尝试方案 B → 对比 |
| **Safe Refactoring** | 保存 → 重构 → 测试 → 如果失败：回退 |
| **A/B Testing** | 保存 → 设计 A → 保存 → 回退 → 设计 B → 对比 |
| **Mistake Recovery** | 发现问题 → 回退到上一个正确状态 |

### 配置

```json
{
  "autoCheckpoint": true
}
```

**参见**：[08-checkpoints/](08-checkpoints/) 获取更详细示例

---

## Advanced Features

### Planning Mode

在写代码前先创建详细的实现计划。

**激活方式：**
```bash
/plan Implement user authentication system
```

**好处：**
- 带时间预估的清晰路线图
- 风险评估
- 系统化任务拆分
- 便于审查和修改

### Extended Thinking

为复杂问题开启更深入的推理。

**激活方式：**
- 在会话中使用 `Alt+T`（macOS 上为 `Option+T`）切换
- 设置 `MAX_THINKING_TOKENS` 环境变量进行程序化控制

```bash
# 通过环境变量启用 extended thinking
export MAX_THINKING_TOKENS=50000
claude -p "Should we use microservices or monolith?"
```

**好处：**
- 更充分地分析权衡
- 更好的架构决策
- 能考虑边界情况
- 更系统的评估

### Background Tasks

在不阻塞当前对话的情况下运行长任务。

**用法：**
```bash
User: Run tests in background

Claude: Started task bg-1234

/task list           # 显示所有任务
/task status bg-1234 # 查看进度
/task show bg-1234   # 查看输出
/task cancel bg-1234 # 取消任务
```

### Permission Modes

控制 Claude 可以做什么。

| Mode | Description | Use Case |
|------|-------------|----------|
| **default** | 标准权限，敏感操作会提示确认 | 通用开发 |
| **acceptEdits** | 自动接受文件编辑，不再确认 | 可信编辑工作流 |
| **plan** | 仅分析和规划，不修改文件 | 代码审查、架构规划 |
| **auto** | 自动批准安全操作，仅对风险操作提示 | 在安全前提下取得平衡的自主性 |
| **dontAsk** | 不弹确认，直接执行所有操作 | 有经验的用户、自动化场景 |
| **bypassPermissions** | 完全不受限制，无安全检查 | CI/CD 流水线、可信脚本 |

**用法：**
```bash
claude --permission-mode plan          # 只读分析
claude --permission-mode acceptEdits   # 自动接受编辑
claude --permission-mode auto          # 自动批准安全操作
claude --permission-mode dontAsk       # 不再弹确认
```

### Headless Mode（Print Mode）

使用 `-p`（print）参数在无交互模式下运行 Claude Code，适合自动化和 CI/CD。

**用法：**
```bash
# 执行特定任务
claude -p "Run all tests"

# 通过管道输入进行分析
cat error.log | claude -p "explain this error"

# CI/CD 集成（GitHub Actions）
- name: AI Code Review
  run: claude -p "Review PR changes and report issues"

# 供脚本使用的 JSON 输出
claude -p --output-format json "list all functions in src/"
```

### Scheduled Tasks

使用 `/loop` 命令按重复计划执行任务。

**用法：**
```bash
/loop every 30m "Run tests and report failures"
/loop every 2h "Check for dependency updates"
/loop every 1d "Generate daily summary of code changes"
```

计划任务会在后台运行，并在完成后回报结果。它们适合持续监控、周期检查和自动维护工作流。

### Chrome Integration

Claude Code 可以与 Chrome 浏览器集成，用于处理 Web 自动化任务。这让它能够在开发工作流中直接完成网页导航、表单填写、截图和网站数据提取等操作。

### Session Management

管理多个工作会话。

**命令：**
```bash
/resume                # 恢复之前的对话
/rename "Feature"      # 为当前会话命名
/fork                  # 分叉出一个新会话
claude -c              # 继续最近一次对话
claude -r "Feature"    # 通过名称 / ID 恢复会话
```

### Interactive Features

**键盘快捷键：**
- `Ctrl + R` - 搜索命令历史
- `Tab` - 自动补全
- `↑ / ↓` - 命令历史
- `Ctrl + L` - 清屏

**多行输入：**
```bash
User: \
> Long complex prompt
> spanning multiple lines
> \end
```

### 配置

完整配置示例：

```json
{
  "planning": {
    "autoEnter": true,
    "requireApproval": true
  },
  "extendedThinking": {
    "enabled": true,
    "showThinkingProcess": true
  },
  "backgroundTasks": {
    "enabled": true,
    "maxConcurrentTasks": 5
  },
  "permissions": {
    "mode": "default"
  }
}
```

**参见**：[09-advanced-features/](09-advanced-features/) 获取完整指南

---

## Resources

- [Claude Code Documentation](https://code.claude.com/docs/en/overview)
- [Anthropic Documentation](https://docs.anthropic.com/en/docs/claude-code/overview)
- [MCP GitHub Servers](https://github.com/modelcontextprotocol/servers)
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)

---

*最后更新：2026 年 3 月*
*适用于 Claude Haiku 4.5、Sonnet 4.6 和 Opus 4.6*
*现已包含：Hooks、Checkpoints、Planning Mode、Extended Thinking、Background Tasks、Permission Modes（6 种模式）、Headless Mode、Session Management、Auto Memory、Agent Teams、Scheduled Tasks、Chrome Integration、Channels、Voice Dictation 和 Bundled Skills*
