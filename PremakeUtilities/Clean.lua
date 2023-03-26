Solution.CleanVerbose = false

Solution.CleanMakefiles = function()
    if Solution.CleanVerbose == true then
        print("rm Solution Makefile")
    end
    
    os.remove("./Makefile")
    if Solution.Projects ~= nil then
        for name, path in pairs(Solution.Projects) do
            if Solution.CleanVerbose == true then
                print("rm Makefile : " .. name)
            end
    
            os.remove("./" .. name .. "/Makefile")
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
            if Solution.CleanVerbose == true then
                print("rm VS files : " .. name)
            end
            os.remove("./" .. name .. "/" .. name .. ".vcxproj")
            os.remove("./" .. name .. "/" .. name .. ".vcxproj.filters")
            os.remove("./" .. name .. "/" .. name .. ".vcxproj.user")
        end
    end
end

Solution.CleanBuildFiles = function()
    if Solution.Premake.BaseMode == "VS" then
        Solution.CleanVSFiles()
    else
        Solution.CleanVSCodeFiles()
        Solution.CleanMakefiles()
    end
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