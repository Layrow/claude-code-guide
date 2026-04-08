---
name: Expand Unit Tests
description: 通过补齐未覆盖分支和边界情况来提升测试覆盖率
tags: testing, coverage, unit-tests
---

# Expand Unit Tests

结合项目当前的测试框架，扩展现有单元测试：

1. **分析覆盖率**：运行 coverage report，找出未覆盖分支、边界情况和低覆盖区域
2. **识别缺口**：检查代码中的逻辑分支、错误路径、边界条件、null/空输入
3. **使用项目现有框架编写测试**：
   - Jest/Vitest/Mocha（JavaScript/TypeScript）
   - pytest/unittest（Python）
   - Go testing/testify（Go）
   - Rust test framework（Rust）
4. **重点覆盖特定场景**：
   - 错误处理和异常
   - 边界值（最小值/最大值、空、null）
   - 边缘情况和角落案例
   - 状态迁移与副作用
5. **验证提升效果**：再次运行 coverage，确认覆盖率有可量化的提升

只输出新增测试代码块。遵循项目现有的测试模式和命名约定。
