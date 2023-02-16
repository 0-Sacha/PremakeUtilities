
Solution.MakefileHandler = {}
include("PropertiesHandler.lua")

Solution.MakefileHandler.AddInfo = function(str)
    Solution.Utils.AddNewLine()
    Solution.Utils.AddNewLine()
    premake.w("#" .. str)
    premake.w("# #############################################")
    Solution.Utils.AddNewLine()
end

Solution.MakefileHandler.AddSimpleInfo = function(str)
    premake.w("#" .. str)
end
