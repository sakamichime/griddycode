-- Highlight Keywords
highlight("<?php", "reserved")
highlight("?>", "reserved")
highlight("echo", "reserved")
highlight("print", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("elseif", "reserved")
highlight("endif", "reserved")
highlight("while", "reserved")
highlight("endwhile", "reserved")
highlight("for", "reserved")
highlight("endforeach", "reserved")
highlight("foreach", "reserved")
highlight("as", "reserved")
highlight("do", "reserved")
highlight("switch", "reserved")
highlight("case", "reserved")
highlight("endswitch", "reserved")
highlight("default", "reserved")
highlight("break", "reserved")
highlight("continue", "reserved")
highlight("return", "reserved")
highlight("function", "reserved")
highlight("class", "reserved")
highlight("interface", "reserved")
highlight("trait", "reserved")
highlight("enum", "reserved")
highlight("extends", "reserved")
highlight("implements", "reserved")
highlight("abstract", "reserved")
highlight("final", "reserved")
highlight("public", "reserved")
highlight("protected", "reserved")
highlight("private", "reserved")
highlight("static", "reserved")
highlight("const", "reserved")
highlight("var", "reserved")
highlight("new", "reserved")
highlight("clone", "reserved")
highlight("instanceof", "reserved")
highlight("namespace", "reserved")
highlight("use", "reserved")
highlight("require", "reserved")
highlight("require_once", "reserved")
highlight("include", "reserved")
highlight("include_once", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("global", "reserved")
highlight("isset", "reserved")
highlight("unset", "reserved")
highlight("empty", "reserved")
highlight("list", "reserved")
highlight("array", "reserved")
highlight("callable", "reserved")
highlight("match", "reserved")
highlight("fn", "reserved")
highlight("yield", "reserved")
highlight("readonly", "reserved")
highlight("never", "reserved")

highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")
highlight("$this", "binary")

-- Type annotations
highlight("int", "annotation")
highlight("float", "annotation")
highlight("string", "annotation")
highlight("bool", "annotation")
highlight("array", "annotation")
highlight("object", "annotation")
highlight("void", "annotation")
highlight("mixed", "annotation")

-- Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("**", "operator")
highlight("++", "operator")
highlight("--", "operator")
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("**=", "operator")
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
highlight("!==", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("<=>", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight("??", "operator")
highlight("?->", "operator")
highlight("...", "operator")
highlight(".", "operator")
highlight(".=", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(";", "binary")
highlight(",", "binary")
highlight("->", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("<<<", "", "string", true)

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("#", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("PHP: the only language where $variables have a gender")
add_comment("The $ is not a bug, it's a feature")
add_comment("You don't choose PHP, PHP chooses you")
add_comment("7 versions later and it still can't agree on a naming style")
add_comment("If it works, don't touch it. Especially not with Composer.")
add_comment("Laravel: PHP with extra steps and even more magic")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(")
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
        local variable = line:match("%$([%w_]+)%s*=")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end
