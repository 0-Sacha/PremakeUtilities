
Solution.Name = ""

Solution.Projects = {}

Solution.ProjectsInfo = {}
Solution.ProjectsInfo.Defines = {}
Solution.ProjectsInfo.Includes = {}
Solution.ProjectsInfo.Links = {}

Solution.IncludeProject = function(str)
    if Solution.ProjectsInfo.Includes ~= nil then
        if Solution.ProjectsInfo.Includes[str] ~= nil then
            for _, value in ipairs(Solution.ProjectsInfo.Includes[str]) do
                includedirs (value)
            end
        end
    end

    if Solution.ProjectsInfo.Defines ~= nil then
        if Solution.ProjectsInfo.Defines[str] ~= nil then
            for _, value in ipairs(Solution.ProjectsInfo.Defines[str]) do
                defines (value)
            end
        end
    end

    if Solution.ProjectsInfo.Links ~= nil then
        if Solution.ProjectsInfo.Links[str] ~= nil then
            for _, value in ipairs(Solution.ProjectsInfo.Links[str]) do
                links (value)
            end
        end
    end
end


Solution.IncludeAndLinkProject = function(str)
    Solution.IncludeProject(str)
    links (str)
end
