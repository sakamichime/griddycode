# GriddyCode 操作说明书 / User Guide

> 编码从未如此带感 / Coding has never been more lit!

本说明书帮助你在 GriddyCode 中完成日常操作：启动、编辑、快捷键、文件管理、
光标拖尾与设置项。
This guide covers how to launch the editor, basic editing, hotkeys, file
management, the cursor trail, and all settings.

---

## 目录 / Table of Contents

- [系统要求与依赖 / Requirements](#system-requirements)
- [启动 / Running](#running)
- [编辑基本操作 / Basic Editing](#basic-editing)
- [快捷键一览 / Hotkeys](#hotkeys)
- [文件选择器 / File Picker](#file-picker)
- [多标签页 / Tabs](#tabs)
- [光标拖尾 / Cursor Trail](#cursor-trail)
- [设置项 / Settings](#settings)
- [数据与 Lua 扩展 / Data & Lua Modding](#data--lua-modding)
- [常见问题 / FAQ](#faq)

---

## 系统要求与依赖 / Requirements & Requirements

| 依赖 | 说明 |
| -------- | -------- |
| [Godot Engine](https://godotengine.org/) | 版本 4.7（与 `project.godot` 的 `config/features` 一致） |
| [NerdFont](https://www.nerdfonts.com/) | 文件选择器使用 NerdFont 图标；缺失时图标会显示为 `□` |
| Linux | 主要在 Linux 上测试 |

---

## 启动 / Running

从项目根目录启动：

```bash
godot --path .
```

### 命令行直接打开文件 / Open a File via CLI

GriddyCode 支持启动时直接用命令行参数打开文件：

```bash
godot --path . path/to/file.lua
```

- 传入参数后，编辑器会自动以该路径为 `current_file` 并加载内容。
- 不传参数启动时，编辑器会显示欢迎信息并弹出文件选择器。

---

## 编辑快捷键 / Basic Editing

| 功能 | 说明 |
| -------- | -------- |
| 编辑 | 常规 CodeEdit 行为：输入、退格、方向键移动、Home/End、PageUp/PageDown 等均可用 |
| 代码补全 | 输入时自动触发补全（设置中可关闭），含有函数 / 变量 / 关键字 / API 提示 |
| 自动配对括号 | `auto_brace_completion` 开启后自动补全括号并高亮匹配括号 |
| 自动保存 | 默认自动保存：每 5 秒写入当前文件；窗口失焦或退出时也会保存。可在设置中切换为手动保存（`Ctrl` + `S`），此时关闭所有自动写盘 |

> 提示：切换语言 / 主题后语法高亮会随文件扩展名变化；Lua 脚本在切换文件扩展名或重启时才会重新加载。

---

## 快捷键 / Hotkeys

### 界面 / Overlays

| 快捷键 | 动作 | 来源 |
| --- | --- | --- |
| `Ctrl` + `O` | 打开/关闭文件选择器 | `ui_open` |
| `Ctrl` + `S` | 保存当前文件 | `ui_save` |
| `Ctrl` + `N` | （全局）在文件选择器新建文件 | `ui_new_file` |
| `Ctrl` + `Shift` + `N` | （全局）在文件选择器新建文件夹 | `ui_new_folder` |
| `Ctrl` + `,` | 打开/关闭设置面板 | `ui_settings` |
| `Ctrl` + `I` | 打开/关闭信息/介绍面板 | `ui_info` |
| `Ctrl` + `T` | 打开/关闭主题选择器 | `ui_theme` |
| `Ctrl` + `L` | 打开/关闭评论菜单 | `ui_comments` |
| `Ctrl` + `Tab` | 切换到下一个标签页 | `ui_next_tab` |
| `Ctrl` + `Shift` + `Tab` | 切换到上一个标签页 | `ui_prev_tab` |
| `Ctrl` + `W` | 关闭当前标签页 | `ui_close_tab` |
| `Esc` | 关闭当前覆盖层；有多光标时先折叠多光标 | `ui_cancel` |

### 缩放 / Zoom（可在文件选择器/信息面板使用）

| 快捷键 | 动作 |
| --- | --- |
| `Ctrl` + `=` | 放大 |
| `Ctrl` + `-` | 缩小 |

### 多光标 / Multi-cursor（VSCode 风格）

| 快捷键 | 动作 |
| --- | --- |
| `Ctrl` + `D` | 选中（高亮）下一处出现 |
| `Ctrl` + `Shift` + `L` | 全选所有相同出现 |
| `Ctrl` + `Alt` + `↑` | 在上方添加一个光标 |
| `Ctrl` + `Alt` + `↓` | 在下方添加一个光标 |
| `Esc` | 移除次级光标（折叠为单一光标） |

---

## 文件选择器 / File Picker

文件选择器是一个公文包式的 RichTextLabel 列表，支持方向键与模糊搜索：

| 按键 | 动作 |
| --- | --- |
| `↑` / `↓` | 上下移动选中项 |
| `Enter` | 进入目录（若为文件夹）或打开文件（若为文件） |
| `Backspace` | 删除搜索查询末字符 |
| `Ctrl` + `Backspace` | 清空搜索查询 |
| 其他字符 | 追加到搜索查询，自动模糊匹配（不含扩展名） |

### 新建文件 / 新建文件夹

在任意位置按 `Ctrl` + `N`（文件）或 `Ctrl` + `Shift` + `N`（文件夹），列表顶部会出现创建输入行：

| 按键 | 动作 |
| --- | --- |
| 普通字符 | 输入项目名（输入到首页） |
| `Enter` | 在当前目录创建并打开（文件夹则返回父目录并刷新列表） |
| `Esc` | 退出创建模式，返回浏览 |

- 创建文件后立即打开并成为当前文件，随后的自动保存会逐步落到该路径。
- 若同名文件/文件夹已存在：弹警告，**不会覆盖**，并保持创建输入状态。

> 该功能由 `file_dialog` 场景提供，`current_dir` 每会话从工作目录读取。

---

## 多标签页 / Tabs

编辑器顶部有标签栏，可同时打开多个文件（`tabbar.gd` / `file_manager.gd`）：

- 打开文件会自动加入标签栏；点击标签可在文件间切换。
- 标签右侧的 `󰅖` 可关闭该标签（或使用 `Ctrl` + `W` 关闭当前文件）。
- 有未保存修改（手动保存模式下）的文件会显示黄色 `●` 标记。
- 每个文件独立保存光标位置 / 滚动位置，切换标签后自动恢复。
- 标签栏为空时自动隐藏；修改状态随 `on_settings_change` / 主题加载自动刷新。

> 注意：标签切换会立即重载对应文件的语法高亮与 Lua 语言包。

---

## 光标拖尾 / Cursor Trail

GriddyCode 提供 neovide 风格光标拖尾（阻尼弹簧拖尾动画），拖尾独立绘制在编辑区上、取代内置光标：

- **隐藏内置光标**：拖尾色设置为透明，由拖尾四边形代绘（`cursor_trail.gd`）。
- **闪烁跟随 Godot**：`caret_blink` 与 `caret_blink_interval` 生效，拖动/移动到关闭闪烁。
- **三种光标样式**（设置面板 `caret_type` 切换）：
  - **Line（竖线）**：细竖线
  - **Block（方块）**：满格方块（不透明底色 + 白字重绘于方块上）
  - **Underline（下划线）**：底边横条
- 开始写入（改写）时：以方块光标呈现。

调整相关设置：
- `caret_type`（样式）、`caret_blink`（闪烁开关）、`caret_interval`（闪烁间隔）。

---

## 设置项 / Settings

设置面板（`Ctrl` + `,`）中按以下项排列（显示名取 `lua_singleton.gd` 的 `settings` 数组，必要时用到 `i18n`）：

| 设置 | 类型 | 说明 |
| --- | --- | --- |
| `caret_type` | 下拉 | 光标样式：Line / Block / Underline |
| `caret_blink` | 开关 | 是否闪烁 |
| `caret_interval` | 滑杆 | 闪烁间隔（秒） |
| `manual_save` | 开关 | 手动保存：开启后用 `Ctrl` + `S` 保存，关闭所有自动写盘 |
| `editor_font` | 下拉 | 编辑器字体（内置 + 系统字体） |
| `draw_line_numbers` | 开关 | 是否显示行号 |
| `code_completion` | 开关 | 是否启用补全 |
| `indentation_size` | 滑杆 | 缩进宽度（Tab 空格数） |
| `indentation_automatic` | 开关 | 自动缩进 |
| `indentation_use_spaces` | 开关 | 缩进用空格代替 Tab |
| `auto_brace_completion` | 开关 | 自动补全成对括号 |
| `auto_brace_highlight_matching` | 开关 | 匹配括号高亮 |
| `smooth_scrolling` | 开关 | 平滑滚动 |
| `v_scroll_speed` | 滑杆 | 垂直滚动速度（px/s） |
| `minimap` | 开关 | 是否显示代码小地图 |
| `minimap_width` | 滑杆 | 小地图宽度（px） |
| `glow` | 开关 | 发光效果 |
| `sunlight` | 开关（shader） | 阳光/光效 shader |
| `vhs` | 开关（shader） | VHS & CRT shader |
| `music` | 开关 | 背景音乐 |
| `music_volume` | 滑杆 | 音乐音量（%） |
| `music_move_intensity` | 滑杆 | 音乐移动强度 |
| `discord_sdk` | 开关 | Discord 状态同步（在编辑中/空闲） |

> 独立的面板：主题选择使用 `Ctrl` + `T`，可从 `user://themes` 中的 Lua 主题选择。

---

## 数据与 Lua 扩展 / Data & Lua Modding

- **存档数据**：`user://data.save`（记录当前文件、目录、设置、主题），退出时自动写入（`file_manager.gd`）。
- **主题/Lua 脚本目录**：`user://themes`、`user://langs`（对应 `%APPDATA%/Godot/app_userdata/Bussin GriddyCode` 等平台路径）。
- **更多扩展文档（Lua API、主题、发布）**：参见根目录 `README.md`。

---

## FAQ

1. **图标显示为 `□`？** → 请安装 Nerd Font。
2. **为什么光标闪烁/没闪烁？** → 检查 `caret_blink` 与 `caret_interval` 设置。
3. **怎么保存文件？** → 默认自动保存（每 5 秒 + 失焦/退出时）；也可在设置中开启「手动保存」，然后使用 `Ctrl` + `S`。
4. **没有主题/语言选项？** → 确保 `user://themes` 与 `user://langs` 目录存在且内有对应的 Lua 文件；GitHub 合并的主题/插件需手动放入用户目录。