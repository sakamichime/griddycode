-- Highlight Keywords
highlight("import", "reserved")
highlight("pragma", "reserved")
highlight("singleton", "reserved")
highlight("Component", "reserved")
highlight("id", "reserved")
highlight("property", "reserved")
highlight("readonly", "reserved")
highlight("required", "reserved")
highlight("default", "reserved")
highlight("signal", "reserved")
highlight("function", "reserved")
highlight("alias", "reserved")
highlight("on", "reserved")
highlight("as", "reserved")
highlight("false", "reserved")
highlight("true", "reserved")
highlight("null", "reserved")
highlight("undefined", "reserved")
highlight("in", "reserved")
highlight("of", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("do", "reserved")
highlight("switch", "reserved")
highlight("case", "reserved")
highlight("break", "reserved")
highlight("continue", "reserved")
highlight("return", "reserved")
highlight("new", "reserved")
highlight("var", "reserved")
highlight("let", "reserved")
highlight("const", "reserved")
highlight("this", "reserved")
highlight("typeof", "reserved")
highlight("instanceof", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("delete", "reserved")
highlight("void", "reserved")
highlight("yield", "reserved")
highlight("await", "reserved")
highlight("async", "reserved")

-- QtQuick built-in types
highlight("Item", "annotation")
highlight("Rectangle", "annotation")
highlight("Text", "annotation")
highlight("TextInput", "annotation")
highlight("TextEdit", "annotation")
highlight("Image", "annotation")
highlight("BorderImage", "annotation")
highlight("AnimatedImage", "annotation")
highlight("Button", "annotation")
highlight("CheckBox", "annotation")
highlight("RadioButton", "annotation")
highlight("Slider", "annotation")
highlight("TextField", "annotation")
highlight("TextArea", "annotation")
highlight("ComboBox", "annotation")
highlight("Switch", "annotation")
highlight("ProgressBar", "annotation")
highlight("SpinBox", "annotation")
highlight("Dial", "annotation")
highlight("Tumbler", "annotation")
highlight("Row", "annotation")
highlight("Column", "annotation")
highlight("Grid", "annotation")
highlight("Flow", "annotation")
highlight("StackLayout", "annotation")
highlight("GridLayout", "annotation")
highlight("RowLayout", "annotation")
highlight("ColumnLayout", "annotation")
highlight("GroupBox", "annotation")
highlight("Frame", "annotation")
highlight("Pane", "annotation")
highlight("ScrollView", "annotation")
highlight("Flickable", "annotation")
highlight("ListView", "annotation")
highlight("GridView", "annotation")
highlight("PathView", "annotation")
highlight("Repeater", "annotation")
highlight("Loader", "annotation")
highlight("MouseArea", "annotation")
highlight("DropArea", "annotation")
highlight("DragHandler", "annotation")
highlight("TapHandler", "annotation")
highlight("PinchHandler", "annotation")
highlight("WheelHandler", "annotation")
highlight("HoverHandler", "annotation")
highlight("Connections", "annotation")
highlight("Timer", "annotation")
highlight("Animation", "annotation")
highlight("NumberAnimation", "annotation")
highlight("ColorAnimation", "annotation")
highlight("PropertyAnimation", "annotation")
highlight("ParallelAnimation", "annotation")
highlight("SequentialAnimation", "annotation")
highlight("PauseAnimation", "annotation")
highlight("Behavior", "annotation")
highlight("State", "annotation")
highlight("StateGroup", "annotation")
highlight("Transition", "annotation")
highlight("PropertyChanges", "annotation")
highlight("FontLoader", "annotation")
highlight("Window", "annotation")
highlight("ApplicationWindow", "annotation")
highlight("Popup", "annotation")
highlight("Dialog", "annotation")
highlight("ToolTip", "annotation")
highlight("Menu", "annotation")
highlight("MenuItem", "annotation")
highlight("Action", "annotation")
highlight("Canvas", "annotation")
highlight("ShaderEffect", "annotation")
highlight("Gradient", "annotation")
highlight("AnimatedSprite", "annotation")
highlight("ParticleSystem", "annotation")
highlight("SpriteSequence", "annotation")
highlight("GridView", "annotation")

-- Common QtQuick property names (used in property bindings)
highlight("anchors", "member")
highlight("x", "member")
highlight("y", "member")
highlight("z", "member")
highlight("width", "member")
highlight("height", "member")
highlight("visible", "member")
highlight("opacity", "member")
highlight("rotation", "member")
highlight("scale", "member")
highlight("color", "member")
highlight("text", "member")
highlight("source", "member")
highlight("model", "member")
highlight("delegate", "member")
highlight("spacing", "member")
highlight("currentIndex", "member")
highlight("implicitWidth", "member")
highlight("implicitHeight", "member")
highlight("enabled", "member")
highlight("focus", "member")

-- JavaScript keywords used inside QML scripts
highlight("Math", "function")
highlight("console", "function")
highlight("Qt", "function")

-- Operators
highlight("=", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight("===", "operator")
highlight("!==", "operator")
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
highlight("=>", "operator")
highlight("?.", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(";", "binary")
highlight(",", "binary")
highlight(":", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string")

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("QML: XML had a baby with JavaScript, and it somehow works")
add_comment("anchors.fill: the Swiss army knife of layouts")
add_comment("Signal chaining is just event-driven clickbait")
add_comment("State machines: where every state is a state of mind")
add_comment("Property bindings: dependencies made invisible")
add_comment("Qt Quick: a GUI that responds faster than your QA team")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(")
        if functionName then
            table.insert(functionNames, functionName)
        end
        local signalName = line:match("%s*signal%s+([%w_]+)%s*%(")
        if signalName then
            table.insert(functionNames, signalName)
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local property = line:match("%s*property%s+([%w_.<>,]+)%s+([%w_]+)")
        if property then
            local property_name = line:match("%s*property%s+[%w_.<>,]+%s+([%w_]+)")
            table.insert(variable_names, property_name)
        end
        local variable = line:match("%s*var%s+([%w_]+)%s*=")
        if not variable then
            variable = line:match("%s*let%s+([%w_]+)%s*=")
        end
        if not variable then
            variable = line:match("%s*const%s+([%w_]+)%s*=")
        end
        if variable then
            table.insert(variable_names, variable)
        end
        local idName = line:match("%s*id%s*:%s*([%w_]+)")
        if idName then
            table.insert(variable_names, idName)
        end
    end

    return variable_names
end

function detect_api(content)
    local api = {}

    local qt_types = {
        "Item", "Rectangle", "Text", "TextInput", "TextEdit", "Image",
        "BorderImage", "AnimatedImage", "Button", "CheckBox", "RadioButton",
        "Slider", "TextField", "TextArea", "ComboBox", "Switch", "ProgressBar",
        "SpinBox", "Dial", "Tumbler", "Row", "Column", "Grid", "Flow",
        "StackLayout", "GridLayout", "RowLayout", "ColumnLayout", "GroupBox",
        "Frame", "Pane", "ScrollView", "Flickable", "ListView", "GridView",
        "PathView", "Repeater", "Loader", "MouseArea", "DropArea",
        "Connections", "Timer", "NumberAnimation", "ColorAnimation",
        "PropertyAnimation", "ParallelAnimation", "SequentialAnimation",
        "PauseAnimation", "Behavior", "State", "StateGroup", "Transition",
        "PropertyChanges", "Window", "ApplicationWindow", "Popup", "Dialog",
        "ToolTip", "Menu", "MenuItem", "Action", "Canvas", "ShaderEffect",
        "Gradient", "SpriteSequence", "AnimatedSprite"
    };

    for _, name in ipairs(qt_types) do
        table.insert(api, { name = name, kind = "class" })
    end

    local anchor_props = {
        "anchors.fill", "anchors.centerIn", "anchors.left", "anchors.right",
        "anchors.top", "anchors.bottom", "anchors.horizontalCenter",
        "anchors.verticalCenter", "anchors.margins", "anchors.leftMargin",
        "anchors.rightMargin", "anchors.topMargin", "anchors.bottomMargin"
    };

    for _, name in ipairs(anchor_props) do
        table.insert(api, { name = name, kind = "member" })
    end

    local common_props = {
        "x", "y", "z", "width", "height", "visible", "opacity", "rotation",
        "scale", "color", "text", "source", "model", "delegate", "spacing",
        "currentIndex", "implicitWidth", "implicitHeight", "enabled", "focus",
        "required", "readonly", "onCompleted", "onDestruction", "state"
    };

    for _, name in ipairs(common_props) do
        table.insert(api, { name = name, kind = "member" })
    end

    table.insert(api, { name = "onClicked", kind = "signal" })
    table.insert(api, { name = "onPressed", kind = "signal" })
    table.insert(api, { name = "onReleased", kind = "signal" })
    table.insert(api, { name = "onTextChanged", kind = "signal" })
    table.insert(api, { name = "onCurrentIndexChanged", kind = "signal" })
    table.insert(api, { name = "onTriggered", kind = "signal" })

    return api
end
