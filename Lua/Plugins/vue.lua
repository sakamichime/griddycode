-- Highlight Keywords
highlight("v-if", "reserved")
highlight("v-else", "reserved")
highlight("v-else-if", "reserved")
highlight("v-for", "reserved")
highlight("v-show", "reserved")
highlight("v-model", "reserved")
highlight("v-bind", "reserved")
highlight("v-on", "reserved")
highlight("v-once", "reserved")
highlight("v-html", "reserved")
highlight("v-text", "reserved")
highlight("v-slot", "reserved")
highlight("v-pre", "reserved")
highlight("v-cloak", "reserved")
highlight("v-memo", "reserved")
highlight(":key", "reserved")
highlight(":class", "reserved")
highlight(":style", "reserved")
highlight("@click", "reserved")
highlight("@change", "reserved")
highlight("@input", "reserved")
highlight("@submit", "reserved")
highlight("export", "reserved")
highlight("default", "reserved")
highlight("from", "reserved")
highlight("import", "reserved")
highlight("const", "reserved")
highlight("let", "reserved")
highlight("var", "reserved")
highlight("new", "reserved")
highlight("function", "reserved")
highlight("return", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("this", "binary")
highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")
highlight("undefined", "binary")

-- Template tags
highlight("<template>", "symbol")
highlight("</template>", "symbol")
highlight("<script>", "symbol")
highlight("</script>", "symbol")
highlight("<style>", "symbol")
highlight("</style>", "symbol")
highlight("<div>", "symbol")
highlight("</div>", "symbol")
highlight("<span>", "symbol")
highlight("</span>", "symbol")
highlight("<p>", "symbol")
highlight("</p>", "symbol")
highlight("<img>", "symbol")
highlight("<input>", "symbol")
highlight("<button>", "symbol")
highlight("</button>", "symbol")
highlight("<a>", "symbol")
highlight("</a>", "symbol")

-- Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("=", "operator")
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
highlight("!==", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("=>", "operator")
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

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string")

-- Comments
highlight_region("<!--", "-->", "comments", false)
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("Vue: you only need one framework and feelings")
add_comment("The reactivity system is watching you")
add_comment("Computed properties are just vibes with caching")
add_comment("v-model took your brain hostage")
add_comment("It's like a component library, except worse")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(")
        if not functionName then
            functionName = line:match("%s*const%s+([%w_]+)%s*=%s*%(")
        end
        if not functionName then
            functionName = line:match("%s*methods:%s*%{?([%w_]+)")
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
            variable = line:match("%s*data%s*%(%s*%))%s*%{([%w_]+)")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end