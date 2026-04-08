# 安全策略

## 概览

Claude Code Guide 项目的安全性对我们非常重要。本文档说明了我们的安全实践，以及如何以负责任的方式报告安全漏洞。

## 支持版本

我们会为以下版本提供安全更新：

| Version | Status | Support Until |
|---------|--------|---------------|
| Latest (main) | ✅ Active | 当前版本 + 6 个月 |
| 1.x releases | ✅ Active | 直到下一个 major version |

**注意**：作为一个教育指南项目，我们更关注维护当前最佳实践和文档安全，而不是传统意义上的版本维护。更新会直接应用到主分支。

## 安全实践

### 代码安全

1. **依赖管理**
   - 所有 Python 依赖都固定在 `requirements.txt` 中
   - 通过 dependabot 和人工审查定期更新
   - 每次 commit 都使用 Bandit 做安全扫描
   - 使用 pre-commit hooks 进行安全检查

2. **代码质量**
   - Ruff linting 可捕获常见问题
   - mypy 类型检查可防止类型相关漏洞
   - pre-commit hooks 强制执行标准
   - 所有改动在合并前都会经过审查

3. **访问控制**
   - `main` 分支启用 branch protection
   - 合并前必须经过 review
   - 所有状态检查必须通过后才能合并
   - 仓库写权限受限

### 文档安全

1. **示例中不包含 Secrets**
   - 所有示例中的 API key 都是占位值
   - 凭据绝不会被硬编码
   - `.env.example` 文件用于说明所需变量
   - 明确提醒如何管理 secrets

2. **安全最佳实践**
   - 示例展示安全模式
   - 在文档中突出安全警告
   - 链接到官方安全指南
   - 在相关章节讨论凭据处理

3. **内容审查**
   - 所有文档都会审查安全问题
   - 贡献指南中包含安全注意事项
   - 对外部链接和引用进行校验

### 依赖安全

1. **扫描**
   - Bandit 会扫描所有 Python 代码中的漏洞
   - 借助 GitHub security alerts 检查依赖漏洞
   - 定期进行人工安全审计

2. **更新**
   - 安全补丁会尽快应用
   - 谨慎评估 major version 升级
   - 更新日志中会记录安全相关变更

3. **透明性**
   - 安全更新会记录在 commit 中
   - 漏洞披露会以负责任的方式处理
   - 适当时发布公开安全公告

## 报告漏洞

### 我们关心的安全问题

我们欢迎以下类型的报告：
- **脚本或示例中的代码漏洞**
- **Python 包中的依赖漏洞**
- **代码示例中的密码学问题**
- **文档中的认证/授权缺陷**
- **配置示例中的数据泄露风险**
- **注入漏洞**（SQL、命令注入等）
- **SSRF/XXE/路径穿越** 问题

### 不在范围内的安全问题

以下内容不属于本项目范围：
- Claude Code 本身的漏洞（请报告给 Anthropic）
- 外部服务或库的问题（请向上游报告）
- 社会工程学或用户教育问题（不适用于本指南）
- 没有 PoC 的纯理论漏洞
- 已通过官方渠道披露的依赖漏洞

## 如何报告

### 私密报告（推荐）

**对于敏感安全问题，请优先使用 GitHub 的私密漏洞报告：**

1. 访问：https://github.com/Layrow/claude-code-guide/security/advisories
2. 点击 “Report a vulnerability”
3. 填写漏洞详情
4. 尽量包含：
   - 清晰的漏洞描述
   - 受影响的组件（文件、章节、示例）
   - 潜在影响
   - 复现步骤（如适用）
   - 修复建议（如果你有）

**接下来会发生什么：**
- 我们会在 48 小时内确认收到报告
- 我们会调查并评估严重级别
- 我们会和你一起制定修复方案
- 我们会协调披露时间线
- 我们会在安全公告中署名致谢（除非你希望匿名）

### 公开报告

对于不敏感或已经公开的问题：

1. **创建一个 GitHub Issue**，并加上 `security` 标签
2. 内容请包含：
   - 标题：以 `[SECURITY]` 开头，并附简要描述
   - 详细说明
   - 受影响的文件或章节
   - 潜在影响
   - 建议修复方式

## 漏洞响应流程

### 评估（24 小时内）

