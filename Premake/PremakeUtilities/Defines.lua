DebugPremake = false

filter "platforms:x86"
    defines "ARCHITECTURE_X86"
    architecture "x86"
filter ""

filter "platforms:Win32"
    defines "ARCHITECTURE_X86"
    architecture "x86"
filter ""

filter "platforms:x64"
    defines "ARCHITECTURE_X64"
    architecture "x64"
filter ""


filter "configurations:Debug"
    defines "TARGET_DEBUG"
    runtime "Debug"
    optimize "Off"
    symbols "On"
filter ""

filter "configurations:Release"
    defines "TARGET_RELEASE"
    runtime "Release"
    optimize "On"
    symbols "On"
filter ""

filter "configurations:Dist"
    defines "TARGET_DIST"
    runtime "Release"
    optimize "Full"
    symbols "Off"
filter ""

    
filter "action:gmake2"
    defines "COMPILER_GMAKE"
    require("gmake2")
filter ""

filter "action:vs*"
    defines "COMPILER_VS"
    require("vstudio")
    -- characterset ("MBCS")
filter ""
	
Solution.Os = nil
Solution.Compiler = nil

if os.target() == "linux" then
    print("Use Platform Linux")
    systemversion "latest"
    Solution.Os = "Linux"
end

filter "system:linux"
    defines "PLATFORM_LINUX"
filter ""


if os.target() == "windows" then
    print("Use Platform Windows")
    systemversion "latest"
    Solution.Os = "Windows"
end

filter "system:windows"
defines "PLATFORM_WINDOWS"
filter ""


Solution.Premake = {}
Solution.Premake.Mode = _ACTION
Solution.Premake.ScanMode = function()
    for sub_arg in string.gmatch(Solution.Premake.Mode, "gmake") do
        Solution.Premake.BaseMode = "GMAKE"
    end
    for sub_arg in string.gmatch(Solution.Premake.Mode, "vs") do
        Solution.Premake.BaseMode = "VS"
    end
end
Solution.Premake.ScanMode()


Solution.Defines = {}
Solution.Defines.OnScanOption = function(key, value)
    if DebugPremake == true then
        printf("option : %s = %s", key, value)
    end
    if key == "cc" then
        Solution.Compiler = value
    end
end

Solution.Defines.OnScanArgument = function(key)
    if DebugPremake == true then
        printf("arg : %s", key)
    end
end

Solution.Defines.Scan = function()
    for i, arg in ipairs(_ARGV) do
        if arg:startswith("/") or arg:startswith("--") then
            key = nil
            for sub_arg in string.gmatch(arg, ".+=") do
                if key == nil then key = sub_arg end
            end
            value = nil
            for sub_arg in string.gmatch(arg, "=.+") do
                if value == nil then value = sub_arg end
            end
            Solution.Defines.OnScanOption(key:sub(3, string.len(key) - 1), value:sub(2))
        else
            Solution.Defines.OnScanArgument(arg)
        end
    end
end
Solution.Defines.Scan()

if Solution.Premake.BaseMode == "VS" then
    if Solution.Compiler == "clang" then
        Solution.Compiler = "clang-cl"
    else
        Solution.Compiler = "msc"
    end
end

if Solution.Compiler == nil then
    printf("Use Default compiler", Solution.Compiler)
else
    printf("Use %s as compiler", Solution.Compiler)
end

