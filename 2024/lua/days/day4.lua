local day4 = {}

local width, height, local_file

local function get_dimensions(puzzle)
	local linelength = string.find(puzzle, "\n")
	return string.len(puzzle) // linelength, linelength
end

local function perform_check(x, m, a, s)
	print("checking xmas at :" .. m .. " " .. a .. " " .. s)
	if local_file:sub(m, m) == 'M' and local_file:sub(a, a) == 'A' and local_file:sub(s, s) == 'S' then
		print("xmas at :" .. m .. " " .. a .. " " .. s)
		return true
	end
	return false
end

local function xmas(x)
	local count = 0
	if x % width < width - 3 then
		-- if perform_check(x, x + 1, x + 2, x + 3) then
		-- 	count = count + 1
		-- end
	end
	if x % width > 3 then
		-- if perform_check(x, x - 1, x - 2, x - 3) then
		-- 	count = count + 1
		-- end
	end
	if x > 3 * width then
		-- if perform_check(x, x - width, x - width * 2, x - width * 3) then
		-- 	count = count + 1
		-- end
		if x % width > 3 then
			if perform_check(x, x - (width - 1), x - (width - 2) * 2, x - (width - 3) * 3) then
				count = count + 1
			end
		end
		if x % width < width - 3 then
			if perform_check(x, x - (width + 1), x - (width + 2) * 2, x - (width + 3) * 3) then
				count = count + 1
			end
		end
	end
	if x < (height * width - (width * 3)) then
		-- if perform_check(x, x + width, x + width * 2, x + width * 3) then
		-- 	count = count + 1
		-- end
		if x % width > 3 then
			if perform_check(x, x + (width - 1), x + (width - 2) * 2, x + (width - 3) * 3) then
				count = count + 1
			end
		end
		if x % width < width - 3 then
			if perform_check(x, x + (width + 1), x + (width + 2) * 2, x + (width + 3) * 3) then
				count = count + 1
			end
		end
	end
	return count
end


day4.part1 = function(file)
	local result = 0
	local_file = io.open(file, "r"):read("a")
	height, width = get_dimensions(local_file)
	local xs = {}
	local x = string.find(local_file, 'X', 1, true)
	while x do
		table.insert(xs, x)
		x = string.find(local_file, 'X', x + 1, true)
	end

	for _, loc in pairs(xs) do
		result = result + xmas(loc)
	end
	return result
end

day4.part2 = function(file)
	return calc(string.gsub(io.open(file, "r"):read("a"), "don't%(%).-do%(%)", ""):gsub("don't%(%).+", ""))
end

return day4
