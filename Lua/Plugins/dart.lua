-- Highlight Keywords
highlight("import", "reserved")
highlight("library", "reserved")
highlight("part", "reserved")
highlight("part of", "reserved")
highlight("class", "reserved")
highlight("extends", "reserved")
highlight("implements", "reserved")
highlight("with", "reserved")
highlight("abstract", "reserved")
highlight("base", "reserved")
highlight("interface", "reserved")
highlight("mixin", "reserved")
highlight("enum", "reserved")
highlight("typedef", "reserved")
highlight("extension", "reserved")
highlight("external", "reserved")
highlight("factory", "reserved")
highlight("operator", "reserved")
highlight("const", "reserved")
highlight("final", "reserved")
highlight("var", "reserved")
highlight("late", "reserved")
highlight("new", "reserved")
highlight("get", "reserved")
highlight("set", "reserved")
highlight("static", "reserved")
highlight("covariant", "reserved")
highlight("required", "reserved")
highlight("this", "reserved")
highlight("super", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("do", "reserved")
highlight("switch", "reserved")
highlight("case", "reserved")
highlight("default", "reserved")
highlight("break", "reserved")
highlight("continue", "reserved")
highlight("return", "reserved")
highlight("try", "reserved")
highlight("on", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("rethrow", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("yield", "reserved")
highlight("sync*", "reserved")
highlight("async*", "reserved")
highlight("is", "reserved")
highlight("as", "reserved")
highlight("in", "reserved")
highlight("show", "reserved")
highlight("hide", "reserved")
highlight("deferred", "reserved")

highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")

-- Type annotations
highlight("int", "annotation")
highlight("double", "annotation")
highlight("num", "annotation")
highlight("bool", "annotation")
highlight("String", "annotation")
highlight("Object", "annotation")
highlight("dynamic", "annotation")
highlight("Never", "annotation")
highlight("void", "annotation")
highlight("List", "annotation")
highlight("Map", "annotation")
highlight("Set", "annotation")

-- Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("~/", "operator")
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
highlight(">>>", "operator")
highlight("..", "operator")
highlight("...", "operator")
highlight("??", "operator")
highlight("?=", "operator")
highlight("??=", "operator")
highlight("=>", "operator")

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
highlight("?", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("\"\"\"", "\"\"\"", "string")
highlight_region("'''", "'''", "string")

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("Dart: JavaScript but the types finally behave")
add_comment("Flutter: hot reload, cold soul")
add_comment("Every widget is a box, and every box is a widget")
add_comment("null safety means never having to say you're sorry")
add_comment("The pub cache grows faster than your app")
add_comment("What's that? A 500ms jank? Unacceptable.")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*([%w_]+)%s*%(([^)]*)%)%s*%{")
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
        local variable = line:match("%s*var%s+([%w_]+)%s*=")
        if not variable then
            variable = line:match("%s*final%s+([%w_]+)%s*=")
        end
        if not variable then
            variable = line:match("%s*const%s+([%w_]+)%s*=")
        end
        if not variable then
            variable = line:match("%s*late%s+([%w_]+)%s*=")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end

function detect_api(content)
    local api = {}

    local flutter_widgets = {
        "MaterialApp", "Scaffold", "AppBar", "FloatingActionButton",
        "Drawer", "BottomNavigationBar", "NavigationBar", "TabBar", "TabBarView",
        "SnackBar", "Dialog", "AlertDialog", "BottomSheet", "Card",
        "Container", "Row", "Column", "Stack", "Wrap", "SizedBox",
        "Expanded", "Flexible", "Padding", "Center", "Align", "Positioned",
        "Text", "RichText", "Icon", "IconButton", "Image", "Image.asset",
        "Image.network", "Image.file", "CircleAvatar", "ClipRRect",
        "TextField", "TextFormField", "InkWell", "GestureDetector", "ElevatedButton",
        "TextButton", "OutlinedButton", "Switch", "Checkbox", "Radio",
        "Slider", "LinearProgressIndicator", "CircularProgressIndicator",
        "ListView", "GridView", "SingleChildScrollView", "PageView",
        "Hero", "AnimatedContainer", "AnimatedOpacity", "AnimatedSwitcher",
        "Transform", "BackdropFilter", "FadeTransition", "ScaleTransition",
        "InheritedWidget", "Provider", "Consumer", "ChangeNotifierProvider",
        "Theme", "ThemeData", "MediaQuery", "Navigator", "Routes",
        "StatelessWidget", "StatefulWidget", "State", "BuildContext",
        "Key", "EdgeInsets", "TextStyle", "BoxDecoration", "BorderRadius",
        "MainAxisAlignment", "CrossAxisAlignment", "Axis", "Alignment",
        "BoxFit", "Clip", "Color", "Colors", "FontWeight", "FontStyle"
    }

    for _, widget in ipairs(flutter_widgets) do
        table.insert(api, { name = widget, kind = "class" })
    end

    local flutter_methods = {
        "setState", "dispose", "initState", "build", "didUpdateWidget",
        "showDialog", "showSnackBar", "showModalBottomSheet", "showMenu",
        "materialPageRoute", "push", "pop", "pushReplacement", "pushAndRemoveUntil"
    };

    for _, method in ipairs(flutter_methods) do
        table.insert(api, { name = method, kind = "member", insert = method .. "()" })
    end

    return api
end
