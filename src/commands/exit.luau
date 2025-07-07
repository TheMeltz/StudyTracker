--!strict
local process = require("@lune/process")

local function run()
	print("")
	process.exit(2)
end

return { run = run }
