local day19 = {}

day19.part1 = function(file)
	local fh = io.open(file, 'r')
	local line = fh:read()
	local patterns = {}
	for lint in string.gmatch(line, "%a+") do
		patterns[lint] = 0
	end
	fh:read()

	local possible_values = {}
	local function check(line, pattern)
		local remainder = string.sub(line, #pattern + 1)
		for i = 1, #remainder do
			if patterns[string.sub(remainder, 1, i)] then
				local new_pattern = pattern .. string.sub(remainder, 1, i)
				table.insert(possible_values, new_pattern)
				print(line, new_pattern)
				patterns[new_pattern] = 0
				if #line == #new_pattern then
					return true
				else
					return check(line, table.remove(possible_values))
				end
			end
		end
		return false
	end

	local correct = 0
	for line in fh:lines() do
		print(check(line, ""))
	end

	return correct
end

return day19
