# 快速开始 - 品牌资源

## 把资源复制到你的项目里

```bash
# 把全部 resources 复制到你的 Web 项目
cp -r resources/ /path/to/your/website/

# 或者只复制 Web 所需的 favicons
cp resources/favicons/* /path/to/your/website/public/
```

## 添加到 HTML（可直接复制粘贴）

```html
<!-- Favicons -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg" sizes="32x32">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">
<link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">
<meta name="theme-color" content="#000000">
```

## 在 Markdown / 文档中使用

```markdown
# Claude Code Guide

![Claude Code Guide Logo](logos/claude-code-guide-logo.svg)

![Icon](icons/claude-code-guide-icon.svg)
```

## 推荐尺寸

| Purpose | Size | File |
|---------|------|------|
| 网站头部 | 520×120 | `logos/claude-code-guide-logo.svg` |
| 应用图标 | 256×256 | `icons/claude-code-guide-icon.svg` |
| 浏览器标签页 | 32×32 | `favicons/favicon-32.svg` |
| 手机主屏图标 | 128×128 | `favicons/favicon-128.svg` |
| 桌面应用 | 256×256 | `favicons/favicon-256.svg` |
| 小头像 | 64×64 | `favicons/favicon-64.svg` |

## 颜色值

```css
/* 把这些值用到你的 CSS 中 */
--color-primary: #000000;
--color-secondary: #6B7280;
--color-accent: #22C55E;
--color-bg-light: #FFFFFF;
--color-bg-dark: #0A0A0A;
```

## 图标设计含义

**带代码括号的指南针：**
- Compass ring = 导航、结构化学习路径
- Green north needle = 方向、进展、引导
- Black south needle = 落地感、扎实基础
- `>` bracket = 终端提示符、代码、CLI 语境
- Tick marks = 精准、结构化步骤

它所表达的含义是：**“在清晰引导下，找到你穿越代码世界的路径。”**

## 什么场景该用什么

### Website
- **Header**：Logo（`logos/claude-code-guide-logo.svg`）
- **Favicon**：32px（`favicons/favicon-32.svg`）
- **Social preview**：Icon（`icons/claude-code-guide-icon.svg`）

### GitHub
- **README badge**：64-128px 的 Icon（`icons/claude-code-guide-icon.svg`）
- **Repository avatar**：Icon（`icons/claude-code-guide-icon.svg`）

### Social Media
- **Profile picture**：Icon（`icons/claude-code-guide-icon.svg`）
- **Banner**：Logo（`logos/claude-code-guide-logo.svg`）
- **Thumbnail**：256×256px 的 Icon

### Documentation
- **Chapter headers**：Logo 或 Icon（按版面缩放）
- **Navigation icons**：Favicon（32-64px）

---

详见 [README.md](README.md) 获取完整文档。
