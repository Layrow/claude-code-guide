---
name: code-refactor
description: 基于 Martin Fowler 方法论的系统化代码重构。适用于用户要求重构代码、改善代码结构、降低技术债、清理遗留代码、消除 code smells 或提升可维护性时。该 skill 采用分阶段流程，包含调研、规划和安全的渐进式实现。
---

# Code Refactoring Skill

一种基于 Martin Fowler《*Refactoring: Improving the Design of Existing Code*（第 2 版）》的系统化代码重构方法。该 skill 强调：以测试为保障，进行安全、渐进的小步修改。

> "Refactoring is the process of changing a software system in such a way that it does not alter the external behavior of the code yet improves its internal structure." — Martin Fowler

## Core Principles

1. **Behavior Preservation**：外部行为必须保持不变
2. **Small Steps**：每次只做细小、可测试的改动
3. **Test-Driven**：测试是安全网
4. **Continuous**：重构是持续行为，而不是一次性事件
5. **Collaborative**：每个阶段都需要用户确认

## Workflow Overview

```
Phase 1: Research & Analysis
    ↓
Phase 2: Test Coverage Assessment
    ↓
Phase 3: Code Smell Identification
    ↓
Phase 4: Refactoring Plan Creation
    ↓
Phase 5: Incremental Implementation
    ↓
Phase 6: Review & Iteration
```

---

## Phase 1: Research & Analysis

### Objectives
- 理解代码结构和业务目的
- 确定重构范围
- 收集业务需求相关背景

### Questions to Ask User
开始前，先澄清：

1. **Scope**：哪些文件/模块/函数需要重构？
2. **Goals**：你要解决什么问题？（可读性、性能、可维护性）
3. **Constraints**：有没有明确**不能动**的部分？
4. **Timeline pressure**：这件事是否在阻塞其他工作？
5. **Test status**：是否已有测试？当前是否通过？

### Actions
- [ ] 读取并理解目标代码
- [ ] 识别依赖与集成点
- [ ] 记录当前架构
- [ ] 标记已有技术债迹象（TODO、FIXME）

### Output
向用户展示：
- 代码结构概览
- 已识别的问题区域
- 初步建议
- **请求批准继续**

---

## Phase 2: Test Coverage Assessment

### Why Tests Matter
> "Refactoring without tests is like driving without a seatbelt." — Martin Fowler

测试是安全重构的**关键前提**。没有测试，你很容易在改结构时带来回归缺陷。

### Assessment Steps

1. **检查是否已有测试**
   ```bash
   # Look for test files
   find . -name "*test*" -o -name "*spec*" | head -20
   ```

2. **运行现有测试**
   ```bash
   # JavaScript/TypeScript
   npm test

   # Python
   pytest -v

   # Java
   mvn test
   ```

3. **检查覆盖率（如果有）**
   ```bash
   # JavaScript
   npm run test:coverage

   # Python
   pytest --cov=.
   ```

### Decision Point: Ask User

**If tests exist and pass:**
- 进入 Phase 3

**If tests are missing or incomplete:**
给用户三个选项：
1. 先补测试（推荐）
2. 在重构过程中逐步补测试
3. 无测试直接继续（有风险，需要用户明确知情）

**If tests are failing:**
- **停止**
- 先修复失败测试，再继续重构
- 询问用户：是否先修测试？

### Test Writing Guidelines (if needed)

对于每个准备重构的函数，测试至少应覆盖：
- Happy path（正常流程）
- Edge cases（空输入、null、边界值）
- Error scenarios（无效输入、异常）

使用 "red-green-refactor" 循环：
1. 先写失败测试（red）
2. 让它通过（green）
3. 再做重构（refactor）

---

## Phase 3: Code Smell Identification

### What Are Code Smells?
Code smells 是代码深层问题的表面症状。它们不一定是 bug，但通常意味着代码设计可以更好。

### Common Code Smells to Check

完整目录见 [references/code-smells.md](references/code-smells.md)。

#### Quick Reference

