
Solution.Name = ""

Solution.Projects = {}

Solution.ProjectsInfo = {}
Solution.ProjectsInfo.Defines = {}
Solution.ProjectsInfo.IncludeDirs = {}
Solution.ProjectsInfo.Links = {}
Solution.ProjectsInfo.ProjectDependencies = {}
Solution.ProjectsInfo.HeaderOnly = {}
Solution.ProjectsInfo.PlatformDefineName = {}

Solution.IncludeProject = function(projectName)
    if Solution.ProjectsInfo.PlatformDefineName ~= nil then
        if Solution.ProjectsInfo.PlatformDefineName[projectName] ~= nil then
            Solution.PlatformDefines(Solution.ProjectsInfo.PlatformDefineName[projectName])
        end
    end

    if Solution.ProjectsInfo.IncludeDirs ~= nil then
        if Solution.ProjectsInfo.IncludeDirs[projectName] ~= nil then
            for _, include_path in ipairs(Solution.ProjectsInfo.IncludeDirs[projectName]) do
                includedirs (include_path)
            end
        end
    end

    if Solution.ProjectsInfo.Defines ~= nil then
        if Solution.ProjectsInfo.Defines[projectName] ~= nil then
            for _, define in ipairs(Solution.ProjectsInfo.Defines[projectName]) do
                defines (define)
            end
        end
    end

    if Solution.ProjectsInfo.Links ~= nil then
        if Solution.ProjectsInfo.Links[projectName] ~= nil then
            for _, project_to_link in ipairs(Solution.ProjectsInfo.Links[projectName]) do
                links (project_to_link)
            end
        end
    end

    if Solution.ProjectsInfo.Links ~= nil then
        if Solution.ProjectsInfo.Links[projectName] ~= nil then
            for _, project_to_link in ipairs(Solution.ProjectsInfo.Links[projectName]) do
                printf("Using the Solution.ProjectsInfo.Links is weird '%s'", project_to_link)
                links (project_to_link)
            end
        end
    end

    if Solution.ProjectsInfo.ProjectDependencies ~= nil then
        if Solution.ProjectsInfo.ProjectDependencies[projectName] ~= nil then
            for _, project_dependencies in ipairs(Solution.ProjectsInfo.ProjectDependencies[projectName]) do
                printf("Recusivelly add dependencies of '%s' -> '%s'", projectName, project_dependencies)
                Solution.IncludeAndLinkProject(project_dependencies)
            end
        end
    end
end


Solution.IncludeAndLinkProject = function(projectName)
    Solution.IncludeProject(projectName)

    if Solution.ProjectsInfo.HeaderOnly ~= nil then
        if Solution.ProjectsInfo.HeaderOnly[projectName] == nil or Solution.ProjectsInfo.HeaderOnly[projectName] ~= true then
            links (projectName)
        end
    end
end

Solution.Project = function(prefix)
	includedirs { "." }
	Solution.IncludeProject(prefix)
end
