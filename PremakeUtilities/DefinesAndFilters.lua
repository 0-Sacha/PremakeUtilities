DebugPremake = false

Solution.Os = nil
Solution.Compiler = nil

if os.target() == "linux" then
    print("Use Platform Linux")
    Solution.Os = "Linux"
end

if os.target() == "windows" then
    print("Use Platform Windows")
    Solution.Os = "Windows"
end

Solution.PlatformDefines = function(prefix)
    if (prefix ~= nil) then
        prefix = prefix .. '_'
    else
        prefix = ""
    end

    if (DebugPremake) then
        printf("Run PlatformDefines on %s", prefix);
    end

    filter { "platforms:x86" }
        defines (prefix .. "ARCHITECTURE_X86")
    filter {}

    filter { "platforms:Win32" }
        defines (prefix .. "ARCHITECTURE_X86")
    filter {}

    filter { "platforms:x64" }
        defines (prefix .. "ARCHITECTURE_X64")
    filter {}


    filter { "configurations:Debug" }
        defines (prefix .. "TARGET_DEBUG")
    filter {}

    filter { "configurations:Release" }
        defines (prefix .. "TARGET_RELEASE")
    filter {}

    filter { "configurations:Dist" }
        defines (prefix .. "TARGET_DIST")
    filter {}


    filter { "action:gmake2" }
        defines (prefix .. "COMPILER_GMAKE")
    filter {}

    filter { "action:vs*" }
        defines (prefix .. "COMPILER_VS")
    filter {}
        

    filter { "system:linux" }
        defines (prefix .. "PLATFORM_LINUX")
    filter {}

    filter { "system:windows" }
        defines (prefix .. "PLATFORM_WINDOWS")
    filter {}
end

filter "configurations:Debug"
    runtime "Debug"
    optimize "Off"
    symbols "On"
filter {}

filter "configurations:Release"
    runtime "Release"
    optimize "On"
    symbols "On"
filter {}

filter "configurations:Dist"
    runtime "Release"
    optimize "Full"
    symbols "Off"
filter {}


filter "action:gmake2"
    require("gmake2")
filter {}


filter "action:vs*"
    require("vstudio")
    -- characterset ("MBCS")
filter {}


filter "platforms:x86"
    architecture "x86"
filter {}

filter "platforms:Win32"
    architecture "x86"
filter {}

filter "platforms:x64"
    architecture "x64"
filter {}

filter "platforms:Win64"
    architecture "x64"
filter {}


filter "system:linux"
    systemversion "latest"
filter {}

filter "system:windows"
    systemversion "latest"
filter {}


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

