Solution.CleanVerbose = true

Solution.CleanMakefiles = function()
    if Solution.CleanVerbose == true then
        print("rm Solution Makefile")
    end
    
    os.remove("./Makefile")
    if Solution.Projects ~= nil then
        for name, path in pairs(Solution.Projects) do
            path = path:gsub("%%{wks.location}", "")

            if Solution.CleanVerbose == true then
                print("rm Makefile path : " .. path .. name .. ".make")
            end
    
            os.remove("./" .. path .. "Makefile")
            os.remove("./" .. path .. name .. ".make")
        end
    end
end

Solution.CleanVSCodeFiles = function()
    if Solution.CleanVerbose == true then
        print("rm .vscode files")
    end

    os.rmdir("./.vscode")
end

Solution.CleanVSFiles = function()
    if Solution.CleanVerbose == true then
        print("rm Solution VS files")
    end

    os.rmdir("./.vs")
    os.remove("./" .. Solution.Name .. ".sln")
    if Solution.Projects ~= nil then
        for name, path in pairs(Solution.Projects) do
            path = path:gsub("%%{wks.location}", "")

            if Solution.CleanVerbose == true then
                print("rm VS files : " .. path .. name .. ".vcxproj")
            end

            os.remove("./" .. path .. name .. ".vcxproj")
            os.remove("./" .. path .. name .. ".vcxproj.filters")
            os.remove("./" .. path .. name .. ".vcxproj.user")
        end
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
        if Solution.CleanVerbose == true then
            print("Clean the build... ")
        else
            io.write("Clean the build... ")
        end
        Solution.CleanBin()
        Solution.CleanBuildFiles()
        print("done.")
    end
}