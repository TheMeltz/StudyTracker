local function run(subject: string)
	print(subject)
end

return {
	description = "List all study sessions per subject",
	usage = "list [subject]",
	examples = { "list", "list math", "list english" },
	run = run,
}
