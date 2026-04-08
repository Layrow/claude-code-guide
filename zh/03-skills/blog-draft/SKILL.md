---
name: blog-draft
description: 根据想法和资料起草博客文章。适用于用户想写博客、基于研究资料产出内容，或起草文章时。引导完成调研、头脑风暴、大纲设计以及带版本控制的迭代写作流程。
---

## User Input

```text
$ARGUMENTS
```

在继续之前，你**必须**先考虑用户输入。用户应尽量提供：
- **Idea/Topic**：博客文章的核心主题
- **Resources**：URL、文件或研究资料引用（可选但强烈建议）
- **Target audience**：目标读者（可选）
- **Tone/Style**：正式、轻松、技术向等写作风格（可选）

**IMPORTANT**：如果用户要求更新一篇**已有博客文章**，请跳过步骤 0-8，直接从 **Step 9** 开始。先读取现有草稿文件，再进入迭代流程。

## Execution Flow

按顺序执行以下步骤。**不要跳步，也不要在需要用户确认时绕过确认直接继续。**

### Step 0: Create Project Folder

1. 用以下格式生成文件夹名：`YYYY-MM-DD-short-topic-name`
   - 使用当天日期
   - 根据主题生成简短、适合 URL 的 slug（小写、用连字符连接、最多 5 个词）

2. 创建目录结构：
   ```
   blog-posts/
   └── YYYY-MM-DD-short-topic-name/
       └── resources/
   ```

3. 在继续之前，先向用户确认目录已创建。

### Step 1: Research & Resource Collection

1. 在博客目录下创建 `resources/` 子目录

2. 对每个提供的资源：
   - **URLs**：抓取并保存关键信息到 `resources/`，格式为 markdown
   - **Files**：读取并在 `resources/` 中生成摘要
   - **Topics**：通过 web search 收集最新信息

3. 为每个资源创建一个摘要文件：
   - `resources/source-1-[short-name].md`
   - `resources/source-2-[short-name].md`
   - 等等

4. 每个摘要应包含：
   ```markdown
   # Source: [Title/URL]

   ## Key Points
   - Point 1
   - Point 2

   ## Relevant Quotes/Data
   - Quote or statistic 1
   - Quote or statistic 2

   ## How This Relates to Topic
   Brief explanation of relevance
   ```

5. 向用户展示调研摘要。

### Step 2: Brainstorm & Clarify

1. 根据主题和调研资料，向用户展示：
   - 从研究中识别出的**主要主题**
   - 博客可采用的**潜在切入角度**
   - 应覆盖的**关键点**
   - 还需要澄清的**信息缺口**

2. 提出澄清问题：
   - 你最希望读者带走的核心结论是什么？
   - 调研资料中有没有特别想强调的点？
   - 目标篇幅是多少？（短：500-800 字，中：1000-1500，长：2000+）
   - 有哪些你明确不想写进去的内容？

3. **等待用户回复后再继续。**

### Step 3: Propose Outline

1. 创建结构化大纲，包括：

   ```markdown
   # Blog Post Outline: [Title]

   ## Meta Information
   - **Target Audience**: [who]
   - **Tone**: [style]
   - **Target Length**: [word count]
   - **Main Takeaway**: [key message]

   ## Proposed Structure

   ### Hook/Introduction
   - Opening hook idea
   - Context setting
   - Thesis statement

   ### Section 1: [Title]
   - Key point A
   - Key point B
   - Supporting evidence from [source]

   ### Section 2: [Title]
   - Key point A
   - Key point B

   [Continue for all sections...]

   ### Conclusion
   - Summary of key points
   - Call to action or final thought

   ## Sources to Cite
   - Source 1
   - Source 2
   ```

2. 将大纲展示给用户，并**请求确认或修改意见**。

### Step 4: Save Approved Outline

1. 用户确认大纲后，将其保存到博客目录下的 `OUTLINE.md`

2. 确认大纲已保存。

### Step 5: Commit Outline (if in git repo)

