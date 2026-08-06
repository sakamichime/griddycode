-- Highlight Keywords
highlight("var", "reserved")
highlight("const", "reserved")
highlight("let", "reserved")
highlight("new", "reserved")
highlight("class", "reserved")
highlight("extends", "reserved")
highlight("implements", "reserved")
highlight("interface", "reserved")
highlight("type", "reserved")
highlight("enum", "reserved")
highlight("namespace", "reserved")
highlight("declare", "reserved")
highlight("abstract", "reserved")
highlight("readonly", "reserved")
highlight("private", "reserved")
highlight("protected", "reserved")
highlight("public", "reserved")
highlight("static", "reserved")
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

highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")
highlight("undefined", "binary")
highlight("this", "binary")

-- React & JSX
highlight("useState", "function")
highlight("useEffect", "function")
highlight("useRef", "function")
highlight("useMemo", "function")
highlight("useCallback", "function")
highlight("useContext", "function")
highlight("useReducer", "function")
highlight("useLayoutEffect", "function")
highlight("useImperativeHandle", "function")
highlight("useDebugValue", "function")
highlight("React", "function")
highlight("Component", "function")
highlight("Fragment", "function")
highlight("Suspense", "function")
highlight("lazy", "function")
highlight("createElement", "function")
highlight("memo", "function")
highlight("forwardRef", "function")
highlight("createContext", "function")
highlight("useTransition", "function")
highlight("useDeferredValue", "function")
highlight("useSyncExternalStore", "function")
highlight("useInsertionEffect", "function")

-- Type annotations
highlight("string", "annotation")
highlight("number", "annotation")
highlight("boolean", "annotation")
highlight("bigint", "annotation")
highlight("symbol", "annotation")
highlight("object", "annotation")
highlight("any", "annotation")
highlight("unknown", "annotation")
highlight("never", "annotation")

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
add_comment("useEffect? more like useEffect for everything")
add_comment("Hooks: you can't call them in a loop, but you can loop yourself into a corner")
add_comment("Rendering 10000 components because the state didn't change")
add_comment("Have you tried adding more dependencies to useEffect?")
add_comment("Prop drilling: the only way to share state")
add_comment("Delete all the dependencies and see what happens")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(")
        if not functionName then
            functionName = line:match("%s*const%s+([%w_]+)%s*=%s*%(")
        end
        if not functionName then
            functionName = line:match("%s*export%s+default%s+function%s+([%w_]+)%s*%(")
        end
        if not functionName then
            functionName = line:match("%s*const%s+([%w_]+)%s*=%s*(%w+)%s*%(")
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
