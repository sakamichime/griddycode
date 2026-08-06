-- Highlight Keywords
highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")
highlight("~", "binary")
highlight("yes", "binary")
highlight("no", "binary")
highlight("on", "binary")
highlight("off", "binary")

-- Anchors
highlight("-", "symbol")
highlight("---", "symbol")
highlight("...", "symbol")

-- Common keys
highlight("key", "member")
highlight("value", "member")
highlight("type", "member")
highlight("version", "member")
highlight("name", "member")
highlight("tags", "member")
highlight("env", "member")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight(":", "operator")
highlight("&", "operator")
highlight("*", "operator")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("#", "", "comments", true)

-- Comments
add_comment("YAML: the language where indentation is a personality test")
add_comment("Two spaces. That's all it takes to break production")
add_comment("It's not JSON, it's a philosophy")
add_comment("Ansible: YAML with extra steps and fewer clues")
add_comment("Your CI failed because of a tab")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local variable = line:match("%s*([%w_][%w_%-]*)%s*:%s*")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end