1. 检查当前目录是否为 git 仓库

2. 如果是：
   - 暂存新增文件：博客目录、resources 和 `OUTLINE.md`
   - 创建 commit，消息为：`docs: Add outline for blog post - [topic-name]`
   - 推送到远端

3. 如果不是 git 仓库，则跳过此步骤并告知用户。

### Step 6: Write Draft

1. 根据已确认的大纲撰写完整博客草稿

2. 严格按照 `OUTLINE.md` 中的结构来写

3. 内容中应包含：
   - 有吸引力的开篇 hook
   - 清晰的小节标题
   - 来自研究资料的证据和示例
   - 小节之间顺畅的过渡
   - 有明确结论的收尾
   - **Citations**：所有对比、统计数据、事实性陈述都**必须**标注原始来源

4. 将草稿保存为博客目录下的 `draft-v0.1.md`

5. 格式：
   ```markdown
   # [Blog Post Title]

   *[Optional: subtitle or tagline]*

   [Full content with inline citations...]

   ---

   ## References
   - [1] Source 1 Title - URL or Citation
   - [2] Source 2 Title - URL or Citation
   - [3] Source 3 Title - URL or Citation
   ```

6. **Citation Requirements**：
   - 所有数据点、统计数字、比较结论都**必须**带行内引用
   - 可使用编号引用 `[1]`、`[2]`，或命名引用 `[Source Name]`
   - 引用要能对应到文末 References 部分
   - 示例："Studies show that 65% of developers prefer TypeScript [1]"
   - 示例："React outperforms Vue in rendering speed by 20% [React Benchmarks 2024]"

### Step 7: Commit Draft (if in git repo)

1. 检查当前是否在 git 仓库中

2. 如果是：
   - 暂存草稿文件
   - 创建 commit，消息为：`docs: Add draft v0.1 for blog post - [topic-name]`
   - 推送到远端

3. 如果不是 git 仓库，则跳过并告知用户。

### Step 8: Present Draft for Review

1. 将草稿内容展示给用户

2. 询问反馈：
   - 整体感觉如何？
   - 哪些部分需要扩写或删减？
   - 语气风格是否需要调整？
   - 是否有遗漏的信息？
   - 是否有具体句子或段落需要重写？

3. **等待用户回复。**

### Step 9: Iterate or Finalize

**如果用户要求修改：**
1. 记录所有修改要求
2. 回到 Step 6，并做以下调整：
   - 递增版本号（v0.2、v0.3 等）
   - 纳入所有反馈
   - 保存为 `draft-v[X.Y].md`
   - 重复执行 Steps 7-8

**如果用户确认通过：**
1. 确认最终草稿版本
2. 如用户要求，可将其重命名为 `final.md`
3. 总结博客创作过程：
   - 一共生成了多少版本
   - 各版本间的关键修改
   - 最终字数
   - 创建了哪些文件

## Version Tracking

所有草稿都通过递增版本号保留：
- `draft-v0.1.md` - 初始草稿
- `draft-v0.2.md` - 第一轮反馈后的版本
- `draft-v0.3.md` - 第二轮反馈后的版本
- 等等

这样可以跟踪博客内容的演进过程，也方便在需要时回退。

## Output Files Structure

```
blog-posts/
└── YYYY-MM-DD-topic-name/
    ├── resources/
    │   ├── source-1-name.md
    │   ├── source-2-name.md
    │   └── ...
    ├── OUTLINE.md
    ├── draft-v0.1.md
    ├── draft-v0.2.md (if iterations)
    └── draft-v0.3.md (if more iterations)
```

## Tips for Quality

- **Hook**：用问题、意外事实或读者熟悉的场景开头
- **Flow**：每一段都应顺畅连接到下一段
- **Evidence**：用研究中的数据支撑论点
- **Citations**：以下内容**始终必须引用来源**：
  - 所有统计数据和数据点（例如 "According to [Source], 75% of..."）
  - 产品、服务或方案之间的比较（例如 "X performs 2x faster than Y [Source]"）
