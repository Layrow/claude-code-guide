---
name: Documentation Refactor
description: 为了更清晰、更易访问地使用，重构项目文档结构
tags: documentation, refactoring, organization
---

# Documentation Refactor

根据项目类型，对项目文档结构进行重构：

1. **分析项目**：识别项目类型（库/API/Web 应用/CLI/微服务）、架构以及目标用户画像
2. **集中管理文档**：将技术文档迁移到 `docs/` 中，并建立清晰的交叉引用
3. **整理根目录 README.md**：将其精简为入口页，包含概览、快速开始、模块/组件摘要、许可证和联系方式
4. **补充组件文档**：为模块、包或服务补充 README，包含安装与测试说明
5. **按合适的类别组织 `docs/`**：
   - 架构、API Reference、数据库、设计、故障排查、部署、贡献指南（按项目实际需要调整）
6. **编写指南文档**（按需选择）：
   - User Guide：面向最终用户的应用使用文档
   - API Documentation：面向 API 的接口、认证和示例说明
   - Development Guide：开发环境搭建、测试和贡献流程
   - Deployment Guide：服务或应用的生产部署指南
7. **统一使用 Mermaid** 绘制所有图表（架构图、流程图、结构图）

文档要保持简洁、易扫读，并贴合项目类型提供上下文。
