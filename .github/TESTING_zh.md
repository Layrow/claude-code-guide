# 测试指南

本文说明 Claude How To 的测试基础设施。用户可读文档现在放在并行的 `en/` 和 `zh/` 两棵目录树中，而验证工具仍保留在仓库根目录。

## 概述

项目使用 GitHub Actions 在每次 push 和 pull request 时自动运行测试。测试覆盖以下方面：

- **Unit Tests**：基于 pytest 的 Python 测试
- **Code Quality**：使用 Ruff 做 lint 和格式检查
- **Security**：使用 Bandit 做漏洞扫描
- **Type Checking**：使用 mypy 做静态类型分析
- **Build Verification**：验证 EPUB 能否成功生成

## 本地运行测试

### 前置要求

```bash
# 安装 uv（快速 Python 包管理器）
pip install uv

# 或在 macOS 上使用 Homebrew
brew install uv
```

### 环境准备

```bash
# 克隆仓库
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto

# 创建虚拟环境
uv venv

# 激活环境
source .venv/bin/activate  # macOS/Linux
# 或
.venv\Scripts\activate     # Windows

# 安装开发依赖
uv pip install -r scripts/requirements-dev.txt
```

### 运行测试

```bash
# 运行所有单元测试
pytest scripts/tests/ -v

# 带覆盖率运行
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 运行指定测试文件
pytest scripts/tests/test_build_epub.py -v

# 运行指定测试函数
pytest scripts/tests/test_build_epub.py::test_function_name -v

# 以 watch 模式运行（需要 pytest-watch）
ptw scripts/tests/
```

### 运行 Lint

```bash
# 检查代码格式
ruff format --check scripts/

# 自动修复格式问题
ruff format scripts/

# 运行 linter
ruff check scripts/

# 自动修复 linter 问题
ruff check --fix scripts/
```

### 运行安全扫描

```bash
# 运行 Bandit 安全扫描
bandit -c scripts/pyproject.toml -r scripts/ --exclude scripts/tests/

# 生成 JSON 报告
bandit -c scripts/pyproject.toml -r scripts/ --exclude scripts/tests/ -f json -o bandit-report.json
```

### 运行类型检查

```bash
# 使用 mypy 检查类型
mypy scripts/ --ignore-missing-imports --no-implicit-optional
```

## GitHub Actions 工作流

### 触发条件

- 向 `main` 或 `develop` 分支 **push**（当 scripts 有变化时）
- 向 `main` 发起 **pull request**（当 scripts 有变化时）
- 手动触发 workflow dispatch

### Jobs

#### 1. Unit Tests（pytest）

- **运行环境**：Ubuntu latest
- **Python 版本**：3.10、3.11、3.12
- **执行内容**：
  - 安装 `scripts/requirements-dev.txt` 中的依赖
  - 使用 coverage 报告运行 pytest
  - 将覆盖率上传到 Codecov
  - 归档测试结果和 coverage HTML

**结果**：只要有任意测试失败，workflow 就失败（关键阻塞项）

#### 2. Code Quality（Ruff）

- **运行环境**：Ubuntu latest
- **Python 版本**：3.11
- **执行内容**：
  - 用 `ruff format` 检查格式
  - 用 `ruff check` 运行 lint
  - 报告问题，但不让 workflow 失败

**结果**：非阻塞（仅告警）

#### 3. Security Scan（Bandit）

- **运行环境**：Ubuntu latest
- **Python 版本**：3.11
- **执行内容**：
  - 扫描安全漏洞
  - 生成 JSON 报告
  - 将报告作为 artifact 上传

**结果**：非阻塞（仅告警）

#### 4. Type Checking（mypy）

- **运行环境**：Ubuntu latest
- **Python 版本**：3.11
- **执行内容**：
  - 执行静态类型分析
  - 报告类型不匹配问题
  - 帮助尽早发现 bug

**结果**：非阻塞（仅告警）

#### 5. Build EPUB

- **运行环境**：Ubuntu latest
- **依赖**：pytest、lint、security（都必须先完成）
- **执行内容**：
  - 使用 `scripts/build_epub.py --root en` 构建英文 EPUB
  - 校验 EPUB 是否成功生成
  - 将 EPUB 作为 artifact 上传

**结果**：如果构建失败，workflow 就失败（关键阻塞项）

本地 pre-commit 使用的是 best-effort 的 EPUB 包装脚本，因此临时 Kroki / 网络问题不会阻塞 commit；但 CI 里的严格构建仍然是最终门禁。

#### 6. Summary

- **运行环境**：Ubuntu latest
- **依赖**：所有其他 jobs
- **执行内容**：
  - 生成 workflow 总结
  - 列出所有 artifacts
  - 报告整体状态

## 编写测试

### 测试结构

测试应放在 `scripts/tests/` 下，文件名格式类似 `test_*.py`：

```python
# scripts/tests/test_example.py
import pytest
from scripts.example_module import some_function

def test_basic_functionality():
    """测试 some_function 是否正确工作。"""
    result = some_function("input")
    assert result == "expected_output"

def test_error_handling():
    """测试 some_function 是否能优雅处理错误。"""
    with pytest.raises(ValueError):
        some_function("invalid_input")

@pytest.mark.asyncio
async def test_async_function():
    """测试异步函数。"""
    result = await async_function()
    assert result is not None
```

### 测试最佳实践

- **使用有描述性的名称**：如 `test_function_returns_correct_value()`
- **每个测试尽量只做一个断言**：更容易排查失败原因
- **对可复用准备逻辑使用 fixtures**：参见 `scripts/tests/conftest.py`
- **Mock 外部服务**：使用 `unittest.mock` 或 `pytest-mock`
- **测试边界情况**：空输入、None 值、错误路径
- **保持测试快速**：避免 `sleep()` 和外部 I/O
- **使用 pytest markers**：慢测试用 `@pytest.mark.slow`

### Fixtures

常用 fixtures 定义在 `scripts/tests/conftest.py` 中：

```python
# 在测试中使用 fixtures
def test_something(tmp_path):
    """tmp_path fixture 会提供一个临时目录。"""
    test_file = tmp_path / "test.txt"
    test_file.write_text("content")
```
