
Solution.AddCodeCoverageOption = function()
end

AutomaticallyGenVSCodeFile = true
AutomaticallyCleanBuildFiles = true

Solution.End = function()
    printf("Call Solution.End")
    if AutomaticallyGenVSCodeFile then
        printf("Generate .vscode")
        Solution.GenerateVSCodeAllFiles()
    end    
end

if AutomaticallyPreCleanBuildFiles then
    Solution.CleanBuildFiles()
end
