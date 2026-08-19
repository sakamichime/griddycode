-- Highlight Keywords
highlight("as", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("break", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("crate", "reserved")
highlight("dyn", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("extern", "reserved")
highlight("fn", "reserved")
highlight("for", "reserved")
highlight("if", "reserved")
highlight("impl", "reserved")
highlight("in", "reserved")
highlight("let", "reserved")
highlight("loop", "reserved")
highlight("match", "reserved")
highlight("mod", "reserved")
highlight("move", "reserved")
highlight("mut", "reserved")
highlight("pub", "reserved")
highlight("ref", "reserved")
highlight("return", "reserved")
highlight("self", "reserved")
highlight("static", "reserved")
highlight("struct", "reserved")
highlight("super", "reserved")
highlight("trait", "reserved")
highlight("unsafe", "reserved")
highlight("use", "reserved")
highlight("where", "reserved")
highlight("while", "reserved")

highlight("true", "binary")
highlight("false", "binary")

-- Type annotations
highlight("i8", "annotation")
highlight("i16", "annotation")
highlight("i32", "annotation")
highlight("i64", "annotation")
highlight("i128", "annotation")
highlight("isize", "annotation")
highlight("u8", "annotation")
highlight("u16", "annotation")
highlight("u32", "annotation")
highlight("u64", "annotation")
highlight("u128", "annotation")
highlight("usize", "annotation")
highlight("f32", "annotation")
highlight("f64", "annotation")
highlight("bool", "annotation")
highlight("char", "annotation")
highlight("str", "annotation")
highlight("String", "annotation")
highlight("Option", "annotation")
highlight("Result", "annotation")
highlight("Box", "annotation")
highlight("Vec", "annotation")
highlight("Some", "annotation")
highlight("None", "annotation")

-- Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight("->", "operator")
highlight("=>", "operator")
highlight("..", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(";", "binary")
highlight(",", "binary")
highlight("::", "binary")
highlight(":", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("How many borrow checker errors until you give up?")
add_comment("Rust would rather fail to compile than let you live")
add_comment("No segfaults, but the compiler gaslights you")
add_comment("Lifetime error: the variable wasn't alive long enough to see the panic")
add_comment("Fearless concurrency? More like fearless compilation errors")
add_comment("Safe, fast, and takes 15 minutes to build a hello world")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        -- Match fn declarations
        local functionName = line:match("%s*fn%s+([%w_]+)%s*%(")
        if functionName then
            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        -- Match let bindings
        local variable = line:match("%s*let%s+mut%s+([%w_]+)")
        if not variable then
            variable = line:match("%s*let%s+([%w_]+)")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end

function detect_api(content)
    local api = {}

    -- Tauri
    local tauri_symbols = {
        "Builder", "generate_context", "generate_handler", "run", "invoke_handler",
        "Manager", "AppHandle", "App", "WebviewWindow", "WebviewWindowBuilder",
        "WindowEvent", "CloseRequested", "State", "Command", "command", "async_command",
        "Emitter", "emit", "listen", "once", "unlisten", "tauri_build", "Wry"
    };

    -- egui
    local egui_symbols = {
        "Context", "CentralPanel", "SidePanel", "TopBottomPanel", "Window",
        "Area", "Grid", "ScrollArea", "ComboBox", "Slider", "DragValue",
        "TextEdit", "Button", "Checkbox", "RadioButton", "SelectableLabel",
        "Label", "RichText", "ColorPicker", "Color32", "Pos2", "Vec2", "Rect",
        "Frame", "Margin", "Rounding", "Stroke", "Ui", "Response", "run",
        "ViewportBuilder", "Visuals", "Style", "FontId"
    };

    -- iced
    local iced_symbols = {
        "Application", "Element", "Command", "Subscription", "Task",
        "Alignment", "Button", "Checkbox", "Column", "Container", "HorizontalSlider",
        "Image", "PickList", "ProgressBar", "Radio", "Row", "Scrollable",
        "Slider", "Space", "Stack", "Svg", "TabBar", "Text", "TextInput",
        "Toggler", "VerticalSlider", "Theme", "window", "Settings", "Renderer"
    };

    -- slint (Rust API)
    local slint_symbols = {
        "slint", "ComponentHandle", "Weak", "SharedString", "SharedVector",
        "ModelRc", "VecModel", "invoke_from_event_loop", "spawn_local",
        "Timer", "TimerMode", "Repeated", "run_event_loop", "quit_event_loop",
        "slint_build", "Compiler", "compile", "Diagnostic", "ValueType"
    };

    for _, sym in ipairs(tauri_symbols) do
        table.insert(api, { name = sym, kind = "class" })
    end
    for _, sym in ipairs(egui_symbols) do
        table.insert(api, { name = sym, kind = "class" })
    end
    for _, sym in ipairs(iced_symbols) do
        table.insert(api, { name = sym, kind = "class" })
    end
    for _, sym in ipairs(slint_symbols) do
        table.insert(api, { name = sym, kind = "class" })
    end

    table.insert(api, { name = "tauri::Builder", insert = "tauri::Builder::default()", kind = "class" })
    table.insert(api, { name = "egui::CentralPanel", insert = "egui::CentralPanel::default()", kind = "class" })
    table.insert(api, { name = "iced::Application", insert = "iced::Application", kind = "class" })
    table.insert(api, { name = "slint::slint", insert = "slint::slint!", kind = "class" })

    return api
end
