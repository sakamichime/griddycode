-- Highlight Keywords
highlight("module", "reserved")
highlight("export", "reserved")
highlight("import", "reserved")
highlight("-module", "reserved")
highlight("-export", "reserved")
highlight("-import", "reserved")
highlight("-include", "reserved")
highlight("-include_lib", "reserved")
highlight("-define", "reserved")
highlight("-record", "reserved")
highlight("-spec", "reserved")
highlight("-type", "reserved")
highlight("-opaque", "reserved")
highlight("-callback", "reserved")
highlight("-behaviour", "reserved")
highlight("case", "reserved")
highlight("of", "reserved")
highlight("end", "reserved")
highlight("if", "reserved")
highlight("then", "reserved")
highlight("else", "reserved")
highlight("when", "reserved")
highlight("fun", "reserved")
highlight("receive", "reserved")
highlight("after", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("begin", "reserved")
highlight("and", "reserved")
highlight("or", "reserved")
highlight("not", "reserved")
highlight("andalso", "reserved")
highlight("orelse", "reserved")
highlight("spawn", "reserved")
highlight("send", "reserved")
highlight("exit", "reserved")
highlight("true", "binary")
highlight("false", "binary")
highlight("ok", "binary")
highlight("error", "binary")
highlight("undefined", "binary")

-- Type annotations
highlight("integer", "annotation")
highlight("float", "annotation")
highlight("atom", "annotation")
highlight("binary", "annotation")
highlight("list", "annotation")
highlight("tuple", "annotation")
highlight("map", "annotation")
highlight("pid", "annotation")
highlight("reference", "annotation")
highlight("fun", "annotation")
highlight("term", "annotation")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("=/=", "operator")
highlight("=:=", "operator")
highlight("=!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("=<", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("div", "operator")
highlight("rem", "operator")
highlight("band", "operator")
highlight("bor", "operator")
highlight("bxor", "operator")
highlight("bsl", "operator")
highlight("bsr", "operator")
highlight("!", "operator")
highlight("++", "operator")
highlight("--", "operator")
highlight("->", "operator")
highlight("<-", "operator")
highlight("::", "operator")

-- Special Characters
highlight("(", "binary")
highlight(")", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("{", "binary")
highlight("}", "binary")
highlight(",", "binary")
highlight(";", "binary")
highlight(".", "binary")
highlight(":", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("%", "", "comments", true)

-- Comments
add_comment("Erlang: the language designed for phones, used for chats")
add_comment("If it works, let it crash")
add_comment("Everything is a process, including your sanity")
add_comment("Lists and tuples are enemies forever")
add_comment("Pattern matching everything, including your patience")
add_comment("BEAM is a virtual machine, not a lighting rig")

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
        local variable = line:match("([%u_][%w_]*)")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end