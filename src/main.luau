--!strict
local stdio = require("@lune/stdio")
local process = require("@lune/process")

local commands = require("./loader").load_commands()
local repl = require("./repl")

local ok, err = pcall(repl.start, commands)
if not ok then
	stdio.write(stdio.color("red"))
	print("Unexpected error:", err)
end
