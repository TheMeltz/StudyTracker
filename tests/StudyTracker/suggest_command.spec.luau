local tiniest = require("../lib/tiniest_for_lune")
local suggest_command = require("../../src/utils/suggest_command")
type testing = typeof(tiniest.configure({}))

return function(testing: testing)
	local describe = testing.describe
	local expect = testing.expect
	local test = testing.test

	describe("suggest command helper", function()
		test("should return nil if no commands provided", function()
			expect(suggest_command("", {})).is(nil)
			expect(suggest_command("test", {})).is(nil)
		end)

		test("should return the most similar string in the array", function()
			local list = { "banana", "apple", "apartment", "bank", "bonus" }

			expect(suggest_command("band", list)).is("bank")
			expect(suggest_command("banan", list)).is("banana")
			expect(suggest_command("canan", list)).is("banana")
			expect(suggest_command("apple", list)).is("apple")
			expect(suggest_command("apartemen", list)).is("apartment")
			expect(suggest_command("nodus", list)).is("bonus")
		end)

		test("should return nil if no candidate is similar enough", function()
			local list = { "banana", "apple", "bonus" }
			expect(suggest_command("xyzz", list)).is(nil)
		end)
	end)
end
