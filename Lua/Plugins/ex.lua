-- Highlight Keywords
highlight("defmodule", "reserved")
highlight("def", "reserved")
highlight("defp", "reserved")
highlight("defmacro", "reserved")
highlight("defmacrop", "reserved")
highlight("defguard", "reserved")
highlight("defguardp", "reserved")
highlight("defimpl", "reserved")
highlight("defprotocol", "reserved")
highlight("defrecord", "reserved")
highlight("defstruct", "reserved")
highlight("defexception", "reserved")
highlight("defmodule", "reserved")
highlight("defmodule", "reserved")
highlight("use", "reserved")
highlight("import", "reserved")
highlight("alias", "reserved")
highlight("require", "reserved")
highlight("if", "reserved")
highlight("unless", "reserved")
highlight("else", "reserved")
highlight("cond", "reserved")
highlight("case", "reserved")
highlight("when", "reserved")
highlight("fn", "reserved")
highlight("do", "reserved")
highlight("end", "reserved")
highlight("for", "reserved")
highlight("in", "reserved")
highlight("with", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("rescue", "reserved")
highlight("after", "reserved")
highlight("throw", "reserved")
highlight("raise", "reserved")
highlight("receive", "reserved")
highlight("send", "reserved")
highlight("spawn", "reserved")
highlight("apply", "reserved")
highlight("exit", "reserved")
highlight("nil", "binary")
highlight("true", "binary")
highlight("false", "binary")
highlight("self", "binary")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
highlight("!==", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
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
highlight("<>", "operator")
highlight("->", "operator")
highlight("|>", "operator")
highlight("..//", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(",", "binary")
highlight(";", "binary")
highlight(":", "binary")
highlight("::", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("~s\"", "\"", "string")
highlight_region("~S\"", "\"", "string")
highlight_region("~c\"", "\"", "string")
highlight_region("~r\"", "\"", "string")
highlight_region("~R\"", "\"", "string")
highlight_region("~w\"", "\"", "string")
highlight_region("~W\"", "\"", "string")

-- Comments
highlight_region("#", "", "comments", true)
highlight_region("<!--", "-->", "comments", false)

-- Comments
add_comment("Elixir: Erlang with a nicer haircut")
add_comment("The pipe operator will fix your life, or destroy it")
add_comment("Processes, processes everywhere")
add_comment("Let it crash is not a suggestion, it's a lifestyle")
add_comment("Phoenix channels: more like pheonix channelled into the void")
add_comment("Immutable data, mutable emotions")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*def%s+([%w_?!]+)%s*%(")
        if not functionName then
            functionName = line:match("%s*defp%s+([%w_?!]+)%s*%(")
        end
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
        local variable = line:match("%s*([%w_]+)%s*=%s*")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end