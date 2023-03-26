
Solution.Name = ""

Solution.Projects = {}

Solution.ProjectsInfo = {}
Solution.ProjectsInfo.Defines = {}
Solution.ProjectsInfo.Includes = {}
Solution.ProjectsInfo.Links = {}
Solution.ProjectsInfo.PlatformDefineName = {}

Solution.IncludeProject = function(projectName)
    if Solution.ProjectsInfo.PlatformDefineName ~= nil then
        if Solution.ProjectsInfo.PlatformDefineName[projectName] ~= nil then
            Solution.PlatformDefines(Solution.ProjectsInfo.PlatformDefineName[projectName])
        end
    end

    if Solution.ProjectsInfo.Includes ~= nil then
        if Solution.ProjectsInfo.Includes[projectName] ~= nil then
            for _, include_path in ipairs(Solution.ProjectsInfo.Includes[projectName]) do
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
end


Solution.IncludeAndLinkProject = function(projectName)
    Solution.IncludeProject(projectName)
    links (projectName)
end
