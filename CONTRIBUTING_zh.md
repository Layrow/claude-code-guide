<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# 为 Claude How To 做贡献

感谢你愿意为这个项目做贡献！这份指南会帮助你理解如何高效地参与贡献。

## 关于这个项目

Claude How To 是一份面向 Claude Code 的可视化、示例驱动型指南。我们提供：
- **Mermaid 图** 来解释功能如何工作
- **可直接用于生产的模板**，拿来就能用
- **带上下文和最佳实践的真实案例**
- **从入门到高级的渐进式学习路径**

## 贡献类型

### 1. 新示例或模板
为现有功能（slash commands、skills、hooks 等）补充示例：
- 可直接复制粘贴的代码
- 清晰说明其工作原理
- 使用场景与收益
- 故障排查提示

### 2. 文档改进
- 澄清令人困惑的部分
- 修正拼写和语法
- 补充缺失信息
- 改进代码示例

### 3. 功能指南
为新的 Claude Code 特性编写指南：
- 分步骤教程
- 架构图
- 常见模式与反模式
- 真实工作流

### 4. Bug 报告
报告你遇到的问题：
- 说明你原本预期会发生什么
- 说明实际发生了什么
- 提供复现步骤
- 附上相关 Claude Code 版本和操作系统信息

### 5. 反馈与建议
帮助我们改进指南：
- 提出更好的解释方式
- 指出覆盖空白
- 建议新增章节或调整结构

## 开始之前

### 1. Fork 并 Clone
```bash
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto
```

### 2. 创建分支
使用有描述性的分支名：
```bash
git checkout -b add/feature-name
git checkout -b fix/issue-description
git checkout -b docs/improvement-area
```

### 3. 搭建环境

Pre-commit hooks 会在每次提交前在本地运行与 CI 相同的检查。PR 被接受前，所有检查都必须通过。

**必需依赖：**

```bash
# Python 工具链（uv 是本项目的包管理器）
pip install uv
uv venv
source .venv/bin/activate
uv pip install -r scripts/requirements-dev.txt

# Markdown linter（Node.js）
npm install -g markdownlint-cli

# Mermaid 图校验器（Node.js）
npm install -g @mermaid-js/mermaid-cli

# 安装 pre-commit 并启用 hooks
uv pip install pre-commit
pre-commit install
```

**验证你的环境：**

```bash
pre-commit run --all-files
```

每次 commit 时会运行的 hooks 有：

| Hook | What it checks |
|------|---------------|
| `markdown-lint` | Markdown 格式与结构 |
| `cross-references` | 相对链接、锚点、代码围栏 |
| `mermaid-syntax` | 所有 ` ```mermaid ` 代码块都能正确解析 |
| `link-check` | 外部 URL 可访问 |
| `build-epub` | EPUB 能无错误生成（在 `.md` 变更时） |

## 目录结构

```
├── 01-slash-commands/      # 用户触发的快捷命令
├── 02-memory/              # 持久上下文示例
├── 03-skills/              # 可复用能力
├── 04-subagents/           # 专用 AI 助手
├── 05-mcp/                 # Model Context Protocol 示例
├── 06-hooks/               # 事件驱动自动化
├── 07-plugins/             # 打包式功能
├── 08-checkpoints/         # 会话快照
├── 09-advanced-features/   # 规划、思考、后台任务等
├── 10-cli/                 # CLI 参考
├── scripts/                # 构建与工具脚本
└── README.md               # 主指南
```

## 如何贡献示例

### 添加一个 Slash Command
1. 在 `01-slash-commands/` 中创建一个 `.md` 文件
2. 内容应包含：
   - 清楚说明它做什么
   - 使用场景
   - 安装说明
   - 使用示例
   - 自定义提示
3. 更新 `01-slash-commands/README.md`

### 添加一个 Skill
1. 在 `03-skills/` 中创建一个目录
2. 内容应包含：
   - `SKILL.md` - 主文档
   - `scripts/` - 如有需要的辅助脚本
   - `templates/` - Prompt 模板
   - README 中的使用示例
3. 更新 `03-skills/README.md`

### 添加一个 Subagent
1. 在 `04-subagents/` 中创建一个 `.md` 文件
2. 内容应包含：
   - Agent 的用途与能力
   - System prompt 结构
   - 使用场景示例
   - 集成示例
3. 更新 `04-subagents/README.md`

### 添加 MCP 配置
1. 在 `05-mcp/` 中创建一个 `.json` 文件
2. 内容应包含：
   - 配置说明
   - 必需的环境变量
   - 配置步骤
   - 使用示例
3. 更新 `05-mcp/README.md`

### 添加一个 Hook
1. 在 `06-hooks/` 中创建一个 `.sh` 文件
2. 内容应包含：
   - Shebang 和说明
   - 解释逻辑的清晰注释
   - 错误处理
   - 安全注意事项
3. 更新 `06-hooks/README.md`

## 编写规范

### Markdown 风格
- 使用清晰标题（H2 作为章节，H3 作为子章节）
- 段落保持简短、聚焦
- 列表使用项目符号
- 代码块必须标明语言
- 章节之间留空行

### 代码示例
- 示例要可直接复制粘贴
- 对不明显的逻辑加注释
- 同时提供简单版和进阶版
- 展示真实使用场景
- 提醒潜在问题

### 文档
- 解释“为什么”，不只是“是什么”
- 说明前置条件
- 增加故障排查部分
- 链接到相关主题
- 保持对初学者友好

### JSON/YAML
- 使用正确缩进（统一保持 2 或 4 个空格）
- 加注释解释配置
- 提供校验示例

### 图表
- 尽可能使用 Mermaid
- 保持图表简单且易读
- 在图下补充说明
- 链接到相关章节

## 提交规范

遵循 conventional commit 格式：
```
type(scope): description

