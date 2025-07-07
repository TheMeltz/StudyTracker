type Command = {
	run: (...any?) -> (),
}

local levenshtein = require("./levenshtein")

local function suggest_command(input: string, commands: { string }): string?
	local best, lowest = nil, math.huge
	for _, name in commands do
		local dist = levenshtein(input, name)
		if dist < lowest then
			lowest, best = dist, name
		end
	end

	if lowest <= 2 then
		return best
	end
	return nil
end

return suggest_command
