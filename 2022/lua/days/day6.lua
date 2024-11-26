local day6 = {}

day6.part1 = function(file)
	local local_file = io.open(file, "r")
	local line = local_file:read("a")
	local size = 0
	local window = {}

	for i = 1, string.len(line) do
		for j = i, i + 3 do
			local value = string.byte(line, j)
			if window[value] == nil then
				size = size + 1
				if size == 4 then
					return j
				end
			else
				break
			end
			window[value] = true
		end
		window = {}
		size = 0
	end
end

day6.part2 = function(file)
	local local_file = io.open(file, "r")
	local line = local_file:read("a")
	local size = 0
	local window = {}

	for i = 1, string.len(line) do
		for j = i, i + 13 do
			local value = string.byte(line, j)
			if window[value] == nil then
				size = size + 1
				if size == 14 then
					return j
				end
			else
				break
			end
			window[value] = true
		end
		window = {}
		size = 0
	end
end

return day6
