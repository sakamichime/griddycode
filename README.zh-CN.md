# GriddyCode
编码从未如此酷炫！


https://github.com/face-hh/griddycode/assets/69168154/df93830e-6e24-472d-a854-cea026b12890

P.S. 在编辑器中按 `CTRL` + `I` 可快速查看简介 :)

# 目录
   - [环境要求](#环境要求)
   - [⌨️ Lua 模组](#️-lua-模组)
	  - [在哪？](#在哪)
	  - [怎么做？](#怎么做)
	  - [文档](#文档)
		 - [语言包 (Langs)](#语言包-langs)
			- [介绍](#介绍)
			- [方法](#方法)
		 - [主题 (Themes)](#主题-themes)
			- [介绍](#介绍-1)
			- [方法](#方法-1)
	  - [发布](#发布)
   - [贡献](#贡献)
	  - [当前 Bug / 待实现功能](#-当前-bug--待实现功能)
	  	- [高优先级](#高优先级)
		- [中优先级](#中优先级)
		- [低优先级](#低优先级)

# 环境要求
| 要求 | 说明 |
| -------- | -------- |
| [Nerd Font](https://www.nerdfonts.com/) - 我们使用 Nerd Font 渲染文件选择器图标。 | 当图标显示为 "□" 时，说明你没有安装。 |
| [Linux](https://zh.wikipedia.org/wiki/Linux) - GriddyCode 主要在 **Linux** 上测试。 | 不支持 macOS。游戏操作系统（如 SteamOS）可以。 |

# ⌨️ Lua 模组
GriddyCode 允许你通过 **Lua** 扩展其功能。

## 在哪？
Lua 脚本文件夹的位置：

- Windows: `%APPDATA%\Godot\app_userdata\Bussin GriddyCode`
- macOS: `~/Library/Application Support/Bussin GriddyCode`
- Linux: `~/.local/share/godot/app_userdata/Bussin GriddyCode`

*注意：以上路径可能不准确，建议你在系统 AppData 中手动搜索 GriddyCode。*

## 怎么做？
你会看到 **"langs"** 和 **"themes"** 两个文件夹：
- **"langs"** 包含一系列 `.lua` 文件，用于实现 GriddyCode 的语法高亮和自动补全。
- **"themes"** 包含一系列 `.lua` 文件，用于改变 GriddyCode 的外观。

*注意：Lua 脚本只有在切换文件扩展名（如 "README.md" -> "main.ts"）或重启 GriddyCode 时才会重新加载。*

## 文档？
### 语言包 (Langs)
#### 介绍
要为某个**文件扩展名**扩展 GriddyCode 的功能，只需创建以该扩展名为文件名的脚本即可。（例如 `toml.lua`）

#### 方法

| 方法 | 示例 | 描述 | 备注 |
| -------- | -------- | -------- | -------- |
| `highlight(keyword: String, color: String)` | `highlight("const", "reserved")` | 告诉 GriddyCode 用预设颜色高亮某个关键字。 | 可用颜色：`reserved`、`annotation`、`string`、`binary`、`symbol`、`variable`、`operator`、`comments`、`error`、`function`、`member` |
| `highlight_region(start: String, end: String, color: String, line_only: bool = false)` | `highlight("/*", "*/", "comments", false)` | 告诉 GriddyCode 用预设颜色高亮一个区域。 | `start` 必须是符号。由于 Godot 功能受限，无法使用正则表达式。 |
| `add_comment(comment: String)` | `add_comment("What is blud doing 🗣️🗣️🗣️")` | 添加一条评论，会在 `CTRL` + `L` 菜单中随机显示。 | 用户名、头像、日期和点赞数由 GriddyCode 自动生成。 |
| `detect_functions(content: String, line: int, column: int) -> Array[String]` | `detect_functions("const test = 3; function main() {}; async init() => { main() }")` | 在输入时被 GriddyCode 调用。结果会显示在自动补全功能中。 | 必须由 Lua 脚本提供。必须返回字符串数组（例如 ["main", "init"]）。"line" 和 "column" 是请求自动补全时光标的位置。 |
| `detect_variables(content: String, line: int, column: int) -> Array[String]` | `detect_variables("const test = 3;")` | 在输入时被 GriddyCode 调用。结果会显示在自动补全功能中。 | 必须由 Lua 脚本提供。必须返回字符串数组（例如 ["test"]）。"line" 和 "column" 是请求自动补全时光标的位置。 |

*注意：要提供内置变量/函数（如 JS 中的 `Math`/`parseInt()`），你可以直接把它们放进返回的数组中，剩下的交给 GriddyCode！*

### 主题 (Themes)
#### 介绍
要添加主题，请在 **"themes"** 文件夹中创建任意名称的文件。（例如 "dracula.lua"），然后在 GriddyCode 内选择它即可。

#### 方法
| 方法 | 示例 | 描述 | 备注 |
| -------- | -------- | -------- | -------- |
| `set_keywords(property: String, new_color: String)` | `set_keywords("reserved", "#ff00ff")` | 设置语法高亮的颜色。 | 第二个参数必须是十六进制色值，`#` 可省略。可用的颜色/属性见上方 `langs` 一节。 |
| `set_gui(property: String, new_color: String)` | `set_gui("background_color", "#ff00ff")` | 此方法用于调整 GriddyCode 的整体 GUI 外观。 | 可用属性：`background_color`、`current_line_color`、`selection_color`、`font_color`、`word_highlighted_color`、`selection_background_color`。除 `background_color` 外，未提供的属性会自动设置为 `background_color` 的微调版本。虽然可行，但我们不建议依赖自动设置，最好手动指定所有值。 |
| `disable_glow()` | `disable_glow()` | 禁用 "glow"（辉光）效果。 | 因为 Godot 的 *glow* 在浅色主题下似乎会出问题。浅色主题不加这个可能会导致整个屏幕变白。 |

*注意：如果输入的 HEX 无效，将默认使用 #ff0000（红色）。*

## 发布
如果你想把主题/插件**给自己用**，可以把它们放进你的 [AppData](#在哪) 目录。

如果你想**提交**主题/插件，请分别向 `Lua/Plugins` 或 `Lua/Themes` 发起 Pull Request。合并后，它们会包含在下一个版本中。

# 贡献
无论是添加 Lua 插件、主题、安全地向 Lua 暴露更多功能，还是直接为 GriddyCode 添加功能，我们都非常欢迎贡献！

需要详细的操作指南？请参阅 [OPERATING_GUIDE.md](./OPERATING_GUIDE.md)（快捷键、多标签页、设置项、光标拖尾、常见问题）。

## 注意事项
- 你需要安装 [Godot Engine](https://godotengine.org/) 来运行你的改动，并确保其正常运行。
- 不需要提交可执行文件。
- 请使用 v4.7 版本的引擎（目前为最新版）。

## 🐛 当前 Bug / 待实现功能：
### 高优先级
- `VHS & CRT` 着色器在某些主题（One Dark Pro、GitHub Light 等）下会完全变白。在 GitHub Dark 下正常；
- 浅色模式会受到 *glow* 影响，深色模式则正常。

### 中优先级
- *(已清空 — 此前报告的问题已修复：设置菜单中切换字体、以及约 1600 行的相机 Bug。)*

### 低优先级
- 让设置菜单中的猫跳跃视频随菜单一起淡入/淡出。目前它无视过渡动画；
- `CTRL` + `P` 打开**快速文件选择器**，类似 [VSCode](https://code.visualstudio.com/docs/editor/editingevolved#:~:text=Quick%20file%20navigation,-Tip%3A%20You%20can&text=VS%20Code%20provides%20two%20powerful,release%20Ctrl%20to%20open%20it.)；
- 选中属性为 "shader" 的设置时，*应该* 禁用之前启用的带 "shader" 属性的设置；
- 每个 `setting` 场景中的 `CheckButton` 节点不会随主题变化。浅色主题尤其受影响。

请注意，创建 Pull Request 修复上述问题 *并不* 保证会被合并。除非你有信心完成得很好，否则请不要提交 Pull Request。
