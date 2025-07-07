--!strict
local SAVE_SNAPSHOTS = true

local tiniest = require("./lib/tiniest_for_lune").configure({
	snapshot_path = "./tests/__snapshots__",
	save_snapshots = SAVE_SNAPSHOTS,
})

local require: any = require

local tests = tiniest.collect_tests(function()
	local describe = tiniest.describe

	local function describe_from_file(name: string)
		describe(name, function()
			require(`./{name}.spec`)(tiniest)
		end)
	end

	describe_from_file("StudyTracker/suggest_command")
end)
tiniest.run_tests(tests, {})

if SAVE_SNAPSHOTS then
	print()
	print(string.rep("💾 🛠️  ", 12))
	print()
	print("Warning! Snapshots are being saved.")
	print("Unless you're in a local dev environment, turn this off.")
	print()
	print(string.rep("💾 🛠️  ", 12))
	print()
end
