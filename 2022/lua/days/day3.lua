local day3 = {}

day3.part1 = function(file)
	local local_file = io.open(file, "r")
	local score = 0
	for line in local_file:lines() do
		local items = string.len(line)
		local first = string.sub(line, 1, items // 2)
		local second = string.sub(line, string.len(first) + 1)

		for pack = 1, #first do
			local character = first:sub(pack, pack)
			if string.find(second, character, 1, true) ~= nil then
				if character > 'Z' then
					score = score + character:byte(1, 1) - 96
				else
					score = score + character:byte(1, 1) - 38
				end
				break
			end
		end
	end

	return score
end

day3.part2 = function(file)
	local local_file = io.open(file, "r")
	local score = 0
	local test = ''
	local elves = 0
	for line in local_file:lines() do
		elves = elves + 1
		if elves == 1 then
			test = line
		else
			local found = ''
			for pack = 1, #test do
				local character = test:sub(pack, pack)
				if string.find(line, character, 1, true) ~= nil then
					found = found .. character
				end
			end
			test = found
		end

		if elves == 3 then
			elves = 0
			if test > 'Z' then
				score = score + test:byte(1, 1) - 96
			else
				score = score + test:byte(1, 1) - 38
			end
		end
	end
	return score
end

return day3
