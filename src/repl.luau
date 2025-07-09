--!strict
local Command = require("@types/Command")
type Command = typeof(Command)

local stdio = require("@lune/stdio")
local suggest_command = require("./utils/suggest_command")

local function start(commands)
	print("🎓 Welcome to StudyTracker CLI")
	print('Type "help" for more information.')

	local commandNames = {}
	for name in pairs(commands) do
		table.insert(commandNames, name)
	end

	while true do
		stdio.write(stdio.color("yellow"))
		stdio.write("> ")
		local line = stdio.readLine()
		stdio.write(stdio.color("reset"))

		if line ~= "\n" and line:match("^%s*$") == nil then
			local args = {}
			for word in line:gmatch("%S+") do
				table.insert(args, word)
			end

			local commandName = table.remove(args, 1) :: string
			local command = commands[commandName] :: Command

			if command then
				local ok, err = pcall(function()
					return command.run(unpack(args)), nil
				end)
				if not ok then
					print("Command error:", err)
				end
			else
				local suggestion = suggest_command(commandName, commandNames)
				print(`Invalid command: {commandName}.`)

				if suggestion then
					print(`🧠 Did you mean "{suggest_command(commandName, commandNames)}"?`)
				end
			end
		end
	end
end

return { start = start }
