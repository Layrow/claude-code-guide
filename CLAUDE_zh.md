# CLAUDE.md

这个文件为 Claude Code（claude.ai/code）在本仓库中工作时提供指导。

## 项目概览

Claude How To 是一个面向 Claude Code 功能的教程仓库。这是一个 **documentation-as-code** 项目，主要产出是按编号组织的 Markdown 学习模块，而不是一个可执行应用。

**架构**：每个模块（01-10）聚焦一个特定的 Claude Code 特性，包含可直接复制使用的模板、Mermaid 图和示例。构建系统会校验文档质量，并生成 EPUB 电子书。

## 常用命令

### Pre-commit 质量检查

所有文档在提交前都必须通过四项质量检查（这些检查会通过 pre-commit hooks 自动运行）：

```bash
# 安装 pre-commit hooks（每次 commit 时自动运行）
pre-commit install

# 手动运行所有检查
pre-commit run --all-files
```

这四项检查包括：
1. **markdown-lint** — 使用 `markdownlint` 检查 Markdown 结构与格式
2. **cross-references** — 检查内部链接、锚点和代码围栏语法（Python 脚本）
3. **mermaid-syntax** — 校验所有 Mermaid 图是否能正确解析（Python 脚本）
4. **link-check** — 检查外部 URL 是否可访问（Python 脚本）
5. **build-epub** — 校验 EPUB 是否能成功生成（在 `.md` 变更时运行）

### 开发环境搭建

```bash
# 安装 uv（Python 包管理器）
pip install uv

# 创建虚拟环境并安装 Python 依赖
uv venv
source .venv/bin/activate
uv pip install -r scripts/requirements-dev.txt

# 安装 Node.js 工具（Markdown linter 和 Mermaid 校验器）
npm install -g markdownlint-cli
npm install -g @mermaid-js/mermaid-cli

# 安装 pre-commit hooks
uv pip install pre-commit
pre-commit install
```

### 测试

`scripts/` 中的 Python 脚本带有单元测试：

```bash
# 运行全部测试
pytest scripts/tests/ -v

# 带覆盖率运行
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 运行单个测试
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
# 生成电子书（通过 Kroki.io API 渲染 Mermaid 图）
uv run scripts/build_epub.py

# 带选项运行
uv run scripts/build_epub.py --verbose --output custom-name.epub --max-concurrent 5
```

## 目录结构

```
├── 01-slash-commands/      # 用户触发的快捷命令
├── 02-memory/              # 持久上下文示例
├── 03-skills/              # 可复用能力
├── 04-subagents/           # 专用 AI 助手
├── 05-mcp/                 # Model Context Protocol 示例
├── 06-hooks/               # 事件驱动自动化
├── 07-plugins/             # 打包式功能
├── 08-checkpoints/         # 会话快照
├── 09-advanced-features/   # 规划、思考、后台任务等
├── 10-cli/                 # CLI 参考
├── scripts/
│   ├── build_epub.py           # EPUB 生成器（通过 Kroki API 渲染 Mermaid）
│   ├── check_cross_references.py   # 校验内部链接
│   ├── check_links.py          # 检查外部链接
│   ├── check_mermaid.py        # 校验 Mermaid 语法
│   └── tests/                  # scripts 的单元测试
├── .pre-commit-config.yaml    # 质量检查定义
└── README.md               # 主指南（同时也是模块索引）
```

## 内容规范

### 模块结构
每个编号目录都遵循以下模式：
- **README.md** — 该特性的概览与示例
- **Example files** — 可直接复制粘贴的模板（命令使用 `.md`，配置使用 `.json`，hooks 使用 `.sh`）
- 文件按功能复杂度和依赖关系组织

### Mermaid 图
- 所有图都必须能成功解析（由 pre-commit hook 检查）
- EPUB 构建会通过 Kroki.io API 渲染图表（需要网络）
- 使用 Mermaid 表达流程图、时序图和架构图

### 交叉引用
- 内部链接使用相对路径（例如 `(01-slash-commands/README.md)`）
- 代码围栏必须标注语言（例如 ` ```bash `、` ```python `）
- 锚点链接使用 `#heading-name` 格式

### 链接校验
- 外部 URL 必须可访问（由 pre-commit hook 检查）
- 避免链接到短期易失效内容
- 尽量使用永久链接

## 关键架构点

1. **编号目录表示学习顺序** — `01-10` 前缀代表推荐的 Claude Code 学习路径。这个编号是有意设计的，不要按字母顺序重排。

2. **Scripts 是工具，不是产品本身** — `scripts/` 中的 Python 脚本用于支持文档质量检查和 EPUB 生成。真正的内容产物在这些编号模块目录中。

3. **Pre-commit 是质量门禁** — 所有四项质量检查都必须通过，PR 才会被接受。CI 流水线会再运行一遍同样的检查。

4. **Mermaid 渲染需要网络** — EPUB 构建会调用 Kroki.io API 来渲染图表。这里的失败通常意味着网络问题或 Mermaid 语法无效。

5. **这是教程仓库，不是库项目** — 新增内容时，应把重点放在清晰解释、可复制示例和可视化图表上。这里的价值在于教学，而不是提供可复用代码。

## 提交约定

遵循 conventional commit 格式：
- `feat(slash-commands): Add API documentation generator`
- `docs(memory): Improve personal preferences example`
- `fix(README): Correct table of contents link`
- `refactor(hooks): Simplify hook configuration examples`

如果适用，scope 应与目录名保持一致。
