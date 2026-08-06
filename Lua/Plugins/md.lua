-- Highlight Keywords
highlight("# ", "symbol")
highlight("## ", "symbol")
highlight("### ", "symbol")
highlight("#### ", "symbol")
highlight("##### ", "symbol")
highlight("###### ", "symbol")
highlight("```", "symbol")
highlight("```lua", "symbol")
highlight("```python", "symbol")
highlight("- ", "symbol")
highlight("* ", "symbol")
highlight("> ", "symbol")
highlight("---", "symbol")
highlight("***", "symbol")
highlight("![", "symbol")
highlight("]( ", "symbol")

highlight("**", "symbol")
highlight("__", "symbol")
highlight("`", "string")
highlight("~~", "symbol")

-- Common keys
highlight("title", "member")
highlight("author", "member")
highlight("date", "member")
highlight("tags", "member")

-- Strings
highlight_region("`", "`", "string")

-- Comments
highlight_region("<!--", "-->", "comments", false)

-- Comments
add_comment("Markdown: the markup language for people who hate markup")
add_comment("Everything is a heading, even your problems")
add_comment("Use exact, meaningful language. Or just say stuff.")
add_comment("Try forgetting the closing ```. The code will die.")
add_comment("https://www.example.com is not a link. It's a threat")
add_comment("Spelling optional, formatting mandatory")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    return variable_names
end