--!strict
local Command = require("@types/Command")
local suggest_command = require("../utils/suggest_command")
type Command = typeof(Command)

local CommandRouter = {}
CommandRouter.__index = CommandRouter

function CommandRouter.new(commands: { [string]: Command })
	local self = setmetatable({}, CommandRouter)
	self.commands = commands
	self.commandNames = {}

	for name in pairs(self.commands) do
		table.insert(self.commandNames, name)
	end

	return self
end

function CommandRouter:execute(line: string)
	local args = {}
	for word in line:gmatch("%S+") do
		table.insert(args, word)
	end

	local commandName = table.remove(args, 1)
	if not commandName then
		return
	end
	local command = self.commands[commandName] :: Command?

	if not command then
		print(`Invalid command: {commandName}.`)
		local suggestion = suggest_command(commandName :: string, self.commandNames)
		if suggestion then
			print(`🧠 Did you mean "{suggestion}"?`)
		end
		return
	end

	local ok, result = pcall(function()
		return command.run(unpack(args)), nil
	end)

	if not ok then
		print("❌ Error running command:", result)
	end
end

return CommandRouter
