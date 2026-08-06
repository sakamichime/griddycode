-- Highlight Keywords
highlight("if", "reserved")
highlight("else", "reserved")
highlight("else if", "reserved")
highlight("repeat", "reserved")
highlight("while", "reserved")
highlight("for", "reserved")
highlight("in", "reserved")
highlight("function", "reserved")
highlight("return", "reserved")
highlight("break", "reserved")
highlight("next", "reserved")
highlight("switch", "reserved")
highlight("case", "reserved")
highlight("library", "reserved")
highlight("require", "reserved")
highlight("source", "reserved")
highlight("attach", "reserved")
highlight("detach", "reserved")
highlight("missing", "reserved")
highlight("global", "reserved")
highlight("TRUE", "binary")
highlight("FALSE", "binary")
highlight("NULL", "binary")
highlight("NA", "binary")
highlight("NaN", "binary")
highlight("Inf", "binary")
highlight("T", "binary")
highlight("F", "binary")

-- Common functions
highlight("print", "function")
highlight("cat", "function")
highlight("str", "function")
highlight("paste", "function")
highlight("length", "function")
highlight("nrow", "function")
highlight("ncol", "function")
highlight("dim", "function")
highlight("summary", "function")
highlight("head", "function")
highlight("tail", "function")
highlight("mean", "function")
highlight("median", "function")
highlight("sd", "function")
highlight("var", "function")
highlight("sum", "function")
highlight("min", "function")
highlight("max", "function")
highlight("range", "function")
highlight("c", "function")
highlight("cbind", "function")
highlight("rbind", "function")
highlight("list", "function")
highlight("data.frame", "function")
highlight("read.csv", "function")
highlight("read.table", "function")
highlight("write.csv", "function")
highlight("write.table", "function")
highlight("plot", "function")
highlight("ggplot", "function")
highlight("lm", "function")
highlight("glm", "function")
highlight("t.test", "function")
highlight("install.packages", "function")
highlight("setwd", "function")
highlight("getwd", "function")
highlight("factor", "function")
highlight("as.numeric", "function")
highlight("as.character", "function")
highlight("as.factor", "function")
highlight("ifelse", "function")
highlight("apply", "function")
highlight("lapply", "function")
highlight("sapply", "function")
highlight("table", "function")
highlight("paste0", "function")
highlight("strsplit", "function")
highlight("substr", "function")
highlight("gsub", "function")
highlight("grepl", "function")
highlight("which", "function")
highlight("unique", "function")
highlight("duplicated", "function")
highlight("seq", "function")
highlight("rep", "function")
highlight("matrix", "function")

-- Operators
highlight("=", "operator")
highlight("<-", "operator")
highlight("->", "operator")
highlight("<<-", "operator")
highlight("->>", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&", "operator")
highlight("&&", "operator")
highlight("|", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("^", "operator")
highlight("%%", "operator")
highlight("%/%", "operator")
highlight("%*%", "operator")
highlight(":", "operator")
highlight("$", "operator")
highlight("::", "operator")
highlight(":::", "operator")
highlight("%in%", "operator")
highlight("%>%", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(",", "binary")
highlight(";", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string")

-- Comments
highlight_region("#", "", "comments", true)

-- Comments
add_comment("R: the language where your data dies with your sanity")
add_comment("If it's not a data.frame, does it even exist?")
add_comment("R plots: where the axis labels go to die")
add_comment("You'll spend 3 hours fixing a factor ordering")
add_comment("The pipe operator flows like the tears")
add_comment("Stats were not meant to be this hard")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*([%w_%.]+)%s*<-%s*function")
        if not functionName then
            functionName = line:match("%s*function%s*%(%s*([%w_]*")
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
        local variable = line:match("%s*([%w_%.]+)%s*<-")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end