-- Highlight Keywords
highlight("FROM", "reserved")
highlight("RUN", "reserved")
highlight("CMD", "reserved")
highlight("LABEL", "reserved")
highlight("MAINTAINER", "reserved")
highlight("EXPOSE", "reserved")
highlight("ENV", "reserved")
highlight("ADD", "reserved")
highlight("COPY", "reserved")
highlight("ENTRYPOINT", "reserved")
highlight("VOLUME", "reserved")
highlight("USER", "reserved")
highlight("WORKDIR", "reserved")
highlight("ARG", "reserved")
highlight("ONBUILD", "reserved")
highlight("STOPSIGNAL", "reserved")
highlight("HEALTHCHECK", "reserved")
highlight("SHELL", "reserved")
highlight("AS", "reserved")
highlight("formula", "reserved")

-- Common base images
highlight("ubuntu", "annotation")
highlight("alpine", "annotation")
highlight("debian", "annotation")
highlight("centos", "annotation")
highlight("node", "annotation")
highlight("python", "annotation")
highlight("golang", "annotation")
highlight("openjdk", "annotation")
highlight("nginx", "annotation")
highlight("redis", "annotation")
highlight("postgres", "annotation")
highlight("mysql", "annotation")
highlight("mongo", "annotation")
highlight("scratch", "annotation")
highlight("latest", "annotation")

-- Operators
highlight("=", "operator")
highlight("-", "operator")
highlight("--", "operator")
highlight("&&", "operator")
highlight("|", "operator")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
highlight_region("#", "", "comments", true)

-- Comments
add_comment("FROM base:latest # a fate worse than death")
add_comment("Every layer is a memory of a worse decision")
add_comment("The container is a lie. It shuts down when you sleep.")
add_comment("docker build is 90% waiting, 10% panic")
add_comment("It works in my container")
add_comment("Never leave the tag: latest")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local variable = line:match("%s*[Ee][Nn][Vv]%s+([%w_]+)")
        if not variable then
            variable = line:match("%s*ARG%s+([%w_]+)")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end