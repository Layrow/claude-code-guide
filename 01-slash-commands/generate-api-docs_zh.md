---
description: 根据源代码生成完整的 API 文档
---

# API Documentation Generator

按以下方式生成 API 文档：

1. 扫描 `/src/api/` 下的所有文件
2. 提取函数签名和 JSDoc 注释
3. 按 endpoint 或模块组织内容
4. 生成带示例的 Markdown 文档
5. 包含请求/响应 schema
6. 补充错误处理文档

输出格式：
- 在 `/docs/api.md` 中生成 Markdown 文件
- 为所有 endpoint 提供 curl 示例
- 补充 TypeScript 类型
