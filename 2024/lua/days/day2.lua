local day2 = {}

local function is_valid(levels)
	local in_asc = {}
	local in_desc = {}

	for i = 1, #levels - 1 do
		if levels[i] > levels[i + 1] then
			table.insert(in_asc, i + 1)
			if math.abs(levels[i] - levels[i + 1]) > 3 then
				table.insert(in_desc, i + 1)
			end
		elseif levels[i] < levels[i + 1] then
			table.insert(in_desc, i + 1)
			if math.abs(levels[i] - levels[i + 1]) > 3 then
				table.insert(in_asc, i + 1)
			end
		else
			table.insert(in_asc, i + 1)
			table.insert(in_desc, i + 1)
		end
	end

	if #in_asc == 0 or #in_desc == 0 then
		return true
	end
	return false
end

day2.part1 = function(file)
	local local_file = io.open(file, "r")
	local safe = 0
	for line in local_file:lines() do
		local levels = {}
		for value in string.gmatch(line, "%d+") do
			table.insert(levels, tonumber(value))
		end
		if is_valid(levels) then
			safe = safe + 1
		end
	end
	local_file:close()
	return safe
end

day2.part2 = function(file)
	local local_file = io.open(file, "r")
	local safe = 0
	local linenr = 0
	for line in local_file:lines() do
		local levels = {}
		for value in string.gmatch(line, "%d+") do
			table.insert(levels, tonumber(value))
		end
		if is_valid(levels) then
			safe = safe + 1
		else
			for i = 1, #levels do
				local removed = table.remove(levels, i)
				if is_valid(levels) then
					safe = safe + 1
					break
				end
				table.insert(levels, i, removed)
			end
		end
	end
	local_file:close()
	return safe
end

return day2
