--!strict
local Command = require("@types/Command")
type Command = Command.Command

local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local require: any = require

local function remove_ext(fileName: string)
	return fileName:gsub("%.lua[u]?$", "")
end

local function load_commands(): { [string]: Command }
	local COMMANDS_PATH = "./src/commands"
	local commands = {}

	for _, entry in fs.readDir(COMMANDS_PATH) do
		if fs.isFile(COMMANDS_PATH .. "/" .. entry) then
			local name = remove_ext(entry)
			local success, module = pcall(function()
				local module = require(`../commands/{name}`)

				if name == "help" and typeof(module) == "function" then
					return module(commands)
				end

				return module
			end)

			if success then
				commands[name] = module
			end
		end
	end

	return commands
end

return { load_commands = load_commands }
