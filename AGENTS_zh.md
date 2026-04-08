# AGENTS.md

本文件为 Codex（Codex.ai/code）在本仓库中协作时提供工作指引。

## 项目概览

Codex How To 是一个面向 Codex 功能的教程仓库。这是一个 **documentation-as-code** 项目，主要产出是按编号组织的 Markdown 学习模块，而不是一个可执行应用。

**架构**：文档按并行的 `en/` 和 `zh/` 两棵目录树组织。每个模块（01-10）讲解一个特定的 Codex 功能，并配有可复制使用的模板、Mermaid 图示和示例。构建系统会校验文档质量，并从指定语言根目录生成 EPUB 电子书。

## 常用命令

### Pre-commit 质量检查

所有文档在提交前都必须通过以下质量检查（这些检查会通过 pre-commit hooks 自动运行）：

```bash
# 安装 pre-commit hooks（每次 commit 时运行）
pre-commit install

# 手动运行全部检查
pre-commit run --all-files
```

这几项检查包括：
1. **markdown-lint** — 通过 `markdownlint` 检查 Markdown 结构与格式
2. **cross-references** — 检查内部链接、锚点和代码块语法（Python 脚本）
3. **mermaid-syntax** — 校验所有 Mermaid 图都能正确解析（Python 脚本）
4. **link-check** — 检查外部 URL 是否可访问（Python 脚本）
5. **build-epub** — 在 `.md` 变更时执行 best-effort 的本地 EPUB 校验；CI 仍然运行严格构建

### 开发环境配置

```bash
# 安装 uv（Python 包管理工具）
pip install uv

# 创建虚拟环境并安装 Python 依赖
uv venv
source .venv/bin/activate
uv pip install -r scripts/requirements-dev.txt

# 安装 Node.js 工具（Markdown lint 和 Mermaid 校验器）
npm install -g markdownlint-cli
npm install -g @mermaid-js/mermaid-cli

# 安装 pre-commit hooks
uv pip install pre-commit
pre-commit install
```

### 测试

`scripts/` 目录下的 Python 脚本带有单元测试：

```bash
# 运行全部测试
pytest scripts/tests/ -v

# 带覆盖率运行
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 运行指定测试
pytest scripts/tests/test_build_epub.py -v
```

### 代码质量

```bash
# 检查并格式化 Python 代码
ruff check scripts/
ruff format scripts/

# 安全扫描
bandit -c scripts/pyproject.toml -r scripts/ --exclude scripts/tests/

# 类型检查
mypy scripts/ --ignore-missing-imports
```

### EPUB 构建

```bash
# 生成英文电子书（通过 Kroki.io API 渲染 Mermaid 图）
uv run scripts/build_epub.py --root en

# 生成中文电子书
uv run scripts/build_epub.py --root zh

# 带选项运行
uv run scripts/build_epub.py --root en --verbose --output custom-name.epub --max-concurrent 5
```

## 目录结构

```
├── en/
│   ├── 01-slash-commands/      # 英文 slash-command 教程
│   ├── 02-memory/              # 英文 memory 教程
│   ├── 03-skills/              # 英文 skills 教程
│   ├── 04-subagents/           # 英文 subagent 教程
│   ├── 05-mcp/                 # 英文 MCP 教程
│   ├── 06-hooks/               # 英文 hook 教程
│   ├── 07-plugins/             # 英文 plugin 教程
│   ├── 08-checkpoints/         # 英文 checkpoint 教程
│   ├── 09-advanced-features/   # 英文高级功能教程
│   └── 10-cli/                 # 英文 CLI 参考
├── zh/
│   ├── 01-slash-commands/      # 中文 slash-command 教程
│   ├── 02-memory/              # 中文 memory 教程
│   ├── 03-skills/              # 中文 skills 教程
│   ├── 04-subagents/           # 中文 subagent 教程
│   ├── 05-mcp/                 # 中文 MCP 教程
│   ├── 06-hooks/               # 中文 hook 教程
│   ├── 07-plugins/             # 中文 plugin 教程
│   ├── 08-checkpoints/         # 中文 checkpoint 教程
│   ├── 09-advanced-features/   # 中文高级功能教程
│   └── 10-cli/                 # 中文 CLI 参考
├── scripts/
│   ├── build_epub.py           # EPUB 生成器（通过 Kroki API 渲染 Mermaid）
│   ├── check_cross_references.py   # 校验内部链接
│   ├── check_links.py          # 检查外部 URL
│   ├── check_mermaid.py        # 校验 Mermaid 语法
│   └── tests/                  # 脚本单元测试
├── .pre-commit-config.yaml    # 质量检查定义
└── README.md               # 主指南（同时也是模块索引）
```

## 内容约定

### 模块结构
`en/` 和 `zh/` 下每个编号目录都遵循相同模式：
- **README.md** — 对该功能的概览与示例说明
- **示例文件** — 可直接复制使用的模板（命令用 `.md`，配置用 `.json`，hooks 用 `.sh`）
- 文件按功能复杂度和依赖关系组织

### Mermaid 图
- 所有图都必须能够成功解析（由 pre-commit hook 检查）
- EPUB 构建会通过 Kroki.io API 渲染 Mermaid 图（需要联网）
- 流程图、时序图和架构图优先使用 Mermaid

### 交叉引用
- 在同一语言目录树内使用相对路径做内部链接（例如在 `en/README.md` 中写 `(01-slash-commands/README.md)`）
- 代码块必须声明语言类型（例如 ` ```bash `、` ```python `）
- 锚点链接使用 `#heading-name` 格式

### 链接校验
- 外部 URL 必须可访问（由 pre-commit hook 检查）
- 避免链接到易失内容
- 尽可能使用永久链接

## 关键架构点

1. **编号目录表示学习顺序** — `en/` 和 `zh/` 中的 `01` 到 `10` 前缀都表示推荐的 Codex 学习顺序。这个编号是有意设计的，不要按字母顺序重排。

2. **脚本是工具，不是产品本身** — `scripts/` 里的 Python 脚本用于支持文档质量检查和 EPUB 生成，真正的内容在 `en/` 和 `zh/` 两棵文档树里。

3. **Pre-commit 是第一道门禁** — 在 PR 被接受之前，所有质量检查都必须通过。CI 流水线会再次运行同样的检查作为第二道验证。

4. **Mermaid 渲染依赖网络** — EPUB 构建会调用 Kroki.io API 渲染图表。本地 pre-commit 会把临时网络失败视为警告，但 CI 里真实的 EPUB 构建失败仍然会阻塞。

5. **这是教程，不是库** — 增加内容时，要优先考虑清晰解释、可复制示例和可视化图示。这个仓库的价值在于讲清概念，而不是提供可复用代码。

## 提交约定

遵循 conventional commit 格式：
- `feat(slash-commands): Add API documentation generator`
- `docs(memory): Improve personal preferences example`
- `fix(README): Correct table of contents link`
- `refactor(hooks): Simplify hook configuration examples`

如果适用，scope 应与对应目录名保持一致。
