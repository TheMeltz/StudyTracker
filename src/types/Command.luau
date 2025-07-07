export type Command = {
	description: string?,
	usage: string?,
	examples: { string }?,
	run: (...any?) -> (),
}

return true
