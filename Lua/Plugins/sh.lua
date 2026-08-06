-- Highlight Keywords
highlight("if", "reserved")
highlight("then", "reserved")
highlight("else", "reserved")
highlight("elif", "reserved")
highlight("fi", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("until", "reserved")
highlight("do", "reserved")
highlight("done", "reserved")
highlight("case", "reserved")
highlight("esac", "reserved")
highlight("in", "reserved")
highlight("function", "reserved")
highlight("select", "reserved")
highlight("time", "reserved")

highlight("echo", "reserved")
highlight("printf", "reserved")
highlight("read", "reserved")
highlight("set", "reserved")
highlight("unset", "reserved")
highlight("export", "reserved")
highlight("declare", "reserved")
highlight("local", "reserved")
highlight("return", "reserved")
highlight("exit", "reserved")
highlight("break", "reserved")
highlight("continue", "reserved")
highlight("shift", "reserved")
highlight("source", "reserved")
highlight("alias", "reserved")
highlight("unalias", "reserved")
highlight("trap", "reserved")
highlight("exec", "reserved")
highlight("eval", "reserved")
highlight("kill", "reserved")
highlight("wait", "reserved")
highlight("test", "reserved")
highlight("pwd", "function")
highlight("cd", "function")
highlight("ls", "function")
highlight("mkdir", "function")
highlight("rm", "function")
highlight("cp", "function")
highlight("mv", "function")
highlight("grep", "function")
highlight("sed", "function")
highlight("awk", "function")
highlight("curl", "function")
highlight("wget", "function")
highlight("find", "function")
highlight("chmod", "function")
highlight("chown", "function")
highlight("touch", "function")
highlight("cat", "function")
highlight("sudo", "function")
highlight("git", "function")

highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")

-- Operators
highlight("=", "operator")
highlight("-eq", "operator")
highlight("-ne", "operator")
highlight("-gt", "operator")
highlight("-lt", "operator")
highlight("-ge", "operator")
highlight("-le", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">>", "operator")
highlight("<<", "operator")
highlight("$", "operator")
highlight("$(", "operator")
highlight("$(( ", "operator")
highlight("))", "operator")
highlight("-f", "operator")
highlight("-d", "operator")
highlight("-e", "operator")
highlight("-z", "operator")
highlight("-n", "operator")
highlight("-x", "operator")
highlight("-w", "operator")

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

-- Comments
add_comment("sudo rm -rf / is the only way to fix Windows")
add_comment("Have you tried turning it off and on with systemctl?")
add_comment("echo it, grep it, pipe it, regret it")
add_comment("The shell script works. Don't ask why.")
add_comment("Alias cd to something that actually works")
add_comment("I use arch btw")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(%s*%)")
        if not functionName then
            functionName = line:match("%s*([%w_]+)%s*%(%)%s*%{")
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
        local variable = line:match("%s*([%w_]+)%s*=")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end