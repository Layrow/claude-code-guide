<picture>
  <source media="(prefers-color-scheme: dark)" srcset="logos/claude-howto-logo-dark.svg">
  <img alt="Claude Code Guide" src="logos/claude-howto-logo.svg">
</picture>

# Claude Code Guide - 品牌资源

这是 Claude Code Guide 项目的完整品牌资源集合，包含 logos、icons 和 favicons。所有素材都使用 V3.0 设计：一个带代码括号符号（`>`）的指南针，代表“在代码世界中的引导式导航”，整体采用黑 / 白 / 灰配色，并以亮绿色（#22C55E）作为强调色。

## 目录结构

```
resources/
├── logos/
│   ├── claude-howto-logo.svg       # 主 Logo - Light mode（520×120px）
│   └── claude-howto-logo-dark.svg  # 主 Logo - Dark mode（520×120px）
├── icons/
│   ├── claude-howto-icon.svg       # 应用图标 - Light mode（256×256px）
│   └── claude-howto-icon-dark.svg  # 应用图标 - Dark mode（256×256px）
└── favicons/
    ├── favicon-16.svg              # Favicon - 16×16px
    ├── favicon-32.svg              # Favicon - 32×32px（主版本）
    ├── favicon-64.svg              # Favicon - 64×64px
    ├── favicon-128.svg             # Favicon - 128×128px
    └── favicon-256.svg             # Favicon - 256×256px
```

`assets/logo/` 中还有额外素材：
```
assets/logo/
├── logo-full.svg       # 图形 + 字标（横向）
├── logo-mark.svg       # 仅指南针图形（120×120px）
├── logo-wordmark.svg   # 仅文字
├── logo-icon.svg       # 应用图标（512×512，圆角）
├── favicon.svg         # 16×16 优化版
├── logo-white.svg      # 适用于深色背景的白色版
└── logo-black.svg      # 黑色单色版
```

## 资源概览

### 设计概念（V3.0）

**带代码括号的指南针** —— 导航与代码的结合：
- **Compass Ring** = 导航、找方向
- **North Needle (Green)** = 方向感、学习路径中的前进
- **South Needle (Black)** = 稳定、扎实基础
- **`>` Bracket** = 终端提示符、代码、CLI 语境
- **Tick Marks** = 精准、结构化学习

### Logos

**文件：**
- `logos/claude-howto-logo.svg`（Light mode）
- `logos/claude-howto-logo-dark.svg`（Dark mode）

**规格：**
- **尺寸：** 520×120 px
- **用途：** 带字标的主 Header / 品牌 Logo
- **使用场景：**
  - 网站头部
  - README 徽章
  - 市场宣传物料
  - 印刷材料
- **格式：** SVG（完全可缩放）
- **模式：** Light（白底）与 Dark（#0A0A0A 背景）

### Icons

**文件：**
- `icons/claude-howto-icon.svg`（Light mode）
- `icons/claude-howto-icon-dark.svg`（Dark mode）

**规格：**
- **尺寸：** 256×256 px
- **用途：** 应用图标、头像、缩略图
- **使用场景：**
  - 应用图标
  - 个人 / 项目头像
  - 社交媒体缩略图
  - 文档标题图
- **格式：** SVG（完全可缩放）
- **模式：** Light（白底）与 Dark（#0A0A0A 背景）

**设计元素：**
- 带主方位与次方位刻度的指南针外环
- 绿色北针（方向 / 引导）
- 黑色南针（基础 / 稳定）
- 中心 `>` 代码括号（终端 / CLI）
- 绿色中心点强调

### Favicons

为 Web 使用优化的多尺寸版本：

| File | Size | DPI | Usage |
|------|------|-----|-------|
| `favicon-16.svg` | 16×16 px | 1x | 浏览器标签页（旧浏览器） |
| `favicon-32.svg` | 32×32 px | 1x | 标准浏览器 favicon |
| `favicon-64.svg` | 64×64 px | 1x-2x | 高 DPI 显示器 |
| `favicon-128.svg` | 128×128 px | 2x | Apple touch icon、书签 |
| `favicon-256.svg` | 256×256 px | 4x | 现代浏览器、PWA 图标 |

