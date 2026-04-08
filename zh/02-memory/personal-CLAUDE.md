# 我的开发偏好

## 关于我
- **经验水平**：8 年全栈开发经验
- **偏好语言**：TypeScript、Python
- **沟通风格**：直接，并配合示例
- **学习方式**：喜欢带代码的可视化图解

## 代码偏好

### 错误处理
我偏好使用 try-catch 进行显式错误处理，并提供有意义的错误信息。
避免泛化错误。所有错误都应记录日志，便于调试。

### 注释
注释要解释 WHY，而不是 WHAT。代码本身应该尽量自解释。
注释应该聚焦业务逻辑或不明显的设计决策。

### 测试
我偏好 TDD（测试驱动开发）。
先写测试，再写实现。
关注行为，而不是实现细节。

### 架构
我偏好模块化、低耦合的设计。
为了提升可测试性，优先使用依赖注入。
清晰分离职责（Controllers、Services、Repositories）。

## 调试偏好
- 使用带前缀的 console.log：`[DEBUG]`
- 日志要带上上下文：函数名、相关变量
- 有条件时输出 stack trace
- 日志里始终包含时间戳

## 沟通方式
- 用图来解释复杂概念
- 先给具体示例，再讲原理
- 提供 before/after 代码片段
- 在结尾总结关键点

## 项目组织
我通常把项目组织成这样：
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

## 工具链
- **IDE**：VS Code，配合 vim keybindings
- **Terminal**：Zsh with Oh-My-Zsh
- **Format**：Prettier（100 字符行宽）
- **Linter**：ESLint（airbnb 配置）
- **Test Framework**：Jest + React Testing Library
