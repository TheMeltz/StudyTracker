local function levenshtein(a: string, b: string): number
	local lenA, lenB = #a, #b
	local matrix = {}

	for i = 0, lenA do
		matrix[i] = { [0] = i }
	end
	for j = 0, lenB do
		matrix[0][j] = j
	end

	for i = 1, lenA do
		for j = 1, lenB do
			local cost = (a:sub(i, i) == b:sub(j, j)) and 0 or 1
			matrix[i][j] = math.min(
				matrix[i - 1][j] + 1, -- deletion
				matrix[i][j - 1] + 1, -- insertion
				matrix[i - 1][j - 1] + cost -- substitution
			)
		end
	end

	return matrix[lenA][lenB]
end

return levenshtein
