-- Highlight Keywords
highlight("@echo", "reserved")
highlight("off", "reserved")
highlight("on", "reserved")
highlight("echo", "reserved")
highlight("set", "reserved")
highlight("setlocal", "reserved")
highlight("endlocal", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("for", "reserved")
highlight("in", "reserved")
highlight("do", "reserved")
highlight("goto", "reserved")
highlight("call", "reserved")
highlight("rem", "reserved")
highlight("exit", "reserved")
highlight("exit /b", "reserved")
highlight("pause", "reserved")
highlight("title", "reserved")
highlight("color", "reserved")
highlight("cls", "reserved")
highlight("mkdir", "reserved")
highlight("rmdir", "reserved")
highlight("del", "reserved")
highlight("copy", "reserved")
highlight("xcopy", "reserved")
highlight("move", "reserved")
highlight("ren", "reserved")
highlight("type", "reserved")
highlight("dir", "reserved")
highlight("cd", "reserved")
highlight("chdir", "reserved")
highlight("pushd", "reserved")
highlight("popd", "reserved")
highlight("start", "reserved")
highlight("timeout", "reserved")
highlight("choice", "reserved")
highlight("find", "reserved")
highlight("findstr", "reserved")
highlight("sort", "reserved")
highlight("tasklist", "reserved")
highlight("taskkill", "reserved")
highlight("ping", "reserved")
highlight("ipconfig", "reserved")
highlight("net", "reserved")
highlight("sc", "reserved")
highlight("wmic", "reserved")
highlight("where", "reserved")
highlight("assoc", "reserved")
highlight("ftype", "reserved")
highlight("shutdown", "reserved")
highlight("runas", "reserved")
highlight("reg", "reserved")
highlight("schtasks", "reserved")
highlight("certutil", "reserved")
highlight("expand", "reserved")
highlight("fc", "reserved")
highlight("more", "reserved")
highlight("verify", "reserved")
highlight("vol", "reserved")
highlight("label", "reserved")
highlight("tree", "reserved")
highlight("attrib", "reserved")

highlight("true", "binary")
highlight("false", "binary")
highlight("errorlevel", "binary")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("equ", "operator")
highlight("neq", "operator")
highlight("lss", "operator")
highlight("leq", "operator")
highlight("gtr", "operator")
highlight("geq", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("|", "operator")
highlight(">", "operator")
highlight(">>", "operator")
highlight("<", "operator")
highlight("&", "operator")
highlight("%%", "operator")
highlight("+", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight(",", "binary")
highlight(";", "binary")
highlight(":", "binary")

-- Strings
highlight_region("\"", "\"", "string")

-- Comments
highlight_region("::", "", "comments", true)
highlight_region("REM", "", "comments", true)

-- Comments
add_comment("Batch: the language that runs on the Windows you abandoned")
add_comment("Every batch file is a time machine to 1995")
add_comment("Error levels are just suggestions")
add_comment("IF EXIST windows GOTO back_to_linux")
add_comment("Pause: the only reliable command")
add_comment("It's not deprecated, it's retro")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local variable = line:match("%%([%w_]+)%%")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end