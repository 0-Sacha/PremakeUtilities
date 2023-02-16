
Solution.Path = {}
Solution.Path.OutputDirectory = Solution.Os .. "-" .. Solution.Premake.Mode .. "/%{cfg.buildcfg}-%{cfg.platform}"

Solution.Path.TargetDirectory = "%{wks.location}/bin/" .. Solution.Path.OutputDirectory
Solution.Path.ObjectDirectory = "%{wks.location}/bin-int/" .. Solution.Path.OutputDirectory

Solution.Path.ProjectTargetDirectory = Solution.Path.TargetDirectory .. "/%{prj.name}"
Solution.Path.ProjectObjectDirectory = Solution.Path.ObjectDirectory .. "/%{prj.name}"


Solution.Path.GetProjectTargetDirectory = function(project)
    return Solution.Path.TargetDirectory .. project
end

Solution.Path.GetProjectObjectDirectory = function(project)
    return Solution.Path.ObjectDirectory .. project
end
