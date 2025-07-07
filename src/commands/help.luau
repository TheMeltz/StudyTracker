--!strict
local Command = require("@types/Command")
type Command = Command.Command

return function(commandsRegistry: { [string]: Command }): Command
	return {
		description = "Show help for available commands",
		usage = "help [command]",
		examples = { "help", "help add" },
		run = function(commandName: string?)
			if not commandName then
				print("📖 Available commands:")
				for name in pairs(commandsRegistry) do
					print("  - " .. name)
				end
				print("\nType 'help <command>' for more info.")
				return
			end

			local cmd = commandsRegistry[commandName]
			if not cmd then
				print("❌ Unknown command: " .. commandName)
				return
			end

			print("🔍 Help for '" .. commandName .. "':\n")
			if cmd.description then
				print("Description: " .. cmd.description)
			end
			if cmd.usage then
				print("Usage: " .. cmd.usage)
			end
			if cmd.examples then
				print("Examples:")
				for _, ex in ipairs(cmd.examples) do
					print("  " .. ex)
				end
			end
		end,
	} :: Command
end
