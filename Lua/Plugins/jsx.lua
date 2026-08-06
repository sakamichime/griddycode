-- Highlight Keywords
highlight("var", "reserved")
highlight("const", "reserved")
highlight("let", "reserved")
highlight("new", "reserved")
highlight("class", "reserved")
highlight("extends", "reserved")
highlight("function", "reserved")
highlight("return", "reserved")
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
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("import", "reserved")
highlight("export", "reserved")
highlight("from", "reserved")
highlight("as", "reserved")
highlight("in", "reserved")
highlight("of", "reserved")
highlight("yield", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("typeof", "reserved")
highlight("instanceof", "reserved")
highlight("void", "reserved")
highlight("delete", "reserved")
highlight("this", "binary")

highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")
highlight("undefined", "binary")
highlight("NaN", "binary")

-- React & JSX
highlight("useState", "function")
highlight("useEffect", "function")
highlight("useRef", "function")
highlight("useMemo", "function")
highlight("useCallback", "function")
highlight("useContext", "function")
highlight("useReducer", "function")
highlight("React", "function")
highlight("Component", "function")
highlight("Fragment", "function")
highlight("Suspense", "function")
highlight("lazy", "function")
highlight("createElement", "function")
highlight("memo", "function")
highlight("forwardRef", "function")
highlight("createContext", "function")
highlight("render", "function")
highlight("return(" , "reserved")

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
highlight("===", "operator")
highlight("!==", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("??", "operator")
highlight("!", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight(">>>", "operator")
highlight("=>", "operator")
highlight("?.", "operator")
highlight("...", "operator")

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
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("JSX: HTML inside JavaScript, what could go wrong")
add_comment("If you can't explain it in a component, decompose it")
add_comment("Rendering nothing? Check your parentheses")
add_comment("The key prop is not optional. Ask anyone")
add_comment("Every rerender is a promise broken")
add_comment("Pure components, impure devs")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(")
        if not functionName then
            functionName = line:match("%s*const%s+([%w_]+)%s*=%s*(%w+)%s*%(")
        end
        if not functionName then
            functionName = line:match("%s*export%s+default%s+function%s+([%w_]+)%s*%(")
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
        local variable = line:match("%s*const%s+([%w_]+)%s*=")
        if not variable then
            variable = line:match("%s*let%s+([%w_]+)%s*=")
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