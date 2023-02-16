
Solution.ProjectEnvVar = {}

Solution.GetEnvironementVariable = function(str, default)
    if Solution.ProjectEnvVar ~= nil then
        if Solution.ProjectEnvVar[str] ~= nil then
            for _, envVarName in ipairs(Solution.ProjectEnvVar[str]) do
                envVar = os.getenv(envVarName)
                if (envVar ~= nil and envVar ~= '') then
                    printf("Found %s environement variable : %s = %s", str, envVarName, envVar)
                    return envVar
                end
            end
        end
    end
    
    if default ~=nil then
        printf("WARN : Couldn't Found %s environement variable so use the default one %s", str, default)
        return default
    end

    error(string.format("Coundn't load %s environement variable, you may want to change the environement variable name or define it; syntax : %s = {value}", str, str))
end
