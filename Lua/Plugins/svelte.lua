-- Highlight Keywords
highlight("let", "reserved")
highlight("const", "reserved")
highlight("var", "reserved")
highlight("export", "reserved")
highlight("import", "reserved")
highlight("from", "reserved")
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
highlight("async", "reserved")
highlight("await", "reserved")
highlight("new", "reserved")
highlight("class", "reserved")
highlight("extends", "reserved")
highlight("yield", "reserved")
highlight("this", "binary")
highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")
highlight("undefined", "binary")

-- Svelte directives
highlight("{#if}", "symbol")
highlight("{:else if}", "symbol")
highlight("{:else}", "symbol")
highlight("{/if}", "symbol")
highlight("{#each}", "symbol")
highlight("{:else}", "symbol")
highlight("{/each}", "symbol")
highlight("{#await}", "symbol")
highlight("{:then}", "symbol")
highlight("{:catch}", "symbol")
highlight("{/await}", "symbol")
highlight("{#key}", "symbol")
highlight("{/key}", "symbol")
highlight("{@html}", "symbol")
highlight("{@debug}", "symbol")
highlight("{@const}", "symbol")
highlight("on:click", "reserved")
highlight("on:change", "reserved")
highlight("on:input", "reserved")
highlight("on:submit", "reserved")
highlight("bind:value", "reserved")
highlight("bind:this", "reserved")
highlight("bind:group", "reserved")
highlight("bind:checked", "reserved")
highlight("class:active", "reserved")
highlight("style:color", "reserved")
highlight("use:action", "reserved")
highlight("transition:fade", "reserved")
highlight("transition:fly", "reserved")
highlight("in:fly", "reserved")
highlight("out:fly", "reserved")
highlight("animate:flip", "reserved")
highlight("svelte:component", "reserved")
highlight("svelte:window", "reserved")
highlight("svelte:body", "reserved")
highlight("svelte:head", "reserved")
highlight("svelte:options", "reserved")
highlight("svelte:element", "reserved")
highlight("$derived", "reserved")
highlight("$state", "reserved")
highlight("$effect", "reserved")
highlight("$props", "reserved")
highlight("$bindable", "reserved")
highlight("$inspect", "reserved")
highlight("$host", "reserved")

-- Template tags
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
highlight("<button>", "symbol")
highlight("</button>", "symbol")

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
highlight("??", "operator")
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
add_comment("Svelte: compiles away your problems")
add_comment("Reactivity is free here. No hook fees.")
add_comment("$state is the state of being confused")
add_comment("Compiler magic: the code writes itself")
add_comment("Smaller bundles, bigger ego")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*function%s+([%w_]+)%s*%(")
        if not functionName then
            functionName = line:match("%s*const%s+([%w_]+)%s*=%s*%(")
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
        local variable = line:match("%s*let%s+([%w_]+)%s*=")
        if not variable then
            variable = line:match("%s*const%s+([%w_]+)%s*=")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end