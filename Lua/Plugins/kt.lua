-- Highlight Keywords
highlight("fun", "reserved")
highlight("val", "reserved")
highlight("var", "reserved")
highlight("class", "reserved")
highlight("object", "reserved")
highlight("interface", "reserved")
highlight("enum", "reserved")
highlight("data", "reserved")
highlight("sealed", "reserved")
highlight("abstract", "reserved")
highlight("open", "reserved")
highlight("override", "reserved")
highlight("final", "reserved")
highlight("inner", "reserved")
highlight("companion", "reserved")
highlight("init", "reserved")
highlight("constructor", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("when", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("do", "reserved")
highlight("break", "reserved")
highlight("continue", "reserved")
highlight("return", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("import", "reserved")
highlight("package", "reserved")
highlight("is", "reserved")
highlight("as", "reserved")
highlight("in", "reserved")
highlight("out", "reserved")
highlight("by", "reserved")
highlight("get", "reserved")
highlight("set", "reserved")
highlight("lateinit", "reserved")
highlight("lazy", "reserved")
highlight("suspend", "reserved")
highlight("tailrec", "reserved")
highlight("inline", "reserved")
highlight("reified", "reserved")
highlight("noinline", "reserved")
highlight("crossinline", "reserved")
highlight("infix", "reserved")
highlight("operator", "reserved")
highlight("annotation", "reserved")
highlight("internal", "reserved")
highlight("private", "reserved")
highlight("protected", "reserved")
highlight("public", "reserved")
highlight("super", "reserved")
highlight("this", "reserved")
highlight("where", "reserved")
highlight("typealias", "reserved")
highlight("expect", "reserved")
highlight("actual", "reserved")
highlight("const", "reserved")

highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")

-- Type annotations
highlight("Int", "annotation")
highlight("Long", "annotation")
highlight("Short", "annotation")
highlight("Byte", "annotation")
highlight("Float", "annotation")
highlight("Double", "annotation")
highlight("Char", "annotation")
highlight("Boolean", "annotation")
highlight("String", "annotation")
highlight("Unit", "annotation")
highlight("Any", "annotation")
highlight("Nothing", "annotation")
highlight("List", "annotation")
highlight("Set", "annotation")
highlight("Map", "annotation")
highlight("Array", "annotation")

-- Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("++", "operator")
highlight("--", "operator")
highlight("=", "operator")
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
highlight("..", "operator")
highlight("->", "operator")
highlight("?:", "operator")
highlight("!!", "operator")
highlight("?=", "operator")
highlight("?:=", "operator")

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
highlight_region("\"\"\"", "\"\"\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("Kotlin: Java but the nulls are afraid of you")
add_comment("val is immutable. var is a lie you tell yourself")
add_comment("NullPointerException? In Kotlin? Skill issue.")
add_comment("suspend functions: they take forever, literally")
add_comment("Why null-safe when you can just not use null?")
add_comment("It's Java, but the compiler actually likes you")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*fun%s+([%w_]+)%s*%(")
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
        local variable = line:match("%s*val%s+([%w_]+)%s*:")
        if not variable then
            variable = line:match("%s*var%s+([%w_]+)%s*:")
        end
        if not variable then
            variable = line:match("%s*val%s+([%w_]+)%s*=")
        end
        if not variable then
            variable = line:match("%s*var%s+([%w_]+)%s*=")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end
