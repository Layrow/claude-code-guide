---
name: code-review-specialist
description: 提供包含安全、性能和质量分析的完整代码评审。适用于用户要求 review 代码、分析代码质量、评估 pull request，或提到 code review、安全分析、性能优化时。
---

# Code Review Skill

这个 skill 提供完整的代码评审能力，重点关注：

1. **Security Analysis**
   - 认证与授权问题
   - 数据暴露风险
   - 注入类漏洞
   - 密码学弱点
   - 敏感数据日志泄露

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
   - 可读性
   - 函数长度（应少于 50 行）
   - 圈复杂度
   - 依赖管理
   - 类型安全

## Review Template

对于每一段被评审的代码，请提供：

### Summary
- 整体质量评分（1-5）
- 关键发现数量
- 建议优先处理的领域

### Critical Issues (if any)
- **Issue**：问题描述清楚明确
- **Location**：文件和行号
- **Impact**：说明为什么重要
- **Severity**：Critical/High/Medium
- **Fix**：给出代码示例

### Findings by Category

#### Security (if issues found)
列出安全漏洞，并附带示例

#### Performance (if issues found)
列出性能问题，并给出复杂度分析

#### Quality (if issues found)
列出代码质量问题，并给出重构建议

#### Maintainability (if issues found)
列出可维护性问题，并给出改进方向

## Version History

- v1.0.0 (2024-12-10): 初始版本，涵盖安全、性能、质量和可维护性分析
