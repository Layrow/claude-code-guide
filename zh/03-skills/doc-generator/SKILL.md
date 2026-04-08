---
name: doc-generator
description: 生成结构化、高质量的项目文档。适用于用户想编写 README、API 文档、架构说明、上手指南或维护文档时。
---

# Documentation Generator Skill

该 skill 用于生成清晰、结构化且可维护的项目文档。

## Goals

1. 为目标受众写文档
2. 优先强调可执行性与可读性
3. 保持结构清晰，方便快速扫读
4. 尽量减少重复内容
5. 用示例和文件引用提高可操作性

## Documentation Principles

- 先说明**这是什么**
- 再说明**为什么重要**
- 然后说明**如何使用**
- 适当加入示例、命令和常见问题
- 如果已有文档存在，优先补强和整合，而不是无脑重写

## Recommended Structure

### README
- 项目简介
- 主要特性
- 快速开始
- 常用命令
- 项目结构
- 开发说明

### API Documentation
- 接口概览
- 认证方式
- 请求/响应格式
- 错误处理
- 示例调用

### Architecture Docs
- 系统边界
- 模块职责
- 数据流
- 关键设计决策
- Mermaid 图示

## Output Guidelines

- 使用清晰的标题层级
- 尽量使用短段落和列表
- 给出可以直接复制执行的命令
- 如涉及代码，优先引用文件或给出简短示例
- 保持与当前项目技术栈和术语一致
