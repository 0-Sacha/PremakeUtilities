
Solution.GetEnvironementVariable = function(name, list, default)
    for idx, envVarName in ipairs(list) do
        envVar = os.getenv(envVarName)
        if (envVar ~= nil and envVar ~= '') then
            printf("Found %s environement variable : %s = %s", name, envVarName, envVar)
            return envVar
        end
    end
    
    if default ~= nil then
        printf("WARN : Couldn't Found %s environement variable so use the default one %s", name, default)
        return default
    end

    error(string.format("Coundn't load %s environement variable, you may want to change the environement variable name or define it; syntax : %s = {value}", name, name))
end
