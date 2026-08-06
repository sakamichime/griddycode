-- Highlight Keywords
highlight("as", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("break", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("crate", "reserved")
highlight("dyn", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("extern", "reserved")
highlight("fn", "reserved")
highlight("for", "reserved")
highlight("if", "reserved")
highlight("impl", "reserved")
highlight("in", "reserved")
highlight("let", "reserved")
highlight("loop", "reserved")
highlight("match", "reserved")
highlight("mod", "reserved")
highlight("move", "reserved")
highlight("mut", "reserved")
highlight("pub", "reserved")
highlight("ref", "reserved")
highlight("return", "reserved")
highlight("self", "reserved")
highlight("static", "reserved")
highlight("struct", "reserved")
highlight("super", "reserved")
highlight("trait", "reserved")
highlight("unsafe", "reserved")
highlight("use", "reserved")
highlight("where", "reserved")
highlight("while", "reserved")

highlight("true", "binary")
highlight("false", "binary")

-- Type annotations
highlight("i8", "annotation")
highlight("i16", "annotation")
highlight("i32", "annotation")
highlight("i64", "annotation")
highlight("i128", "annotation")
highlight("isize", "annotation")
highlight("u8", "annotation")
highlight("u16", "annotation")
highlight("u32", "annotation")
highlight("u64", "annotation")
highlight("u128", "annotation")
highlight("usize", "annotation")
highlight("f32", "annotation")
highlight("f64", "annotation")
highlight("bool", "annotation")
highlight("char", "annotation")
highlight("str", "annotation")
highlight("String", "annotation")
highlight("Option", "annotation")
highlight("Result", "annotation")
highlight("Box", "annotation")
highlight("Vec", "annotation")
highlight("Some", "annotation")
highlight("None", "annotation")

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
highlight("::", "binary")
highlight(":", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("r#\"", "\"#", "string")

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("How many borrow checker errors until you give up?")
add_comment("Rust would rather fail to compile than let you live")
add_comment("No segfaults, but the compiler gaslights you")
add_comment("Lifetime error: the variable wasn't alive long enough to see the panic")
add_comment("Fearless concurrency? More like fearless compilation errors")
add_comment("Safe, fast, and takes 15 minutes to build a hello world")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        -- Match fn declarations
        local functionName = line:match("%s*fn%s+([%w_]+)%s*%(")
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
        -- Match let bindings
        local variable = line:match("%s*let%s+mut%s+([%w_]+)")
        if not variable then
            variable = line:match("%s*let%s+([%w_]+)")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end
