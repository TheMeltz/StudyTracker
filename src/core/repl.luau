--!strict
local stdio = require("@lune/stdio")
local CommandRouter = require("./commandRouter")

local function start(commands)
	print("🎓 Welcome to StudyTracker CLI")
	print('Type "help" for more information.')

	local router = CommandRouter.new(commands)
	if not router then
		return
	end

	while true do
		stdio.write(stdio.color("yellow"))
		stdio.write("> ")
		local line = stdio.readLine()
		stdio.write(stdio.color("reset"))

		if line:match("^%s*$") then
			continue
		end

		router:execute(line)
	end
end

return { start = start }
