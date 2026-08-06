-- Highlight Keywords
highlight("func", "reserved")
highlight("let", "reserved")
highlight("var", "reserved")
highlight("class", "reserved")
highlight("struct", "reserved")
highlight("enum", "reserved")
highlight("protocol", "reserved")
highlight("extension", "reserved")
highlight("actor", "reserved")
highlight("associatedtype", "reserved")
highlight("typealias", "reserved")
highlight("import", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("guard", "reserved")
highlight("switch", "reserved")
highlight("case", "reserved")
highlight("default", "reserved")
highlight("for", "reserved")
highlight("while", "reserved")
highlight("repeat", "reserved")
highlight("do", "reserved")
highlight("break", "reserved")
highlight("continue", "reserved")
highlight("fallthrough", "reserved")
highlight("return", "reserved")
highlight("throw", "reserved")
highlight("throws", "reserved")
highlight("rethrows", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")
highlight("defer", "reserved")
highlight("in", "reserved")
highlight("as", "reserved")
highlight("is", "reserved")
highlight("where", "reserved")
highlight("mutating", "reserved")
highlight("nonmutating", "reserved")
highlight("override", "reserved")
highlight("open", "reserved")
highlight("public", "reserved")
highlight("internal", "reserved")
highlight("fileprivate", "reserved")
highlight("private", "reserved")
highlight("static", "reserved")
highlight("final", "reserved")
highlight("lazy", "reserved")
highlight("weak", "reserved")
highlight("unowned", "reserved")
highlight("required", "reserved")
highlight("convenience", "reserved")
highlight("init", "reserved")
highlight("deinit", "reserved")
highlight("subscript", "reserved")
highlight("self", "reserved")
highlight("super", "reserved")
highlight("some", "reserved")
highlight("any", "reserved")
highlight("indirect", "reserved")
highlight("precedencegroup", "reserved")

highlight("true", "binary")
highlight("false", "binary")
highlight("nil", "binary")

-- Type annotations
highlight("Int", "annotation")
highlight("Int8", "annotation")
highlight("Int16", "annotation")
highlight("Int32", "annotation")
highlight("Int64", "annotation")
highlight("UInt", "annotation")
highlight("UInt8", "annotation")
highlight("UInt16", "annotation")
highlight("UInt32", "annotation")
highlight("UInt64", "annotation")
highlight("Float", "annotation")
highlight("Double", "annotation")
highlight("Bool", "annotation")
highlight("String", "annotation")
highlight("Character", "annotation")
highlight("Array", "annotation")
highlight("Dictionary", "annotation")
highlight("Set", "annotation")
highlight("Optional", "annotation")
highlight("Void", "annotation")

-- Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight("===", "operator")
highlight("!==", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight("..<", "operator")
highlight("...", "operator")
highlight("??", "operator")
highlight("->", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(";", "binary")
highlight(",", "binary")
highlight(":", "binary")
highlight("?", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("\"\"\"", "\"\"\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("Swift: for when you want your compiler to also judge you")
add_comment("Optionals: nil is a feature, not a bug")
add_comment("Force unwrap it. Trust me, it will be fine.")
add_comment("UIKit to SwiftUI and back again. Every week.")
add_comment("Protocols, extensions, generics... just make the app, Tim")
add_comment("Everything crashes on the main thread")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*func%s+([%w_]+)%s*%(")
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
        local variable = line:match("%s*let%s+([%w_]+)%s*:")
        if not variable then
            variable = line:match("%s*var%s+([%w_]+)%s*:")
        end
        if not variable then
            variable = line:match("%s*let%s+([%w_]+)%s*=")
        end
        if not variable then
            variable = line:match("%s*var%s+([%w_]+)%s*=")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end
