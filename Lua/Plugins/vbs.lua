-- Highlight Keywords
highlight("Dim", "reserved")
highlight("Set", "reserved")
highlight("Const", "reserved")
highlight("Public", "reserved")
highlight("Private", "reserved")
highlight("Function", "reserved")
highlight("Sub", "reserved")
highlight("End Function", "reserved")
highlight("End Sub", "reserved")
highlight("If", "reserved")
highlight("Then", "reserved")
highlight("ElseIf", "reserved")
highlight("Else", "reserved")
highlight("End If", "reserved")
highlight("Select Case", "reserved")
highlight("Case", "reserved")
highlight("End Select", "reserved")
highlight("For", "reserved")
highlight("To", "reserved")
highlight("Step", "reserved")
highlight("Next", "reserved")
highlight("For Each", "reserved")
highlight("In", "reserved")
highlight("Do", "reserved")
highlight("While", "reserved")
highlight("Until", "reserved")
highlight("Loop", "reserved")
highlight("Exit", "reserved")
highlight("Exit For", "reserved")
highlight("Exit Do", "reserved")
highlight("Exit Function", "reserved")
highlight("Exit Sub", "reserved")
highlight("Call", "reserved")
highlight("GoTo", "reserved")
highlight("On Error", "reserved")
highlight("Resume", "reserved")
highlight("With", "reserved")
highlight("End With", "reserved")
highlight("Class", "reserved")
highlight("End Class", "reserved")
highlight("Option Explicit", "reserved")
highlight("Option Base", "reserved")
highlight("ReDim", "reserved")
highlight("Preserve", "reserved")
highlight("Neither", "reserved")
highlight("Nothing", "reserved")
highlight("Empty", "reserved")
highlight("True", "binary")
highlight("False", "binary")
highlight("Null", "binary")
highlight("Nothing", "binary")

-- Operators
highlight("=", "operator")
highlight("<>", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("Mod", "operator")
highlight("And", "operator")
highlight("Or", "operator")
highlight("Not", "operator")
highlight("Xor", "operator")
highlight("Is", "operator")
highlight("Like", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight(",", "binary")

-- Strings
highlight_region("\"", "\"", "string")

-- Comments
highlight_region("'", "", "comments", true)

-- Comments
add_comment("VBS: for auditing your Windows desk before leaving it")
add_comment("Set objNothing = CreateObject(\"Nothing\")")
add_comment("MsgBox is a personality test")
add_comment("Every VBS is one typo from a popup infinity")
add_comment("On Error Resume Next is the official VBS motto")
add_comment("Windows Scripting Host: scripting with extra hostility")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*Function%s+([%w_]+)")
        if not functionName then
            functionName = line:match("%s*Sub%s+([%w_]+)")
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
        local variable = line:match("%s*Dim%s+([%w_]+)")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end