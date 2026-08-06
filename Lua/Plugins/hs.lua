-- Highlight Keywords
highlight("module", "reserved")
highlight("where", "reserved")
highlight("import", "reserved")
highlight("qualified", "reserved")
highlight("as", "reserved")
highlight("hiding", "reserved")
highlight("data", "reserved")
highlight("type", "reserved")
highlight("newtype", "reserved")
highlight("class", "reserved")
highlight("instance", "reserved")
highlight("deriving", "reserved")
highlight("if", "reserved")
highlight("then", "reserved")
highlight("else", "reserved")
highlight("case", "reserved")
highlight("of", "reserved")
highlight("let", "reserved")
highlight("in", "reserved")
highlight("do", "reserved")
highlight("forall", "reserved")
highlight("infix", "reserved")
highlight("infixl", "reserved")
highlight("infixr", "reserved")
highlight("foreign", "reserved")
highlight("pattern", "reserved")
highlight("family", "reserved")
highlight("role", "reserved")
highlight("default", "reserved")
highlight("mdo", "reserved")
highlight("rec", "reserved")

highlight("True", "binary")
highlight("False", "binary")
highlight("Nothing", "binary")
highlight("undefined", "binary")

-- Type annotations
highlight("Int", "annotation")
highlight("Integer", "annotation")
highlight("Float", "annotation")
highlight("Double", "annotation")
highlight("Bool", "annotation")
highlight("Char", "annotation")
highlight("String", "annotation")
highlight("Maybe", "annotation")
highlight("Either", "annotation")
highlight("IO", "annotation")
highlight("List", "annotation")
highlight("Ordering", "annotation")
highlight("Show", "annotation")
highlight("Read", "annotation")
highlight("Eq", "annotation")
highlight("Ord", "annotation")
highlight("Functor", "annotation")
highlight("Applicative", "annotation")
highlight("Monad", "annotation")
highlight("Semigroup", "annotation")
highlight("Monoid", "annotation")
highlight("Foldable", "annotation")
highlight("Traversable", "annotation")
highlight("Num", "annotation")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("/=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("^", "operator")
highlight("$", "operator")
highlight("++", "operator")
highlight("::", "operator")
highlight("=>", "operator")
highlight("<-", "operator")
highlight("->", "operator")
highlight(">>", "operator")
highlight(">>=", "operator")
highlight("!", "operator")
highlight(".", "operator")
highlight("<>", "operator")
highlight("\\", "operator")
highlight("|", "operator")
highlight("&", "operator")
highlight("<<<", "operator")
highlight(">>>", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(",", "binary")
highlight(";", "binary")
highlight("_", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("--", "", "comments", true)
highlight_region("{-", "-}", "comments", false)

-- Comments
add_comment("Haskell: the only language where the type system is the boss")
add_comment("Monads are just monoids in the category of endofunctors, duh")
add_comment("It compiles, therefore it works. Probably.")
add_comment("You can't run away from your types")
add_comment("Every Haskell dev is one functor away from enlightenment")
add_comment("Category theory is 90% of the runtime")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*([%w_']+)%s*::")
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
        local variable = line:match("%s*%(%s*(%w+)%s*::")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end