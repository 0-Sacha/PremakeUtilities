
Solution.AddCoverageOption = function()
end

Solution.End = function()
    if AutomaticallyGenVSCodeFile then
        Solution.GenerateVSCodeAllFiles()
    end    
end