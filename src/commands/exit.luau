--!strict
local process = require("@lune/process")
local Command = require("@types/Command")

local function run()
	print("")
	process.exit(2)
end

return {
	run = run,
	description = "stops the program.",
	usage = "exit",
} :: Command.Command