| Smell | Signs | Impact |
|-------|-------|--------|
| **Long Method** | 方法超过 30-50 行 | 难理解、难测试、难维护 |
| **Duplicated Code** | 多处重复相同逻辑 | 修 bug 要改很多处 |
| **Large Class** | 类承担了太多职责 | 违反单一职责 |
| **Feature Envy** | 方法过度依赖别的类的数据 | 封装性差 |
| **Primitive Obsession** | 过度使用原始类型 | 缺失领域模型 |
| **Long Parameter List** | 方法参数 4 个以上 | 调用成本高，容易出错 |
| **Data Clumps** | 一组数据总是一起出现 | 暗示缺少抽象 |
| **Switch Statements** | 复杂 switch/if-else 链 | 难扩展 |
| **Speculative Generality** | “以防万一”写的代码 | 引入不必要复杂度 |
| **Dead Code** | 未使用代码 | 制造混乱，增加维护成本 |

### Analysis Steps

1. **Automated Analysis**（如果有脚本）
   ```bash
   python scripts/detect-smells.py <file>
   ```

2. **Manual Review**
   - 系统性走读代码
   - 记录每个 smell 的位置和严重级别
   - 按影响程度分类（Critical/High/Medium/Low）

3. **Prioritization**
   优先关注那些：
   - 阻塞当前开发
   - 容易导致 bug 或理解混乱
   - 出现在高频修改路径上的问题

### Output: Smell Report

向用户展示：
- 已识别的 smell 列表和位置
- 每个问题的严重级别
- 建议的优先处理顺序
- **请求用户确认优先级**

---

## Phase 4: Refactoring Plan Creation

### Selecting Refactorings

针对每种 smell，从 catalog 中选择合适的重构手法。

完整清单见 [references/refactoring-catalog.md](references/refactoring-catalog.md)。

#### Smell-to-Refactoring Mapping

| Code Smell | Recommended Refactoring(s) |
|------------|---------------------------|
| Long Method | Extract Method, Replace Temp with Query |
| Duplicated Code | Extract Method, Pull Up Method, Form Template Method |
| Large Class | Extract Class, Extract Subclass |
| Feature Envy | Move Method, Move Field |
| Primitive Obsession | Replace Primitive with Object, Replace Type Code with Class |
| Long Parameter List | Introduce Parameter Object, Preserve Whole Object |
| Data Clumps | Extract Class, Introduce Parameter Object |
| Switch Statements | Replace Conditional with Polymorphism |
| Speculative Generality | Collapse Hierarchy, Inline Class, Remove Dead Code |
| Dead Code | Remove Dead Code |

### Plan Structure

使用 [templates/refactoring-plan.md](templates/refactoring-plan.md) 中的模板。

每项重构都要明确：
1. **Target**：要改哪段代码
2. **Smell**：它解决的是什么问题
3. **Refactoring**：采用什么重构技术
4. **Steps**：细到可执行的微步骤
5. **Risks**：可能出什么问题
6. **Rollback**：如果出问题怎么回退

### Phased Approach

**CRITICAL**：重构必须按阶段逐步推进。

**Phase A: Quick Wins**（低风险，高收益）
- 重命名变量提高清晰度
- 抽取明显的重复代码
- 删除死代码

**Phase B: Structural Improvements**（中等风险）
- 从长函数中抽取方法
- 引入参数对象
- 把方法移动到更合适的类中

**Phase C: Architectural Changes**（更高风险）
- 用多态替换条件分支
- 抽取类
- 引入设计模式

### Decision Point: Present Plan to User

在真正动手实现之前：
- 展示完整的重构计划
- 解释各阶段及其风险
- 获取每个阶段的明确批准
- **询问**："Should I proceed with Phase A?"

---

## Phase 5: Incremental Implementation

### The Golden Rule
> "Change → Test → Green? → Commit → Next step"

### Implementation Rhythm

对每一步重构：

1. **Pre-check**
   - 测试通过（green）
   - 代码可以编译

2. **Make ONE small change**
   - 按 catalog 中的 mechanics 执行
   - 改动尽可能小

