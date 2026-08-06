-- Highlight Keywords
highlight("select", "reserved")
highlight("from", "reserved")
highlight("where", "reserved")
highlight("insert", "reserved")
highlight("into", "reserved")
highlight("values", "reserved")
highlight("update", "reserved")
highlight("set", "reserved")
highlight("delete", "reserved")
highlight("create", "reserved")
highlight("alter", "reserved")
highlight("drop", "reserved")
highlight("table", "reserved")
highlight("database", "reserved")
highlight("index", "reserved")
highlight("view", "reserved")
highlight("trigger", "reserved")
highlight("procedure", "reserved")
highlight("function", "reserved")
highlight("begin", "reserved")
highlight("end", "reserved")
highlight("commit", "reserved")
highlight("rollback", "reserved")
highlight("transaction", "reserved")
highlight("grant", "reserved")
highlight("revoke", "reserved")
highlight("union", "reserved")
highlight("all", "reserved")
highlight("distinct", "reserved")
highlight("group", "reserved")
highlight("by", "reserved")
highlight("order", "reserved")
highlight("having", "reserved")
highlight("join", "reserved")
highlight("inner", "reserved")
highlight("left", "reserved")
highlight("right", "reserved")
highlight("outer", "reserved")
highlight("cross", "reserved")
highlight("full", "reserved")
highlight("on", "reserved")
highlight("using", "reserved")
highlight("as", "reserved")
highlight("and", "reserved")
highlight("or", "reserved")
highlight("not", "reserved")
highlight("null", "reserved")
highlight("is", "reserved")
highlight("in", "reserved")
highlight("between", "reserved")
highlight("like", "reserved")
highlight("exists", "reserved")
highlight("case", "reserved")
highlight("when", "reserved")
highlight("then", "reserved")
highlight("else", "reserved")
highlight("limit", "reserved")
highlight("offset", "reserved")
highlight("primary", "reserved")
highlight("foreign", "reserved")
highlight("key", "reserved")
highlight("references", "reserved")
highlight("unique", "reserved")
highlight("check", "reserved")
highlight("default", "reserved")
highlight("constraint", "reserved")
highlight("collate", "reserved")
highlight("asc", "reserved")
highlight("desc", "reserved")
highlight("if", "reserved")
highlight("with", "reserved")
highlight("recursive", "reserved")
highlight("explain", "reserved")
highlight("analyze", "reserved")
highlight("vacuum", "reserved")
highlight("truncate", "reserved")
highlight("rename", "reserved")
highlight("add", "reserved")
highlight("column", "reserved")

-- Type annotations
highlight("int", "annotation")
highlight("integer", "annotation")
highlight("smallint", "annotation")
highlight("bigint", "annotation")
highlight("real", "annotation")
highlight("float", "annotation")
highlight("double", "annotation")
highlight("numeric", "annotation")
highlight("decimal", "annotation")
highlight("text", "annotation")
highlight("varchar", "annotation")
highlight("char", "annotation")
highlight("date", "annotation")
highlight("time", "annotation")
highlight("timestamp", "annotation")
highlight("boolean", "annotation")
highlight("bool", "annotation")
highlight("blob", "annotation")
highlight("serial", "annotation")
highlight("json", "annotation")
highlight("uuid", "annotation")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight("<>", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("||", "operator")
highlight("&&", "operator")
highlight("::", "operator")

-- Special Characters
highlight("(", "binary")
highlight(")", "binary")
highlight(",", "binary")
highlight(";", "binary")

-- Strings
highlight_region("'", "'", "string")
highlight_region("\"", "\"", "string")

-- Comments
highlight_region("--", "", "comments", true)
highlight_region("/*", "*/", "comments", false)
highlight_region("#", "", "comments", true)

-- Comments
add_comment("SELECT * FROM hope WHERE no_bugs = TRUE;")
add_comment("It's not a bug, it's a feature. DELETE FROM bugs;")
add_comment("JOINing tables is how you make friends in SQL")
add_comment("Nothing joins like a LEFT JOIN")
add_comment("Your query is slow. Have you tried indexing it?")
add_comment("DROP DATABASE; -- no one will notice")
add_comment("SELECT excuse FROM excuses WHERE valid = FALSE")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*create%s+function%s+([%w_]+)%s*%(")
        if not functionName then
            functionName = line:match("%s*create%s+or%s+replace%s+function%s+([%w_]+)%s*%(")
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
        local variable = line:match("%s*declare%s+([%w_]+)%s+")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end