**优化说明：**
- 16px：最简几何结构 —— 仅保留外环、指针、尖括号
- 32px：加入主方位刻度
- 64px+：显示完整细节，包括次方位刻度
- 全部尺寸都与主图标保持视觉一致
- SVG 格式可确保任意尺寸下都清晰显示

## HTML 集成

### 基础 Favicon 配置

```html
<!-- 浏览器 favicon -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">

<!-- Apple touch icon（移动端主屏图标） -->
<link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">

<!-- PWA 与现代浏览器 -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">
```

### 完整配置

```html
<head>
  <!-- 主 favicon -->
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg" sizes="32x32">
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">

  <!-- Apple touch icon -->
  <link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">

  <!-- PWA 图标 -->
  <link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">

  <!-- Android -->
  <link rel="shortcut icon" href="/resources/favicons/favicon-256.svg">

  <!-- PWA manifest 引用（如果你在使用 manifest.json） -->
  <meta name="theme-color" content="#000000">
</head>
```

## 配色方案

### 主色
- **Black**：`#000000`（主文字、线条、南针）
- **White**：`#FFFFFF`（浅色背景）
- **Gray**：`#6B7280`（次级文字、次要刻度）

### 强调色
- **Bright Green**：`#22C55E`（北针、中心点、强调线 —— 仅用于高亮，绝不作为背景色）

### 深色模式
- **Background**：`#0A0A0A`（接近纯黑）

### CSS Variables
```css
--color-primary: #000000;
--color-secondary: #6B7280;
--color-accent: #22C55E;
--color-bg-light: #FFFFFF;
--color-bg-dark: #0A0A0A;
```

### Tailwind Config
```js
colors: {
  brand: {
    primary: '#000000',
    secondary: '#6B7280',
    accent: '#22C55E',
  }
}
```

### 使用准则
- 黑色用于主要文字和结构元素
- 灰色用于次级 / 辅助元素
- 绿色**只**用于高亮 —— 指针、圆点、强调线
- 绝不要把绿色当背景色使用
- 保持 WCAG AA 对比度（至少 4.5:1）

## 设计准则

### Logo 使用
- 使用在白色或深色（#0A0A0A）背景上
- 按比例缩放
- 保持 Logo 周围留白（至少为 Logo 高度的一半）
- 根据背景选择合适的 light / dark 变体

### Icon 使用
- 推荐使用标准尺寸：16、32、64、128、256px
- 保持指南针比例不变
- 按比例缩放

### Favicon 使用
- 根据场景选择合适尺寸
- 16-32px：浏览器标签页、书签
- 64px：网站图标
- 128px+：Apple / Android 主屏幕

## SVG 优化

所有 SVG 都采用扁平设计，无渐变、无滤镜：
- 干净的线条式几何结构
- 不嵌入位图
- 路径已优化
- 使用响应式 viewBox

用于 Web 优化时：
```bash
# 在保持质量的前提下压缩 SVG
svgo --config='{
  "js2svg": {
    "indent": 2
  },
  "plugins": [
    "convertStyleToAttrs",
    "removeRasterImages"
  ]
}' input.svg -o output.svg
```

## PNG 转换

如果为了兼容旧浏览器，需要把 SVG 转换成 PNG：

```bash
# 使用 ImageMagick
convert -density 300 -background none favicon-256.svg favicon-256.png

# 使用 Inkscape
inkscape -D -z --file=favicon-256.svg --export-png=favicon-256.png
```

## 可访问性

- 高对比度颜色比例（符合 WCAG AA，至少 4.5:1）
- 干净的几何图形，在所有尺寸下都可辨识
- 可缩放的矢量格式
- 图标中不直接放文字（文字在 wordmark 中单独处理）
- 不依赖红绿对比来表达含义

## Attribution

这些资源属于 Claude Code Guide 项目的一部分。

**License**: MIT（见项目中的 LICENSE 文件）

## Version History

- **v3.0**（2026 年 2 月）：带代码括号的指南针设计，采用 Black / White / Gray + Green 强调色
- **v2.0**（2026 年 1 月）：受 Claude 启发的 12 射线星芒设计，采用 emerald 配色
- **v1.0**（2026 年 1 月）：最初的六边形进阶图标设计

---

**Last Updated**: February 2026
**Current Version**: 3.0（Compass-Bracket）
**All Assets**: 生产可用的 SVG，完全可缩放，符合 WCAG AA 可访问性要求
