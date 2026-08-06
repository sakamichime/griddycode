-- Highlight Keywords
highlight("class", "reserved")
highlight("object", "reserved")
highlight("trait", "reserved")
highlight("case", "reserved")
highlight("extends", "reserved")
highlight("with", "reserved")
highlight("sealed", "reserved")
highlight("abstract", "reserved")
highlight("final", "reserved")
highlight("implicit", "reserved")
highlight("def", "reserved")
highlight("val", "reserved")
highlight("var", "reserved")
highlight("type", "reserved")
highlight("package", "reserved")
highlight("import", "reserved")
highlight("export", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("do", "reserved")
highlight("match", "reserved")
highlight("case", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("return", "reserved")
highlight("yield", "reserved")
highlight("new", "reserved")
highlight("override", "reserved")
highlight("super", "reserved")
highlight("this", "reserved")
highlight("private", "reserved")
highlight("protected", "reserved")
highlight("public", "reserved")
highlight("sealed", "reserved")
highlight("lazy", "reserved")
highlight("macro", "reserved")
highlight("given", "reserved")
highlight("using", "reserved")
highlight("enum", "reserved")
highlight("inline", "reserved")
highlight("opaque", "reserved")
highlight("transparent", "reserved")

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
highlight("Option", "annotation")
highlight("Some", "annotation")
highlight("None", "annotation")
highlight("Either", "annotation")
highlight("Left", "annotation")
highlight("Right", "annotation")
highlight("List", "annotation")
highlight("Seq", "annotation")
highlight("Map", "annotation")
highlight("Set", "annotation")
highlight("Future", "annotation")
highlight("Try", "annotation")
highlight("Array", "annotation")

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
highlight("<-", "operator")
highlight("::", "operator")
highlight("_", "operator")
highlight("++", "operator")

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
add_comment("Scala: Java's smarter, angrier sibling")
add_comment("Scala is the last language you'll ever need. Until tomorrow")
add_comment("Implicits: the compiler does what it wants")
add_comment("case class? more like case CLOSED")
add_comment("Type inference is 90% of the code")
add_comment("FP or OOP? Both. Neither. Depends.")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*def%s+([%w_]+)%s*%(")
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
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end