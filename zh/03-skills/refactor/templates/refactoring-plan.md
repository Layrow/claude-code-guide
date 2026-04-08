# Refactoring Plan Template

使用此模板来记录并跟踪你的重构工作。

---

## Project Information

| Field | Value |
|-------|-------|
| **Project/Module** | [项目名] |
| **Target Files** | [待重构文件列表] |
| **Date Created** | [日期] |
| **Author** | [姓名] |
| **Status** | Draft / In Review / Approved / In Progress / Completed |

---

## Executive Summary

### Goals
- [ ] [主要目标，例如：提升 payment processing 的可读性]
- [ ] [次要目标，例如：减少重复代码]
- [ ] [补充目标，例如：提升可测试性]

### Constraints
- [ ] [约束 1，例如：不能修改公共 API]
- [ ] [约束 2，例如：必须保持向后兼容]
- [ ] [约束 3，例如：不能修改数据库 schema]

### Risk Level
- [ ] Low - 改动小，代码测试完善
- [ ] Medium - 改动中等，存在一定风险
- [ ] High - 改动较大，需要特别谨慎

---

## Pre-Refactoring Checklist

### Test Coverage Assessment

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Unit Test Coverage | __%  | ≥80% | |
| Integration Tests | Yes/No | Yes | |
| All Tests Passing | Yes/No | Yes | |

### Required Before Starting
- [ ] 所有测试都通过
- [ ] 已读懂并理解代码
- [ ] 已做好备份或版本控制
- [ ] 已获得用户批准

---

## Identified Code Smells

### Summary

| # | Smell | Location | Severity | Priority |
|---|-------|----------|----------|----------|
| 1 | [例如：Long Method] | [file:line] | High | P1 |
| 2 | [例如：Duplicate Code] | [file:line] | Medium | P2 |
| 3 | [例如：Feature Envy] | [file:line] | Low | P3 |

### Detailed Analysis

#### Smell #1: [Name]

**Location**: `path/to/file.js:45-120`

**Description**: [对问题的详细说明]

**Impact**:
- [影响 1]
- [影响 2]

**Proposed Solution**: [简要说明修复思路]

---

## Refactoring Phases

### Phase A: Quick Wins (Low Risk)

**Objective**: 以低风险方式先拿下能快速见效的改进

**Estimated Changes**: [X files, Y methods]

**User Approval Required**: Yes / No

| # | Task | File | Refactoring | Status |
|---|------|------|-------------|--------|
| A1 | 将变量 `x` 重命名为 `userCount` | utils.js:15 | Rename Variable | [ ] |
| A2 | 删除未使用的 `oldHandler()` | api.js:89 | Remove Dead Code | [ ] |
| A3 | 抽取重复校验逻辑 | form.js:23,67 | Extract Method | [ ] |

**Rollback Plan**: 回退 A1-A3 对应 commit

---

### Phase B: Structural Improvements (Medium Risk)

**Objective**: 提升代码组织结构和清晰度

**Estimated Changes**: [X files, Y methods]

**User Approval Required**: Yes

**Dependencies**: 必须先完成 Phase A

| # | Task | File | Refactoring | Status |
|---|------|------|-------------|--------|
| B1 | 从长函数中抽取 `calculatePrice()` | order.js:45 | Extract Method | [ ] |
| B2 | 引入 `OrderDetails` 参数对象 | order.js:12 | Introduce Parameter Object | [ ] |
| B3 | 将 `formatAddress()` 移动到 Address 类 | customer.js:78 | Move Method | [ ] |

**Rollback Plan**: 回退到 Phase A 结束后的 commit

---

### Phase C: Architectural Changes (Higher Risk)

**Objective**: 处理更深层的结构性问题

**Estimated Changes**: [X files, Y methods]

**User Approval Required**: Yes

**Dependencies**: 必须先完成 Phases A 和 B

| # | Task | File | Refactoring | Status |
|---|------|------|-------------|--------|
| C1 | 用多态替换价格计算中的 switch | pricing.js:30 | Replace Conditional with Polymorphism | [ ] |
| C2 | 抽取 `NotificationService` 类 | user.js:100 | Extract Class | [ ] |

**Rollback Plan**: 回退到 Phase B 结束后的 commit

---

## Detailed Refactoring Steps

### Task [ID]: [Task Name]

**Smell Addressed**: [Smell 名称]

**Refactoring Technique**: [重构技术名称]

**Risk Level**: Low / Medium / High

#### Context

**Before** (Current State):
```javascript
// Paste current code here
```

**After** (Expected State):
```javascript
// Paste expected code here
```

#### Step-by-Step Mechanics

1. [ ] **Step 1**: [Description]
   - Test: 完成这一步后运行测试
   - Expected: 所有测试通过

2. [ ] **Step 2**: [Description]
   - Test: 完成这一步后运行测试
   - Expected: 所有测试通过

3. [ ] **Step 3**: [Description]
   - Test: 完成这一步后运行测试
   - Expected: 所有测试通过

#### Verification

- [ ] 所有测试通过
- [ ] 行为未改变
- [ ] 代码可编译
- [ ] 没有新增 warning

#### Commit Message
```
refactor: [Describe the refactoring]
```

---

## Progress Tracking

### Phase Status

| Phase | Status | Started | Completed | Tests Passing |
|-------|--------|---------|-----------|---------------|
| A | Not Started / In Progress / Done | | | |
| B | Not Started / In Progress / Done | | | |
| C | Not Started / In Progress / Done | | | |

### Issues Encountered

| # | Issue | Resolution | Status |
|---|-------|------------|--------|
| 1 | [Description] | [How resolved] | Open / Resolved |

---

## Metrics Comparison

### Before Refactoring

| Metric | File 1 | File 2 | Total |
|--------|--------|--------|-------|
| Lines of Code | | | |
| Cyclomatic Complexity | | | |
| Maintainability Index | | | |
| Number of Methods | | | |
| Avg Method Length | | | |

### After Refactoring

| Metric | File 1 | File 2 | Total | Change |
|--------|--------|--------|-------|--------|
| Lines of Code | | | | |
| Cyclomatic Complexity | | | | |
| Maintainability Index | | | | |
| Number of Methods | | | | |
| Avg Method Length | | | | |

---

## Post-Refactoring Checklist

- [ ] 所有测试通过
- [ ] 没有新增 warning 或 error
- [ ] 代码编译成功
- [ ] 已完成人工验证
- [ ] 文档已更新（如需要）
- [ ] 已完成代码评审
- [ ] 指标有改善
- [ ] 已获得用户签字确认

---

## Lessons Learned

### What Went Well
- [Item 1]
- [Item 2]

### What Could Be Improved
- [Item 1]
- [Item 2]

### Recommendations for Future
- [Item 1]
- [Item 2]

---
