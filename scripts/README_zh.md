<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-code-guide-logo-dark.svg">
  <img alt="Claude Code Guide" src="../resources/logos/claude-code-guide-logo.svg">
</picture>

# EPUB 构建脚本

把 Claude Code Guide 的 Markdown 文件构建成 EPUB 电子书。

## 功能

- 根据目录结构组织章节（`01-slash-commands`、`02-memory` 等）
- 通过 Kroki.io API 把 Mermaid 图渲染成 PNG
- 异步并发获取，所有图表可并行渲染
- 从项目 Logo 生成封面图
- 将内部 Markdown 链接转换成 EPUB 章节引用
- 严格错误模式：只要任意图表渲染失败就直接失败

## 依赖要求

- Python 3.10+
- [uv](https://github.com/astral-sh/uv)
- 用于渲染 Mermaid 图的互联网连接

## 快速开始

```bash
# 最简单的方式 - uv 会处理所需环境
uv run scripts/build_epub.py
```

## 开发环境设置

```bash
# 创建虚拟环境
uv venv

# 激活并安装依赖
source .venv/bin/activate
uv pip install -r requirements-dev.txt

# 运行测试
pytest scripts/tests/ -v

# 运行脚本
python scripts/build_epub.py
```

## 命令行参数

```
usage: build_epub.py [-h] [--root ROOT] [--output OUTPUT] [--verbose]
                     [--timeout TIMEOUT] [--max-concurrent MAX_CONCURRENT]

options:
  -h, --help            显示帮助并退出
  --root, -r ROOT       根目录（默认：仓库根目录）
  --output, -o OUTPUT   输出路径（默认：claude-code-guide.epub）
  --verbose, -v         启用详细日志
  --timeout TIMEOUT     API 超时时间，单位秒（默认：30）
  --max-concurrent N    最大并发请求数（默认：10）
```

## 示例

```bash
# 输出详细日志进行构建
uv run scripts/build_epub.py --verbose

# 自定义输出位置
uv run scripts/build_epub.py --output ~/Desktop/claude-guide.epub

# 限制并发请求数量（如果遇到限流）
uv run scripts/build_epub.py --max-concurrent 5
```

## 输出结果

会在仓库根目录生成 `claude-code-guide.epub`。

生成的 EPUB 包含：
- 带项目 Logo 的封面图
- 支持嵌套章节的目录
- 全部 Markdown 内容，转换为 EPUB 兼容 HTML
- 渲染成 PNG 的 Mermaid 图

## 运行测试

```bash
# 使用虚拟环境
source .venv/bin/activate
pytest scripts/tests/ -v

# 或直接使用 uv
uv run --with pytest --with pytest-asyncio \
    --with ebooklib --with markdown --with beautifulsoup4 \
    --with httpx --with pillow --with tenacity \
    pytest scripts/tests/ -v
```

## 依赖项

通过 PEP 723 内联脚本元数据管理：

| Package | Purpose |
|---------|---------|
| `ebooklib` | EPUB 生成 |
| `markdown` | Markdown 转 HTML |
| `beautifulsoup4` | HTML 解析 |
| `httpx` | 异步 HTTP 客户端 |
| `pillow` | 封面图生成 |
| `tenacity` | 重试逻辑 |

## 排障

**构建因网络错误失败**：检查网络连接和 Kroki.io 状态。可以尝试 `--timeout 60`。

**被限流**：通过 `--max-concurrent 3` 降低并发请求数。

**缺少 Logo**：如果找不到 `claude-code-guide-logo.png`，脚本会生成一个纯文字封面。
