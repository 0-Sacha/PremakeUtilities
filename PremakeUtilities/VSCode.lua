
json = require "json"

DebugVSCodeGen = false

Solution.GetVSCodePropertiesConfig = function(name)
    config = {}
    config.name = name
    config.cStandard = "c17"
    config.cppStandard = "c++20"
    config.intelliSenseMode = "gcc-x64"
    config.defines = {}
    config.includePath = { "${workspaceFolder}/**" }

    return config
end

Solution.GenerateVSCodeProperties = function()
    default_config = Solution.GetVSCodePropertiesConfig("default")

    properties = {}
    properties.version = 4
    properties.configurations = { default_config }

    jsonstr = json.encode(properties)

    if DebugVSCodeGen == true then
        printf("Generate 'c_cpp_properties.json' : %s", jsonstr)
    end
    fd = io.open(".vscode/c_cpp_properties.json", "w")
    fd:write(jsonstr)
    fd:close()
end

Solution.GetVSCodeTask = function(label, config, default)
    task = {}
    task.type = "shell"
    task.label = label
    task.command = "time make -j config=" .. config
    task.options = {}
    task.options.cwd = "${workspaceFolder}"

    if default == "default" then
        task.group = {}
        task.group.kind = "build"
        task.group.isDefault = true
    else
        task.group = "build"
    end

    return task
end

Solution.Tasks = {}

Solution.GenerateVSCodeTasks = function()


    tasks_file = {}
    tasks_file.version = "2.0.0"
    tasks_file.tasks = {}

    has_default_task = false
    tasks_idx = 1

    if Solution.Tasks ~= nil then
        for task_label, task in pairs(Solution.Tasks) do
            printf("Add custom task : %s ", task_label)
            
            generated_task = Solution.GetVSCodeTask(task_label, task.config, task.default)
            if task.default == "default" then
                has_default_task = true
            end

            tasks_file.tasks[tasks_idx] = generated_task
            tasks_idx = tasks_idx + 1
        end
    end

    debug_x86 = Solution.GetVSCodeTask("DEBUGx86 build",     "debug_x86")
    debug_x64 = Solution.GetVSCodeTask("DEBUGx64 build",     "debug_x64")
    release_x86 = Solution.GetVSCodeTask("RELEASEx86 build", "release_x86")
    release_x64 = nil        
    if has_default_task == false then
        release_x64 = Solution.GetVSCodeTask("RELEASEx64 build", "release_x64", "default")
    else
        release_x64 = Solution.GetVSCodeTask("RELEASEx64 build", "release_x64")
    end

    tasks_file.tasks[tasks_idx] = debug_x86
    tasks_idx = tasks_idx + 1
    tasks_file.tasks[tasks_idx] = debug_x64
    tasks_idx = tasks_idx + 1
    tasks_file.tasks[tasks_idx] = release_x86
    tasks_idx = tasks_idx + 1
    tasks_file.tasks[tasks_idx] = release_x64

    jsonstr = json.encode(tasks_file)

    if DebugVSCodeGen == true then
        printf("Generate 'tasks.json' : %s", jsonstr)
    end
    fd = io.open(".vscode/tasks.json", "w")
    fd:write(jsonstr)
    fd:close()
end



if Solution.VSCodeDBG == nil then
    Solution.VSCodeDBG = "gdb"
end

Solution.GetVSCodeDebugConfig = function(name, prgm, pre_launch_task, args)
    if args == nil then
        args = {}
    end

    config = {}
    config.name = name
    config.type = "cppdbg"
    config.request = "launch"
    config.miDebuggerPath = Solution.VSCodeDBG
    config.program = prgm
    config.args = args
    config.cwd = "${workspaceFolder}"
    config.preLaunchTask = pre_launch_task
    
    config.stopAtEntry = false
    config.environment = {}
    config.externalConsole = false
    config.MIMode = Solution.VSCodeDBG
    command = {}
    command.description = "Enable pretty-printing for gdb"
    command.text = "-enable-pretty-printing"
    command.ignoreFailures = true
    
    config.setupCommands = { command }

    return config
end


if Solution.VSCodeDebugTarget == nil then
    Solution.VSCodeDebugTarget = {}
    Solution.VSCodeDebugTarget.PreLaunchTask = "DEBUGx64 build"
    Solution.VSCodeDebugTarget.BuildCfg = "Debug"
    Solution.VSCodeDebugTarget.Platform = "x64"
end

Solution.Launch = {}

Solution.GenerateVSCodeLaunch = function()
    targets_dir = Solution.Path.TargetDirectory
    targets_dir = targets_dir:gsub("%%{wks.location}", "${workspaceFolder}")
    targets_dir = targets_dir:gsub("%%{cfg.buildcfg}", Solution.VSCodeDebugTarget.BuildCfg)
    targets_dir = targets_dir:gsub("%%{cfg.platform}", Solution.VSCodeDebugTarget.Platform)

    file_launch = Solution.GetVSCodeDebugConfig("File Location", targets_dir .. "/${fileBasenameNoExtension}/${fileBasenameNoExtension}", Solution.VSCodeDebugTarget.PreLaunchTask)

    launch = {}
    launch.version = "0.2.0"
    launch.configurations = {}

    launch.configurations[1] = file_launch

    config_idx = 2

    if Solution.Launch ~= nil then
        for config_name, config in pairs(Solution.Launch) do
            printf("Add custom config : %s ", config_name)
            
            if (config.PreLaunchTask == nil) then
                config.PreLaunchTask = Solution.VSCodeDebugTarget.PreLaunchTask
            end

            config_targets_dir = targets_dir;

            if (config.BuildCfg ~= nil or config.Platform ~= nil) then
                config_targets_dir = Solution.Path.TargetDirectory
                config_targets_dir = config_targets_dir:gsub("%%{wks.location}", "${workspaceFolder}")
                config_targets_dir = config_targets_dir:gsub("%%{cfg.buildcfg}", config.BuildCfg)
                config_targets_dir = config_targets_dir:gsub("%%{cfg.platform}", config.Platform)
            end

            generated_config = Solution.GetVSCodeDebugConfig(config_name, config_targets_dir .. "/" .. config.project .. "/" .. config.project, config.PreLaunchTask, config.args)
            
            launch.configurations[config_idx] = generated_config
            config_idx = config_idx + 1
        end
    end

    jsonstr = json.encode(launch)

    if DebugVSCodeGen == true then
        printf("Generate 'launch.json' : %s", jsonstr)
    end
    fd = io.open(".vscode/launch.json", "w")
    fd:write(jsonstr)
    fd:close()
end

Solution.GenerateVSCodeAllFiles = function()
    if Solution.Premake.BaseMode == "GMAKE" then
        Solution.GenerateVSCodeProperties()
        Solution.GenerateVSCodeTasks()
        Solution.GenerateVSCodeLaunch()
    end
end


newaction {
    trigger     = "vscode",
    description = "Generate VSCode Files",
    execute     = function ()
        Solution.GenerateVSCodeAllFiles()
    end
}
