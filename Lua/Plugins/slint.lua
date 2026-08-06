-- Highlight Keywords
highlight("export", "reserved")
highlight("import", "reserved")
highlight("from", "reserved")
highlight("component", "reserved")
highlight("global", "reserved")
highlight("struct", "reserved")
highlight("enum", "reserved")
highlight("public", "reserved")
highlight("private", "reserved")
highlight("callback", "reserved")
highlight("property", "reserved")
highlight("in", "reserved")
highlight("out", "reserved")
highlight("in-out", "reserved")
highlight("pure", "reserved")
highlight("states", "reserved")
highlight("transitions", "reserved")
highlight("animate", "reserved")
highlight("animate-backwards", "reserved")
highlight("default", "reserved")
highlight("key", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("true", "reserved")
highlight("false", "reserved")
highlight("return", "reserved")
highlight("function", "reserved")
highlight("Math", "reserved")
highlight("infinite", "reserved")
highlight("resource", "reserved")
highlight("inherits", "reserved")
highlight("is", "reserved")

-- Slint built-in types
highlight("length", "annotation")
highlight("physical_length", "annotation")
highlight("duration", "annotation")
highlight("angle", "annotation")
highlight("int", "annotation")
highlight("float", "annotation")
highlight("bool", "annotation")
highlight("string", "annotation")
highlight("color", "annotation")
highlight("brush", "annotation")
highlight("image", "annotation")
highlight("easing", "annotation")
highlight("percent", "annotation")
highlight("relative-font-size", "annotation")

-- Slint built-in elements
highlight("Window", "annotation")
highlight("Rectangle", "annotation")
highlight("Text", "annotation")
highlight("Image", "annotation")
highlight("Button", "annotation")
highlight("TouchArea", "annotation")
highlight("FocusScope", "annotation")
highlight("VerticalLayout", "annotation")
highlight("HorizontalLayout", "annotation")
highlight("GridLayout", "annotation")
highlight("ListView", "annotation")
highlight("ScrollView", "annotation")
highlight("ProgressIndicator", "annotation")
highlight("Slider", "annotation")
highlight("SpinBox", "annotation")
highlight("TextEdit", "annotation")
highlight("LineEdit", "annotation")
highlight("ComboBox", "annotation")
highlight("TabWidget", "annotation")
highlight("PopupWindow", "annotation")
highlight("Flickable", "annotation")
highlight("BorderImage", "annotation")
highlight("BoxShadow", "annotation")
highlight("DropShadow", "annotation")

-- Slint common properties
highlight("width", "member")
highlight("height", "member")
highlight("x", "member")
highlight("y", "member")
highlight("background", "member")
highlight("background-color", "member")
highlight("color", "member")
highlight("border-radius", "member")
highlight("border-width", "member")
highlight("border-color", "member")
highlight("text", "member")
highlight("font-size", "member")
highlight("font-family", "member")
highlight("font-weight", "member")
highlight("visible", "member")
highlight("opacity", "member")
highlight("rotation-angle", "member")
highlight("rotate", "member")
highlight("scale", "member")
highlight("source", "member")
highlight("row", "member")
highlight("column", "member")
highlight("spacing", "member")
highlight("padding", "member")
highlight("margin", "member")
highlight("alignment", "member")
highlight("vertical-alignment", "member")
highlight("horizontal-alignment", "member")
highlight("clip", "member")
highlight("read-only", "member")
highlight("enabled", "member")
highlight("checked", "member")
highlight("has-focus", "member")
highlight("current-index", "member")
highlight("model", "member")
highlight("display", "member")
highlight("value", "member")
highlight("minimum", "member")
highlight("maximum", "member")
highlight("duration", "member")
highlight("iteration-count", "member")
highlight("easing", "member")
highlight("delay", "member")
highlight("initial-state", "member")

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
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("?", "operator")
highlight(":", "operator")
highlight("=>", "operator")
highlight("...", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(",", "binary")
highlight(";", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("Slint: declarative UI without the framework sprawl")
add_comment("compiled at build time, pretty at runtime")
add_comment("A layout that just works? Slint says yes")
add_comment("declarative, not determinative")
add_comment("Your UI is 300KB, not 300MB")
add_comment("Slint: where Rust meets visual design")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(")
        if functionName then
            table.insert(functionNames, functionName)
        end
        local callbackName = line:match("%s*callback%s+([%w_]+)%s*%(")
        if callbackName then
            table.insert(functionNames, callbackName)
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local property
        property = line:match("%s*property%s+<%s*[%w_]+%s*>%s+([%w_]+)")
        if not property then
            property = line:match("%s*in%-out%s+property%s+<%s*[%w_]+%s*>%s+([%w_]+)")
        end
        if not property then
            property = line:match("%s*in%s+property%s+<%s*[%w_]+%s*>%s+([%w_]+)")
        end
        if not property then
            property = line:match("%s*out%s+property%s+<%s*[%w_]+%s*>%s+([%w_]+)")
        end
        if not property then
            property = line:match("%s*property%s+([%w_]+)")
        end
        if property then
            table.insert(variable_names, property)
        end
    end

    return variable_names
end

function detect_api(content)
    local api = {}

    local builtin_elements = {
        "Window", "Rectangle", "Text", "Image", "Button", "TouchArea",
        "FocusScope", "VerticalLayout", "HorizontalLayout", "GridLayout",
        "ListView", "ScrollView", "ProgressIndicator", "Slider", "SpinBox",
        "TextEdit", "LineEdit", "ComboBox", "TabWidget", "PopupWindow",
        "Flickable", "BorderImage", "BoxShadow", "DropShadow"
    };

    for _, name in ipairs(builtin_elements) do
        table.insert(api, { name = name, kind = "class" })
    end

    local common_props = {
        "width", "height", "x", "y", "background", "background-color",
        "color", "border-radius", "border-width", "border-color", "text",
        "font-size", "font-family", "font-weight", "visible", "opacity",
        "rotation-angle", "source", "spacing", "padding", "alignment",
        "vertical-alignment", "horizontal-alignment", "clip", "enabled",
        "checked", "model", "display", "value", "minimum", "maximum"
    };

    for _, name in ipairs(common_props) do
        table.insert(api, { name = name, kind = "member" })
    end

    local callbacks = {
        "clicked", "pressed", "released", "moved", "pointer-event",
        "key-pressed", "key-released", "edited", "accepted", "changed",
        "current-index-changed", "value-changed", "toggled"
    };

    for _, name in ipairs(callbacks) do
        table.insert(api, { name = name, kind = "signal" })
    end

    local builtins = {
        "Math", "debug", "info", "warning", "error", "set-color", "get-color",
        "rgb", "rgba", "hsl", "hsla", "material", "linear-gradient",
        "radial-gradient", "cross-fade", "image-size", "path", "linear"
    };

    for _, name in ipairs(builtins) do
        table.insert(api, { name = name, kind = "function" })
    end

    return api
end
