
Solution.Utils = {}

Solution.Utils.AddNewLine = function()
    premake.w()
end

Solution.Utils.GetCountOfTable = function(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

Solution.Utils.GetCountOfArray = function(T)
    local count = 0
    for _ in T do count = count + 1 end
    return count
end

Solution.Utils.DumpTable = function(T)
    local count = 0
    for key, value in pairs(T) do
        printf("%s : %s", key, value)
    end
end

Solution.Utils.ForEachFileWithGlobber = function(globber, func)
    matchingFiles = os.matchfiles(globber)
    if matchingFiles ~= null and matchingFiles ~= nil then
        
        count = Solution.Utils.GetCountOfTable(matchingFiles)

        if DebugPremake == true then
            if count == 0 then
                printf("WARN FilePathGlobber : %s match 0 file", globber)
            else
                printf("FilePathGlobber : %s match %i files", globber, count)
            end
        end
            
        table.foreachi(matchingFiles, func)
    else
        printf("WARN FilePathGlobber : %s match 0 file", globber)
    end
end