[optional body]
```

类型包括：
- `feat`: 新功能或新示例
- `fix`: Bug 修复或纠正
- `docs`: 文档改动
- `refactor`: 代码重构
- `style`: 格式调整
- `test`: 测试新增或修改
- `chore`: 构建、依赖等

示例：
```
feat(slash-commands): Add API documentation generator
docs(memory): Improve personal preferences example
fix(README): Correct table of contents link
docs(skills): Add comprehensive code review skill
```

## 提交前

### 检查清单
- [ ] 代码符合项目风格与约定
- [ ] 新示例附带清晰文档
- [ ] README 已更新（局部目录和根目录）
- [ ] 不包含敏感信息（API key、凭据等）
- [ ] 示例已测试可用
- [ ] 链接已验证无误
- [ ] 文件权限正确（脚本应可执行）
- [ ] Commit message 清晰且有描述性

### 本地测试
```bash
# 运行全部 pre-commit 检查（与 CI 相同）
pre-commit run --all-files

# 检查你的改动
git diff
```

## Pull Request 流程

1. **创建带清晰说明的 PR**：
   - 这次提交新增/修复了什么？
   - 为什么需要它？
   - 是否关联 issue？

2. **补充相关细节**：
   - 新功能？请附带使用场景
   - 文档改动？请解释改进点
   - 示例改动？请说明前后变化

3. **关联 issue**：
   - 使用 `Closes #123` 可自动关闭关联 issue

4. **耐心等待 review**：
   - 维护者可能会建议你继续改进
   - 根据反馈迭代
   - 最终决定由维护者做出

## Code Review 流程

Reviewers 会重点检查：
- **Accuracy**：内容是否如描述那样工作？
- **Quality**：是否达到可用于生产的质量？
- **Consistency**：是否遵循项目现有模式？
- **Documentation**：是否清晰且完整？
- **Security**：是否存在安全风险？

## 问题反馈

### Bug 报告
请包含：
- Claude Code 版本
- 操作系统
- 复现步骤
- 预期行为
- 实际行为
- 如适用可附截图

### 功能请求
请包含：
- 正在解决的场景或问题
- 你建议的解决方案
- 你考虑过的替代方案
- 其他补充上下文

### 文档问题
请包含：
- 哪些地方令人困惑或存在缺失
- 你建议的改进方式
- 示例或参考资料

## 项目策略

### 敏感信息
- 不要提交 API key、token 或凭据
- 示例中使用占位值
- 为配置文件提供 `.env.example`
- 说明必需的环境变量

### 代码质量
- 保持示例聚焦且易读
- 避免过度设计
- 对不明显逻辑添加注释
- 提交前充分测试

### 知识产权
- 原创内容归作者所有
- 项目使用教育用途许可
- 尊重现有版权
- 如有需要请提供署名

## 获取帮助

- **Questions**：在 GitHub Issues 中发起讨论
- **General Help**：先查看现有文档
- **Development Help**：参考类似示例
- **Code Review**：在 PR 中 @ 维护者

## 贡献者认可

贡献者会在以下位置得到认可：
- README.md 的贡献者部分
- GitHub contributors 页面
- Commit history

## 安全

在贡献示例和文档时，请遵循安全编码实践：

- **永远不要硬编码 secrets 或 API keys** - 使用环境变量
- **提醒安全影响** - 明确指出潜在风险
- **采用安全默认值** - 默认启用安全特性
- **验证输入** - 展示正确的输入校验和清洗方式
- **加入安全说明** - 记录安全注意事项

关于安全问题，请查看 [SECURITY.md](SECURITY.md) 了解我们的漏洞报告流程。

## 行为准则

我们致力于建设一个友好且包容的社区。请阅读 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) 了解完整社区标准。

简而言之：
- 保持尊重与包容
- 平和地接受反馈
- 帮助他人学习和成长
- 避免骚扰或歧视
- 将问题反馈给维护者

所有贡献者都应遵守这一准则，并以善意和尊重对待彼此。

## 许可证

当你向本项目提交贡献时，即表示你同意你的贡献将基于 MIT License 授权。详情见 [LICENSE](LICENSE)。

## 还有问题？

- 查看 [README](README.md)
- 阅读 [LEARNING-ROADMAP.md](LEARNING-ROADMAP.md)
- 参考现有示例
- 发起 issue 讨论

感谢你的贡献！🙏
