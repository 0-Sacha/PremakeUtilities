
Solution = {}

include("PremakeUtilities/DefinesAndFilters.lua")
include("PremakeUtilities/Path.lua")
include("PremakeUtilities/IncludeFunctions.lua")
include("PremakeUtilities/EnvVars.lua")
include("PremakeUtilities/Clean.lua")

include("PremakeUtilities/Handler/Handler.lua")

if (Solution.Premake.BaseMode == "VS") then
	Solution.CleanVSfiles()
end
