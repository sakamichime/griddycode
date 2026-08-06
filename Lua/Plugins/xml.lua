-- Highlight Keywords
highlight("version", "reserved")
highlight("encoding", "reserved")
highlight("standalone", "reserved")
highlight("xmlns", "reserved")
highlight("schemaLocation", "reserved")
highlight("noNamespaceSchemaLocation", "reserved")

-- Common elements
highlight("root", "symbol")
highlight("item", "symbol")
highlight("name", "member")
highlight("id", "member")
highlight("value", "member")
highlight("type", "member")
highlight("class", "member")
highlight("style", "member")
highlight("href", "member")
highlight("src", "member")
highlight("alt", "member")
highlight("title", "member")
highlight("lang", "member")
highlight("key", "member")
highlight("ref", "member")

-- Special Characters
highlight("<", "operator")
highlight(">", "operator")
highlight("</", "operator")
highlight("/>", "operator")
highlight("<?", "operator")
highlight("?>", "operator")
highlight("<![CDATA[", "symbol")
highlight("]]>", "symbol")
highlight("<!DOCTYPE", "symbol")
highlight("<!--", "comments")
highlight("-->", "comments")
highlight("=", "operator")
highlight(":", "operator")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("<!--", "-->", "comments", false)

-- Comments
add_comment("XML: because HTML wasn't annoying enough")
add_comment("Every tag opened must be closed. No exceptions.")
add_comment("CDATA is where strings go to feel safe")
add_comment("It's not a programming language, it's a commitment")
add_comment("Your XML parser left the chat")
add_comment("One unescaped & and the whole file dies")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local variable = line:match("([%w_%-]+)%s*=")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end