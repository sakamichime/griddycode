-- Highlight Keywords
highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")

-- Types
highlight("string", "annotation")
highlight("integer", "annotation")
highlight("float", "annotation")
highlight("boolean", "annotation")
highlight("datetime", "annotation")
highlight("date", "annotation")
highlight("array", "annotation")
highlight("table", "annotation")

-- Common keys
highlight("name", "member")
highlight("version", "member")
highlight("description", "member")
highlight("authors", "member")
highlight("dependencies", "member")
highlight("dev-dependencies", "member")
highlight("features", "member")
highlight("workspace", "member")
highlight("package", "member")
highlight("license", "member")
highlight("repository", "member")
highlight("homepage", "member")
highlight("edition", "member")
highlight("tool", "member")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("=", "operator")
highlight(".", "operator")
highlight(",", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("#", "", "comments", true)

-- Comments
add_comment("TOML: JSON but your config file throws a party")
add_comment("Indentation? We don't do that here")
add_comment("The only format where tabs are legal")
add_comment("toml: because yaml had too many opinions")
add_comment("One wrong quote and the whole build explodes")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local variable = line:match("%s*([%w_][%w_%-]*)%s*=")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end