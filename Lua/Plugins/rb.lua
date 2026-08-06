-- Highlight Keywords
highlight("def", "reserved")
highlight("end", "reserved")
highlight("class", "reserved")
highlight("module", "reserved")
highlight("if", "reserved")
highlight("elsif", "reserved")
highlight("else", "reserved")
highlight("unless", "reserved")
highlight("while", "reserved")
highlight("until", "reserved")
highlight("for", "reserved")
highlight("do", "reserved")
highlight("begin", "reserved")
highlight("rescue", "reserved")
highlight("ensure", "reserved")
highlight("retry", "reserved")
highlight("case", "reserved")
highlight("when", "reserved")
highlight("return", "reserved")
highlight("break", "reserved")
highlight("next", "reserved")
highlight("redo", "reserved")
highlight("yield", "reserved")
highlight("require", "reserved")
highlight("require_relative", "reserved")
highlight("load", "reserved")
highlight("include", "reserved")
highlight("extend", "reserved")
highlight("prepend", "reserved")
highlight("alias", "reserved")
highlight("undef", "reserved")
highlight("defined?", "reserved")
highlight("super", "reserved")
highlight("self", "reserved")
highlight("nil", "binary")
highlight("true", "binary")
highlight("false", "binary")
highlight("raise", "reserved")
highlight("throw", "reserved")
highlight("catch", "reserved")
highlight("then", "reserved")
highlight("lambda", "reserved")
highlight("proc", "reserved")
highlight("attr_reader", "reserved")
highlight("attr_writer", "reserved")
highlight("attr_accessor", "reserved")

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
highlight("<=>", "operator")
highlight("=~", "operator")
highlight("!~", "operator")
highlight("=>", "operator")
highlight("..", "operator")
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

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string")
highlight_region("%q{", "}", "string")
highlight_region("%Q{", "}", "string")
highlight_region("%w[", "]", "string")
highlight_region("%i[", "]", "string")

-- Comments
highlight_region("#", "", "comments", true)
highlight_region("=begin", "=end", "comments", false)

-- Comments
add_comment("Ruby: written by programmers who missed English class")
add_comment("There are 40 ways to do the same thing. All of them are wrong.")
add_comment("Blocks, procs, lambdas... just use a method bro")
add_comment("Metaprogramming: defining methods that define methods that define methods")
add_comment("It's English until you need to read someone else's code")
add_comment("You can't write bad Ruby, only surprising Ruby")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*def%s+([%w_?!]+)")
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
        local variable = line:match("%s*([@%a_][%w_]*)%s*=")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end
