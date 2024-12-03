local day3 = {}

local function calc(input)
	local result = 0
	for a, b in string.gmatch(input, "mul%((%d+),(%d+)%)") do
		result = result + (a * b)
	end
	return result
end

day3.part1 = function(file)
	return calc(io.open(file, "r"):read("a"))
end

day3.part2 = function(file)
	return calc(string.gsub(io.open(file, "r"):read("a"), "don't%(%).-do%(%)", ""):gsub("don't%(%).+", ""))
end

return day3
