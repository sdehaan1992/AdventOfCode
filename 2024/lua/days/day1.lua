local day1 = {}

day1.part1 = function(file)
	local local_file = io.open(file, "r")
	local left = {}
	local right = {}
	for line in local_file:lines() do
		local split = string.find(line, "%s")
		table.insert(left, tonumber(string.sub(line, 1, split)))
		table.insert(right, tonumber(string.sub(line, split + 1)))
	end

	local result = 0
	table.sort(left)
	table.sort(right)

	for i = 1, #left do
		result = result + math.abs(left[i] - right[i])
	end

	local_file:close()
	return result
end

day1.part2 = function(file)
	local local_file = io.open(file, "r")
	local left = {}
	local right = {}
	for line in local_file:lines() do
		local split = string.find(line, "%s")
		table.insert(left, tonumber(string.sub(line, 1, split)))
		table.insert(right, tonumber(string.sub(line, split + 1)))
	end

	local result = 0
	table.sort(left)

	for _, lv in pairs(left) do
		local count = 0
		for _, rv in pairs(right) do
			if rv == lv then
				count = count + 1
			end
		end

		result = result + (count * lv)
	end

	return result
end

return day1
