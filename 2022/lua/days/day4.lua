local day4 = {}

day4.part1 = function(file)
	local local_file = io.open(file, "r")
	local score = 0
	for line in local_file:lines() do
		local data = {}
		for number in string.gmatch(line, "%d+") do
			table.insert(data, tonumber(number))
		end

		if (data[1] <= data[3] and data[2] >= data[4]) or (data[3] <= data[1] and data[4] >= data[2]) then
			score = score + 1
		end
	end

	return score
end

day4.part2 = function(file)
	local local_file = io.open(file, "r")
	local score = 0
	for line in local_file:lines() do
		local data = {}
		for number in string.gmatch(line, "%d+") do
			table.insert(data, tonumber(number))
		end

		if (data[3] <= data[1] and data[4] >= data[1]) or (data[1] <= data[3] and data[2] >= data[3]) then
			score = score + 1
		end
	end

	return score
end

return day4
