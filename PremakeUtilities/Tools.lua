
Solution.TableShallowCopy = function(t)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = v
    end
    return t2
end

local function DetokenizeMatch(w)
    local value = _G
    for field in w:gmatch("([^%.]+)%.?") do
        value = value[field]
        if not value then
            printf("Value '%s' NOT found !!")
            return ""
        end
    end
    return tostring(value)
end

Solution.Detokenize = function(input, buildcfg, platform)
    input = input:gsub("%%{wks.location}", "${workspaceFolder}")
    if buildcfg ~= nil then
        input = input:gsub("%%{cfg.buildcfg}", buildcfg)
    end
    if platform ~= nil then
        input = input:gsub("%%{cfg.platform}", platform)
    end
    input = input:gsub("%%{(.-)}", DetokenizeMatch)
    return input
end
