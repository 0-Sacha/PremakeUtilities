
Solution.Handler = {}

include("Utils.lua")

include("MakefileHandler/MakefileHandler.lua")
include("VSHandler/VSHandler.lua")

if Solution.Premake.BaseMode == "VS" then
    printf("Use VisualStudio")
    Solution.Handler = Solution.VSHandler
end

if Solution.Premake.BaseMode == "GMAKE" then
    printf("Use Makefiles")
    Solution.Handler = Solution.MakefileHandler
end
