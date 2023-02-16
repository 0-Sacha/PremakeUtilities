
Solution.MakefileHandler.Properties = {}

Solution.MakefileHandler.Properties.Add = function(property, flag)
    premake.w(property .. ' += ' .. flag)
end

Solution.MakefileHandler.Properties.AddIf = function(property, flag, value)
    if value == true or value == "On" or value == "Enable" then
        premake.w(property)
    end
end

Solution.MakefileHandler.Properties.WriteBoolean = function(property, flag, value)
    if value == true or value == "On" or value == "Enable" then
        premake.w(property .. ' += ' .. flag .. '=true')
    elseif value == false or value == "Off" or value == "Disable" then
        premake.w(property .. ' += ' .. flag .. '=false')
    end
end

Solution.MakefileHandler.Properties.WriteValue = function(property, value)
    if value ~= nil and value ~= '' then
        premake.w(property .. ' += ' .. value)
    end
end

Solution.MakefileHandler.Properties.SetValue = function(property, value)
    if value ~= nil and value ~= '' then
        premake.w(property .. ' = ' .. value)
    end
end

Solution.MakefileHandler.Properties.WriteConcatedTable = function(property, values)
    if values ~= nil then
        Solution.MakefileHandler.Properties.WriteValue(property, table.concat(values, ' '))
    end
end

Solution.MakefileHandler.Properties.Begin = function(property)
    error("Solution.MakefileHandler doesn't support Begin function")
end

Solution.MakefileHandler.Properties.End = function(property)
    error("Solution.MakefileHandler doesn't support End function")
end
