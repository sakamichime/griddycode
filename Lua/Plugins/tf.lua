-- Highlight Keywords
highlight("terraform", "reserved")
highlight("provider", "reserved")
highlight("resource", "reserved")
highlight("data", "reserved")
highlight("variable", "reserved")
highlight("output", "reserved")
highlight("module", "reserved")
highlight("locals", "reserved")
highlight("backend", "reserved")
highlight("required_providers", "reserved")
highlight("required_version", "reserved")
highlight("for_each", "reserved")
highlight("count", "reserved")
highlight("depends_on", "reserved")
highlight("lifecycle", "reserved")
highlight("internet", "reserved")
highlight("remote", "reserved")
highlight("template", "reserved")
highlight("import", "reserved")
highlight("moved", "reserved")
highlight("warn", "reserved")

-- Common providers
highlight("aws", "annotation")
highlight("azurerm", "annotation")
highlight("google", "annotation")
highlight("kubernetes", "annotation")
highlight("docker", "annotation")
highlight("github", "annotation")
highlight("null", "annotation")
highlight("random", "annotation")
highlight("aws_instance", "annotation")
highlight("aws_s3_bucket", "annotation")
highlight("aws_vpc", "annotation")
highlight("aws_subnet", "annotation")
highlight("aws_security_group", "annotation")
highlight("aws_iam_role", "annotation")
highlight("aws_iam_policy", "annotation")
highlight("google_compute_instance", "annotation")
highlight("google_storage_bucket", "annotation")
highlight("azurerm_resource_group", "annotation")
highlight("azurerm_virtual_network", "annotation")
highlight("kubernetes_deployment", "annotation")
highlight("kubernetes_namespace", "annotation")

highlight("true", "binary")
highlight("false", "binary")
highlight("null", "binary")

-- Arguments
highlight("name", "member")
highlight("ami", "member")
highlight("instance_type", "member")
highlight("region", "member")
highlight("bucket", "member")
highlight("key", "member")
highlight("private_key", "member")
highlight("public_key", "member")
highlight("vpc_id", "member")
highlight("subnet_id", "member")
highlight("cidr_block", "member")
highlight("tags", "member")
highlight("count", "member")
highlight("enabled", "member")
highlight("source", "member")
highlight("image", "member")
highlight("platform", "member")
highlight("username", "member")
highlight("password", "member")
highlight("token", "member")
highlight("endpoint", "member")
highlight("url", "member")
highlight("environment", "member")
highlight("version", "member")
highlight("command", "member")
highlight("entry_point", "member")

-- Operators
highlight("=", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("?", "operator")
highlight(":", "operator")
highlight("=~", "operator")
highlight("...", "operator")
highlight("->", "operator")
highlight("=>", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(",", "binary")
highlight(".", "binary")
highlight("${", "binary")
highlight("${var.", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("\"\"\"", "\"\"\"", "string")

-- Comments
highlight_region("#", "", "comments", true)
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)

-- Comments
add_comment("Terraform: declare your infra, blame your coworker")
add_comment("terraform plan is the crystal ball")
add_comment("If it's not in the state file, it never happened")
add_comment("HCL is JSON's country cousin")
add_comment("The provider locked you out of your own infra")
add_comment("apply: where lambdas and pager duty go to fight")
add_comment("Backups are easier than state file archaeology")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local variable = line:match("%s*variable%s+[\"']([%w_]+)[\"']")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end