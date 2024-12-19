local day19 = {}


day19.part1 = function(file)
	local fh = io.open(file, 'r')
	local line = fh:read()
	local patterns = {}
	for lint in string.gmatch(line, "%a+") do
		table.insert(patterns, lint)
	end
	fh:read()

	local function startswith(text, begin)
		if string.sub(text, 1, #begin) == begin then
			return true
		else
			return false
		end
	end

	local function check(line)
		if line == "" then
			return true
		end

		for _, pattern in ipairs(patterns) do
			if startswith(line, pattern) then
				local result = check(string.sub(line, #pattern + 1))
				if result then
					return true
				end
			end
		end

		return false
	end

	local correct = 0
	for line in fh:lines() do
		if check(line) then
			correct = correct + 1
		end
	end

	return correct
end

day19.part2 = function(file)
	local fh = io.open(file, 'r')
	local line = fh:read()
	local patterns = {}
	for lint in string.gmatch(line, "%a+") do
		table.insert(patterns, lint)
	end
	fh:read()

	local function startswith(text, begin)
		if string.sub(text, 1, #begin) == begin then
			return true
		else
			return false
		end
	end

	local cache = {}
	local function check(line)
		if cache[line] then
			return cache[line]
		end

		local total = 0
		for _, pattern in ipairs(patterns) do
			if pattern == line then
				total = total + 1
			elseif startswith(line, pattern) then
				total = total + check(string.sub(line, #pattern + 1))
			end
		end

		cache[line] = total
		return total
	end

	local result = 0
	for line in fh:lines() do
		result = result + check(line)
	end

	return result
end
return day19
