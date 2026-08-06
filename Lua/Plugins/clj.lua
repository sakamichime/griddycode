-- Highlight Keywords
highlight("ns", "reserved")
highlight("def", "reserved")
highlight("defn", "reserved")
highlight("defn-", "reserved")
highlight("defmacro", "reserved")
highlight("defmethod", "reserved")
highlight("defmulti", "reserved")
highlight("defrecord", "reserved")
highlight("deftype", "reserved")
highlight("defprotocol", "reserved")
highlight("defstruct", "reserved")
highlight("fn", "reserved")
highlight("fn*", "reserved")
highlight("if", "reserved")
highlight("if-not", "reserved")
highlight("when", "reserved")
highlight("when-not", "reserved")
highlight("cond", "reserved")
highlight("case", "reserved")
highlight("condp", "reserved")
highlight("do", "reserved")
highlight("let", "reserved")
highlight("letfn", "reserved")
highlight("loop", "reserved")
highlight("recur", "reserved")
highlight("for", "reserved")
highlight("doseq", "reserved")
highlight("dotimes", "reserved")
highlight("while", "reserved")
highlight("doto", "reserved")
highlight("->", "reserved")
highlight("->>", "reserved")
highlight("as->", "reserved")
highlight("some->", "reserved")
highlight("binding", "reserved")
highlight("binding", "reserved")
highlight("lazy-seq", "reserved")
highlight("delay", "reserved")
highlight("future", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("import", "reserved")
highlight("require", "reserved")
highlight("use", "reserved")
highlight("refer", "reserved")
highlight("exclude", "reserved")
highlight("declare", "reserved")
highlight("defonce", "reserved")
highlight("definline", "reserved")
highlight("comment", "reserved")
highlight("->", "operator")
highlight("->>", "operator")

highlight("nil", "binary")
highlight("true", "binary")
highlight("false", "binary")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("not=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("mod", "operator")
highlight("quot", "operator")
highlight("rem", "operator")
highlight("and", "operator")
highlight("or", "operator")
highlight("not", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight(">>>", "operator")
highlight("..", "operator")

-- Special Characters
highlight("(", "binary")
highlight(")", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("{", "binary")
highlight("}", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("\\\"", "\\\"", "string")

-- Comments
highlight_region(";", "", "comments", true)
highlight_region("#_", "", "comments", true)

-- Comments
add_comment("Clojure: Lisp with a JVM and a dream")
add_comment("The parentheses are your friends. Until they aren't.")
add_comment("Everything is a list, even your soul")
add_comment("Immutable data is only immutable until you want it to change")
add_comment("The REPL is the only therapist you need")
add_comment("10x developer, 10x parentheses")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*defn%s+([%w%-%?!]+)")
        if not functionName then
            functionName = line:match("%s*def%s+([%w%-%?!]+)")
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
        local variable = line:match("%s*def%s+([%w%-]+)")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end