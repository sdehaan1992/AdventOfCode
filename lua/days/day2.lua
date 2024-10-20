local day2 = {}

day2.part1 = function(file)
	local local_file = io.open(file, "r")
	local score = 0
	for line in local_file:lines() do
		if line ~= '' then
			local opponent = string.byte(line, 1, 1)
			local you = string.byte(line, #line, #line) - 23
			if opponent == you then
				score = score + 3 + you - 64
			elseif opponent + 1 == you or opponent - 2 == you then
				score = score + 6 + you - 64
			else
				score = score + you - 64
			end
		end
	end

	return score
end

day2.part2 = function(file)
	local local_file = io.open(file, "r")
	local score = 0
	for line in local_file:lines() do
		if line ~= '' then
			local opponent = string.byte(line, 1, 1)
			local result = string.byte(line, #line, #line)
			if result == 88 then
				if opponent == 65 then
					score = score + 3
				else
					score = score + opponent - 65
				end
			elseif result == 89 then
				score = score + 3 + opponent - 64
			else
				if opponent == 67 then
					score = score + 6 + opponent - 66
				else
					score = score + 6 + opponent + 1 - 64
				end
			end
		end
	end
	return score
end

return day2
