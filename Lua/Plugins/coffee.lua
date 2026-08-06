-- Highlight Keywords
highlight("if", "reserved")
highlight("else", "reserved")
highlight("unless", "reserved")
highlight("then", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("until", "reserved")
highlight("loop", "reserved")
highlight("break", "reserved")
highlight("continue", "reserved")
highlight("return", "reserved")
highlight("class", "reserved")
highlight("extends", "reserved")
highlight("super", "reserved")
highlight("new", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("of", "reserved")
highlight("in", "reserved")
highlight("when", "reserved")
highlight("then", "reserved")
highlight("do", "reserved")
highlight("by", "reserved")
highlight("and", "reserved")
highlight("or", "reserved")
highlight("not", "reserved")
highlight("yes", "reserved")
highlight("no", "reserved")
highlight("on", "reserved")
highlight("off", "reserved")
highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")
highlight("undefined", "binary")
highlight("this", "binary")

-- Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("**", "operator")
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
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
highlight(">>>", "operator")
highlight("=>", "operator")
highlight("...", "operator")
highlight("? :", "operator")

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
highlight_region("`", "`", "string")

-- Comments
highlight_region("#", "", "comments", true)

-- Comments
add_comment("CoffeeScript: JavaScript with extra sugar and fewer semicolons")
add_comment("One tab off and the whole function vanishes")
add_comment("It compiles to JS, so the bugs are optional")
add_comment("Why write JavaScript when you can write English?")
add_comment("Semicolons? Never heard of them")
add_comment("The fat arrow has no chill")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*([%w_]+)%s*%(")
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
        local variable = line:match("%s*([%w_]+)%s*=")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end