1. 我们确认收到报告
2. 我们使用 [CVSS v3.1](https://www.first.org/cvss/v3.1/specification-document) 评估严重级别
3. 我们判断该问题是否在范围内
4. 我们将初步评估结果反馈给你

### 开发（1-7 天）

1. 我们制定修复方案
2. 我们审查并测试修复
3. 我们创建安全公告
4. 我们准备发布说明

### 披露（视严重级别而定）

**Critical（CVSS 9.0-10.0）**
- 立即发布修复
- 发布公开安全公告
- 向报告者提前 24 小时通知

**High（CVSS 7.0-8.9）**
- 48-72 小时内发布修复
- 向报告者提前 5 天通知
- 在发布时公开公告

**Medium（CVSS 4.0-6.9）**
- 在下一个常规更新中发布修复
- 发布时公开公告

**Low（CVSS 0.1-3.9）**
- 在下一个常规更新中纳入修复
- 发布时附公告

### 公布内容

我们发布的安全公告通常包括：
- 漏洞描述
- 受影响组件
- 严重性评估（CVSS 分数）
- 修复版本
- 临时规避方案（如适用）
- 向报告者致谢（在其允许的前提下）

## 面向报告者的最佳实践

### 报告前

- **验证问题**：你能稳定复现吗？
- **搜索现有问题**：是否已经有人报告过？
- **查看文档**：是否已有安全使用指导？
- **测试修复**：你的修复建议是否有效？

### 报告时

- **具体明确**：提供准确文件路径和行号
- **补充上下文**：为什么这是一个安全问题？
- **说明影响**：攻击者能做什么？
- **提供步骤**：我们如何复现它？
- **附带修复建议**：你会怎么修？

### 报告后

- **保持耐心**：我们的资源有限
- **及时响应**：尽快回答后续问题
- **保持保密**：在修复前不要公开披露
- **尊重协同流程**：遵循我们的披露时间安排

## 安全头与配置

### 仓库安全

- **Branch protection**：主分支变更需要 2 个 approval
- **Status checks**：所有 CI/CD 检查必须通过
- **CODEOWNERS**：关键文件有指定 reviewer
- **Signed commits**：推荐贡献者使用签名提交

### 开发安全

```bash
# 安装 pre-commit hooks
pre-commit install

# 在本地运行安全扫描
bandit -c pyproject.toml -r scripts/
mypy scripts/ --ignore-missing-imports
ruff check scripts/
```

### 依赖安全

```bash
# 检查已知漏洞
pip install safety
safety check

# 或使用 pip-audit
pip install pip-audit
pip-audit
```

## 面向贡献者的安全指南

### 在编写示例时

1. **绝不要硬编码 secrets**
   ```python
   # ❌ Bad
   api_key = "sk-1234567890"

   # ✅ Good
   api_key = os.getenv("API_KEY")
   ```

2. **提醒安全影响**
   ```markdown
   ⚠️ **Security Note**: Never commit `.env` files to git.
   Add to `.gitignore` immediately.
   ```

3. **采用安全默认值**
   - 默认启用认证
   - 在适用场景下使用 HTTPS
   - 校验并清洗输入
   - 使用参数化查询

4. **记录安全注意事项**
   - 解释为什么安全很重要
   - 展示安全与不安全模式的差异
   - 链接到权威资料
   - 将警告清楚地写出来

### 在审查贡献时

1. **检查是否泄露 secrets**
   - 扫描常见模式（`api_key=`、`password=`）
   - 审查配置文件
   - 检查环境变量

2. **验证安全编码实践**
   - 不存在硬编码凭据
   - 正确进行输入校验
   - 认证/授权机制安全
   - 文件处理安全

3. **测试安全影响**
   - 这会不会被滥用？
   - 最坏情况是什么？
   - 是否存在边界情况？

## 安全资源

### 官方标准
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [CVSS Calculator](https://www.first.org/cvss/calculator/3.1)

### Python 安全
- [Python Security Advisories](https://www.python.org/dev/security/)
- [PyPI Security](https://pypi.org/help/#security)
- [Bandit Documentation](https://bandit.readthedocs.io/)

### 依赖管理
- [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/)
- [GitHub Security Alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)

### 通用安全
- [Anthropic Security](https://www.anthropic.com/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)

## 安全公告归档

过往安全公告可在 [GitHub Security Advisories](https://github.com/Layrow/claude-code-guide/security/advisories) 标签页中查看。

## 联系方式

如有安全相关问题，或想讨论安全实践：

1. **私密安全报告**：使用 GitHub 的私密漏洞报告
2. **一般安全问题**：创建带 `[SECURITY]` 标签的讨论
3. **安全策略反馈**：创建带 `security` label 的 issue

## 致谢

感谢所有帮助本项目保持安全的安全研究人员与社区成员。凡是负责任地报告漏洞的贡献者，都会在我们的安全公告中得到致谢（除非他们希望匿名）。

## 策略更新

本安全策略会在以下情况下审查和更新：
- 发现新的漏洞时
- 安全最佳实践演进时
- 项目范围发生变化时
- 至少每年一次

**Last Updated**：2026 年 1 月
**Next Review**：2027 年 1 月

---

感谢你帮助 Claude Code Guide 保持安全！🔒
