CleanVerbose = false

Solution.CleanMakefiles = function()
    if CleanVerbose == true then
        print("rm Solution Makefile")
    end
    
    os.remove("./Makefile")
    for projectName, projectData in pairs(Solution.Projects) do
        projectPath = projectData.Path:gsub("%%{wks.location}", "")

        if CleanVerbose == true then
            print("rm Makefile path : " .. projectPath .. projectName .. ".make")
        end

        os.remove("./" .. projectPath .. "Makefile")
        os.remove("./" .. projectPath .. projectName .. ".make")
    end

    if CleanVerbose == true then
        print("OK: rm Solution Makefile")
    end
end

Solution.CleanVSCodeFiles = function()
    if CleanVerbose == true then
        print("rm .vscode files")
    end

    os.rmdir("./.vscode")
end

Solution.CleanVSFiles = function()
    if CleanVerbose == true then
        print("rm Solution VS files")
    end

    os.rmdir("./.vs")
    os.remove("./" .. Solution.Name .. ".sln")

    for projectName, projectData in pairs(Solution.Projects) do
        projectPath = projectData.Path:gsub("%%{wks.location}/", "")

        if CleanVerbose == true then
            print("rm VS files : " .. projectPath .. projectName .. ".vcxproj")
        end

        os.remove("./" .. projectPath .. projectName .. ".vcxproj")
        os.remove("./" .. projectPath .. projectName .. ".vcxproj.filters")
        os.remove("./" .. projectPath .. projectName .. ".vcxproj.user")
    end

    if CleanVerbose == true then
        print("OK: rm Solution VS files")
    end
end

Solution.CleanBuildFiles = function()
    Solution.CleanVSFiles()
    Solution.CleanVSCodeFiles()
    Solution.CleanMakefiles()
end

Solution.CleanBin = function()
    os.rmdir("./bin")
    os.rmdir("./bin-int")
end

newaction {
    trigger     = "clean",
    description = "clean the software",
    execute     = function ()
        if CleanVerbose == true then
            print("Clean the build... ")
        else
            io.write("Clean the build... ")
        end
        Solution.CleanBin()
        Solution.CleanBuildFiles()
        print("done.")
    end
}