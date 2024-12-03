local day3 = {}

day3.part1 = function(file)
	local local_file = io.open(file, "r")
	local result = 0
	for line in local_file:lines() do
		for a, b in string.gmatch(line, "mul%((%d+),(%d+)%)") do
			result = result + (a * b)
		end
	end
	local_file:close()
	return result
end

day3.part2 = function(file)
	local local_file = io.open(file, "r"):read("a")
	local result = 0
	local newline, matches = string.gsub(local_file, "don't%(%).+do%(%)", "")
	print(matches)
	newline, matches = string.gsub(newline, "don't%(%).+", "")
	print(matches)
	print(newline)
	for a, b in string.gmatch(newline, "mul%((%d+),(%d+)%)") do
		result = result + (a * b)
	end
	return result
end

return day3
