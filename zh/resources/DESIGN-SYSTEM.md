# Claude Code Guide - 设计系统

## 视觉识别

### 图标设计概念：带代码括号的指南针

Claude Code Guide 图标使用了一个**带 `>` 代码括号的指南针**，代表“在代码世界里的引导式导航”：

```
     N (green)
     ▲
     │
W ───>─── E     Compass = Guidance/Direction
     │          > Bracket = Code/Terminal/CLI
     ▼
     S (black)
```

这带来了：
- **Visual Clarity**：一眼就能传达“代码导航指南”的感觉
- **Symbolic Meaning**：指南针 = 找方向；`>` = 代码 / 终端
- **Scalability**：从 16px 到 512px 都能使用
- **Brand Alignment**：用极简配色匹配开发者工具审美

---

## 色彩系统

### 调色板

| Color | Hex | RGB | Usage |
|-------|-----|-----|-------|
| Black (Primary) | `#000000` | 0, 0, 0 | 主线条、文本、南针 |
| White (Background) | `#FFFFFF` | 255, 255, 255 | 浅色背景 |
| Gray (Secondary) | `#6B7280` | 107, 114, 128 | 次要刻度、次级文字 |
| Bright Green (Accent) | `#22C55E` | 34, 197, 94 | 北针、中心点、强调线 |
| Near Black (Dark BG) | `#0A0A0A` | 10, 10, 10 | 深色模式背景 |

### 对比度（WCAG）

- Black on White：**21:1** AAA
- Gray on White：**4.6:1** AA
- Green on White：**3.2:1**（仅装饰用途，不用于正文文本）
- White on Dark：**19.5:1** AAA

### 强调色规则

**亮绿色（#22C55E）只用于强调：**
- 指南针北针
- 中心圆点
- 强调下划线 / 边框
- 不作为背景色
- 不用于正文文字

---

## 排版

### Logo 字体
- **Family**：Inter, SF Pro Display, -apple-system, Segoe UI, sans-serif
- **"Claude"**：42px，weight 700（bold），Black
- **"How-To"**：32px，weight 500（medium），Gray（#6B7280）
- **Subtitle**：10px，weight 500，Gray，letter-spacing 1.5px，大写

### 界面字体
- **Family**：Inter、SF Pro、system fonts（sans-serif）
- **Weight**：400-600
- **Style**：干净、易读

---

## 图标细节

### 指南针规格

指南针图形由以下几何元素构成：

```
Element             | Stroke/Fill    | Color
--------------------|----------------|------------------
Outer ring          | 3px stroke     | Black / White (dark mode)
North tick          | 2.5px stroke   | Black / White (dark mode)
Other cardinal ticks| 2px stroke     | Gray / White 50% (dark mode)
Intercardinal ticks | 1.5px stroke   | Gray / White 40% (dark mode)
North needle        | filled polygon | #22C55E (always green)
South needle        | filled polygon | Black / White (dark mode)
> bracket           | 3px stroke     | Black / White (dark mode)
Center dot          | filled circle  | #22C55E (always green)
```

### 尺寸递进

```
16px  → 仅保留外环 + 指针 + 尖括号（最简版）
32px  → 加入主方位刻度
64px  → 加入次方位刻度
128px → 完整细节，全部元素清晰可辨
256px → 细节最完整，线条最厚实
```

---

## 尺寸准则

### Logo 尺寸

- **Minimum**：200px 宽（Web）
- **Recommended**：520px（原始尺寸）
- **Maximum**：无限制（矢量格式）
- **Aspect Ratio**：约 4.3:1（宽:高）

### Icon 尺寸

- **Minimum**：16px（favicon）
- **Recommended**：64-256px（应用、头像）
- **Maximum**：无限制（矢量格式）
- **Aspect Ratio**：1:1（正方形）

---

## 间距与对齐

### Logo 间距

```
┌─────────────────────────────────────┐
│                                     │
│        Clear Space Minimum          │
│         (logo height / 2)           │
│                                     │
│    [COMPASS]  Claude                │
│               How-To                │
│                                     │
└─────────────────────────────────────┘
```

### Icon 中心点

所有图标都以画布中心为基准：
- 256px 画布的中心点是 128×128
- 128px 画布的中心点是 64×64
- 这样能与其他 UI 元素保持整齐对齐

---

## 可访问性

### 色彩对比
- 所有文本都满足 WCAG AA（至少 4.5:1）
- 绿色强调色只用于装饰，不承载信息
- 不依赖红绿对比来表达含义

### 可缩放性
- 矢量格式保证任意尺寸下都清晰
- 在 16px 下几何图形仍然可辨识
- 根据可用尺寸逐步增加细节

---

## 应用示例

### Web Header
- 尺寸：520×120px logo
- 文件：`logos/claude-code-guide-logo.svg`
- 背景：白色或深色（#0A0A0A）
- Padding：至少 20px

### App Icon
- 尺寸：256×256px
- 文件：`icons/claude-code-guide-icon.svg`
- 背景：白色或深色
- 用途：应用快捷方式、头像

### Browser Favicon
- 尺寸：32px（主版本），16px（备用）
- 文件：`favicons/favicon-32.svg`
- 格式：SVG，保证清晰显示

### Social Media
- 头像：256×256px icon
- Banner：520×120px logo（居中）

### Documentation
- Chapter Headers：缩放后的 Logo
- Section Icons：64×64px favicon
- Inline：32×32px favicon

---

## 文件格式细节

### SVG 结构

所有 SVG 都是扁平设计：
- 无渐变（只用纯色）
- 无滤镜效果（无模糊、发光、阴影）
- 干净的 stroke / fill 几何结构
- 使用 ViewBox 支持响应式缩放
- 代码可读，可带注释

### 跨浏览器兼容性

- Chrome / Edge：完整支持
- Firefox：完整支持
- Safari：完整支持
- iOS Safari：完整支持
- 所有现代浏览器：完整支持

---

## 自定义

### 更换强调色

如果你想换一个强调色变体：

1. 把所有 `#22C55E` 替换成你的新强调色
2. 确保装饰元素仍有至少 3:1 的对比度
3. 保持黑 / 白 / 灰结构不变
