local day11 = {}

local function blink(stones)
	local new_stones = {}
	for value, freq in pairs(stones) do
		if value == "0" then
			new_stones[1] = freq + (new_stones[1] or 0)
		elseif string.len(value) % 2 == 0 then
			local split = string.len(value) // 2
			local left = string.gsub(string.sub(value, 1, split), "^0+(%d+)", "%1")
			local right = string.gsub(string.sub(value, split + 1), "^0+(%d+)", "%1")
			new_stones[left] = freq + (new_stones[left] or 0)
			new_stones[right] = freq + (new_stones[right] or 0)
		else
			local str = tostring(tonumber(value) * 2024)
			new_stones[str] = freq + (new_stones[str] or 0)
		end
	end

	return new_stones
end

local function execute(file, blinks)
	local input = io.open(file, 'r'):read()
	local stones = {}
	for rock in string.gmatch(input, "%d+") do
		if stones[rock] == nil then
			stones[rock] = 1
		else
			stones[rock] = stones[rock] + 1
		end
	end

	for i = 1, blinks do
		stones = blink(stones)
	end

	local result = 0
	for key, value in pairs(stones) do
		result = result + value
	end

	return result
end

day11.part1 = function(file)
	return execute(file, 25)
end

day11.part2 = function(file)
	return execute(file, 75)
end

return day11