3. **Verify**
   - 立刻运行测试
   - 检查是否有编译错误

4. **If tests pass (green)**
   - 使用清晰 commit message 提交
   - 进入下一步

5. **If tests fail (red)**
   - **立刻停止**
   - 回退这一步改动
   - 分析问题原因
   - 如果不明确，及时问用户

### Commit Strategy

每个 commit 都应满足：
- **Atomic**：只表达一个逻辑变更
- **Reversible**：容易回滚
- **Descriptive**：commit message 清晰明确

示例 commit message：
```
refactor: Extract calculateTotal() from processOrder()
refactor: Rename 'x' to 'customerCount' for clarity
refactor: Remove unused validateOldFormat() method
```

### Progress Reporting

每完成一个子阶段，就向用户汇报：
- 改了什么
- 测试是否仍然通过
- 是否遇到问题
- **询问**："Continue with next batch?"

---

## Phase 6: Review & Iteration

### Post-Refactoring Checklist

- [ ] 所有测试通过
- [ ] 没有新增 warning 或 error
- [ ] 代码编译成功
- [ ] 外部行为未变（人工验证）
- [ ] 如有需要，文档已更新
- [ ] commit 历史干净清晰

### Metrics Comparison

重构前后运行复杂度分析：
```bash
python scripts/analyze-complexity.py <file>
```

向用户展示改进结果：
- 代码行数变化
- 圈复杂度变化
- 可维护性指数变化

### User Review

向用户展示最终结果：
- 改动总结
- before/after 对比
- 指标改进
- 仍然存在的技术债
- **询问**："Are you satisfied with these changes?"

### Next Steps

与用户讨论：
- 还有没有其他 smell 要处理？
- 是否安排后续重构？
- 是否把类似改动推广到其他地方？

---

## Important Guidelines

### When to STOP and Ask

出现以下情况时，一定暂停并询问用户：
- 不确定业务逻辑
- 变更可能影响外部 API
- 测试覆盖不足
- 需要做重大架构决策
- 风险级别明显上升
- 遇到超出预期的复杂性

### Safety Rules

1. **没有测试就不要重构**（除非用户明确知情并接受风险）
2. **不要一次改太大** - 一定拆成小步
3. **每次改完都不要跳过测试**
4. **测试失败时不要继续** - 先修复或回滚
5. **不要想当然** - 拿不准就问

### What NOT to Do

- 不要把重构和新功能开发混在一起
- 不要在生产事故期间重构
- 不要重构你还没理解的代码
- 不要过度设计，保持简单
- 不要试图一次性“全改完”

---

## Quick Start Example

### Scenario: Long Method with Duplication

**Before:**
```javascript
function processOrder(order) {
  // 150 lines of code with:
  // - Duplicated validation logic
  // - Inline calculations
  // - Mixed responsibilities
}
```

**Refactoring Steps:**

1. **确认 processOrder() 已有测试**
2. **Extract** 校验逻辑到 `validateOrder()`
3. **Test** - 应通过
4. **Extract** 计算逻辑到 `calculateOrderTotal()`
5. **Test** - 应通过
6. **Extract** 通知逻辑到 `notifyCustomer()`
7. **Test** - 应通过
8. **Review** - 现在 `processOrder()` 只负责组织 3 个清晰函数

**After:**
```javascript
function processOrder(order) {
  validateOrder(order);
  const total = calculateOrderTotal(order);
  notifyCustomer(order, total);
  return { order, total };
}
```

---

## References

- [Code Smells Catalog](references/code-smells.md) - 完整的 code smells 清单
- [Refactoring Catalog](references/refactoring-catalog.md) - 重构技术目录
- [Refactoring Plan Template](templates/refactoring-plan.md) - 重构计划模板

## Scripts

- `scripts/analyze-complexity.py` - 分析代码复杂度指标
- `scripts/detect-smells.py` - 自动检测 code smell

## Version History

- v1.0.0 (2025-01-15): 初始版本，包含 Fowler 方法论、分阶段流程和用户确认节点
