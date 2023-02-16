
Solution.VSHandler.Properties = {}

Solution.VSHandler.Properties.Add = function(property)
    premake.w('\t<' .. property .. '></' .. property .. '>')
end

Solution.VSHandler.Properties.AddIf = function(property, value)
    if value == true or value == "On" or value == "Enable" then
        premake.w('\t<' .. property .. '></' .. property .. '>')
    end
end

Solution.VSHandler.Properties.WriteBoolean = function(property, value)
    if value == true or value == "On" or value == "Enable" then
        premake.w('\t<' .. property .. '>true</' .. property .. '>')
    elseif value == false or value == "Off" then
        premake.w('\t<' .. property .. '>false</' .. property .. '>')
    end
end

Solution.VSHandler.Properties.WriteValue = function(property, value)
    if value ~= nil and value ~= '' then
        premake.w('\t<' .. property .. '>' .. value .. '</' .. property .. '>')
    end
end

Solution.VSHandler.Properties.SetValue = function(property, value)
    if value ~= nil and value ~= '' then
        premake.w('\t<' .. property .. '>' .. value .. '</' .. property .. '>')
    end
end

Solution.VSHandler.Properties.WriteConcatedTable = function(property, values)
    if values ~= nil then
        Solution.VSHandler.Properties.WriteValue(property, table.concat(values, ' '))
    end
end

Solution.VSHandler.Properties.Begin = function(property)
    if DebugPremake == true then
        printf("Begin writing property" .. property)
    end
    premake.w("<" .. property .. ">")
end

Solution.VSHandler.Properties.End = function(property)
    if DebugPremake == true then
        printf("Finished writing property" .. property)
    end
    premake.w("</" .. property .. ">")
end
