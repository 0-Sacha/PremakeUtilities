
Solution.Name = ""

Solution.Projects = {}

local ProjectTemplate = {}
ProjectTemplate.Path = nil
ProjectTemplate.HeaderOnly = false
ProjectTemplate.Type = "ConsoleApp"
ProjectTemplate.PlatformDefineName = nil
ProjectTemplate.Defines = {}
ProjectTemplate.IncludeDirs = {}
ProjectTemplate.Links = {}
ProjectTemplate.ProjectDependencies = {}

Solution.AddProject = function(name, path)
    Solution.Projects[name] = Solution.TableShallowCopy(ProjectTemplate)
    Solution.Projects[name].Path = path
end

Solution._IncludeProject = function(projectName)
    data = Solution.Projects[projectName]
    if data == nil then
        printf("NOT a Valid Project: '%s' !!", projectName)
        return
    end
    
    if data.PlatformDefineName ~= nil then
        Solution.PlatformDefines(data.PlatformDefineName)
    end

    if data.IncludeDirs ~= nil then
        for _, include_path in ipairs(data.IncludeDirs) do
            includedirs (include_path)
        end
    end

    if data.Defines ~= nil then
        for _, define in ipairs(data.Defines) do
            defines (define)
        end
    end

    if data.Links ~= nil then
        for _, project_to_link in ipairs(data.Links) do
            printf("Using the Solution.Projects.Links is weird '%s'", project_to_link)
            links (project_to_link)
        end
    end

    if data.ProjectDependencies ~= nil then
        for _, projectDependencies in ipairs(data.ProjectDependencies) do
            printf("Recursively add dependencies of '%s' -> '%s'", projectName, projectDependencies)
            Solution._IncludeAndLinkProject(projectDependencies)
        end
    end
end


Solution._IncludeAndLinkProject = function(projectName)
    Solution._IncludeProject(projectName)

    data = Solution.Projects[projectName]
    if data == nil then
        return
    end
    if data.HeaderOnly ~= nil then
        if data.HeaderOnly ~= true then
            links (projectName)
        end
    end
end

Solution.Project = function(prefix)
	includedirs { "." }
	Solution._IncludeProject(prefix)
end
