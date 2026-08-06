-- Highlight Keywords
highlight("use", "reserved")
highlight("require", "reserved")
highlight("my", "reserved")
highlight("our", "reserved")
highlight("local", "reserved")
highlight("state", "reserved")
highlight("sub", "reserved")
highlight("package", "reserved")
highlight("class", "reserved")
highlight("if", "reserved")
highlight("elsif", "reserved")
highlight("else", "reserved")
highlight("unless", "reserved")
highlight("while", "reserved")
highlight("until", "reserved")
highlight("for", "reserved")
highlight("foreach", "reserved")
highlight("given", "reserved")
highlight("when", "reserved")
highlight("default", "reserved")
highlight("do", "reserved")
highlight("last", "reserved")
highlight("next", "reserved")
highlight("redo", "reserved")
highlight("continue", "reserved")
highlight("return", "reserved")
highlight("die", "reserved")
highlight("warn", "reserved")
highlight("print", "reserved")
highlight("printf", "reserved")
highlight("say", "reserved")
highlight("split", "reserved")
highlight("join", "reserved")
highlight("map", "reserved")
highlight("grep", "reserved")
highlight("sort", "reserved")
highlight("each", "reserved")
highlight("keys", "reserved")
highlight("values", "reserved")
highlight("defined", "reserved")
highlight("undef", "reserved")
highlight("exists", "reserved")
highlight("delete", "reserved")
highlight("push", "reserved")
highlight("pop", "reserved")
highlight("shift", "reserved")
highlight("unshift", "reserved")
highlight("splice", "reserved")
highlight("open", "reserved")
highlight("close", "reserved")
highlight("read", "reserved")
highlight("binmode", "reserved")
highlight("eval", "reserved")
highlight("BEGIN", "reserved")
highlight("END", "reserved")
highlight("CHECK", "reserved")
highlight("INIT", "reserved")
highlight("__PACKAGE__", "reserved")
highlight("__FILE__", "reserved")
highlight("__LINE__", "reserved")
highlight("bless", "reserved")
highlight("ref", "reserved")

highlight("true", "binary")
highlight("false", "binary")
highlight("undef", "binary")

-- Type handling
highlight("$", "operator")
highlight("@", "operator")
highlight("%", "operator")
highlight("&", "operator")
highlight("*", "operator")
highlight("\\", "operator")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight("eq", "operator")
highlight("ne", "operator")
highlight("lt", "operator")
highlight("gt", "operator")
highlight("le", "operator")
highlight("ge", "operator")
highlight("cmp", "operator")
highlight("<=>", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("**", "operator")
highlight("++", "operator")
highlight("--", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("and", "operator")
highlight("or", "operator")
highlight("not", "operator")
highlight("xor", "operator")
highlight("=~", "operator")
highlight("!~", "operator")
highlight("=>", "operator")
highlight("->", "operator")
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

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string")

-- Comments
highlight_region("#", "", "comments", true)
highlight_region("=pod", "=cut", "comments", false)

-- Comments
add_comment("Perl: the language that looks like line noise")
add_comment("There is more than one way to do it, none of them obvious")
add_comment("Your regex is either magic or a cry for help")
add_comment("TMTOWTDI: variations of the same problem")
add_comment("It's not obfuscated, it's expressive")
add_comment("Perl is the duct tape of the internet")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*sub%s+([%w_]+)")
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
        local variable = line:match("[$@%%]([%w_]+)")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end