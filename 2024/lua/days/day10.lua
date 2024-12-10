local day10 = {}

local function get_dimensions(grid)
	local cols = string.find(grid, "\n", 1, true)
	local rows = string.len(grid) // cols

	return rows, cols - 1
end

local function get_neighbours_locations(point, rows, cols)
	local neighbours = {}
	if point > cols then
		table.insert(neighbours, point - cols)
	end
	if point <= (rows * cols) - cols then
		table.insert(neighbours, point + cols)
	end
	if point % cols > 0 then
		table.insert(neighbours, point + 1)
	end
	if (point - 1) % cols > 0 then
		table.insert(neighbours, point - 1)
	end

	return neighbours
end

local function find_hikes(grid, point, rows, cols)
	local paths = {}
	local peaks = {}

	local function next(grid, points, height)
		for _, next_point in ipairs(points) do
			local neighbours_loc = get_neighbours_locations(next_point, rows, cols)
			for _, loc in ipairs(neighbours_loc) do
				local next_points = {}
				if tonumber(string.sub(grid, loc, loc)) == height then
					if height == 9 then
						table.insert(paths, loc)
						peaks[loc] = loc
					else
						table.insert(next_points, loc)
					end
				end
				next(grid, next_points, height + 1)
			end
		end
	end

	next(grid, { point }, 1)
	return peaks, paths
end

day10.part1 = function(file)
	local input = io.open(file, 'r'):read("a")
	local rows, cols = get_dimensions(input)
	input, _ = string.gsub(input, "\n", "")
	local starting_points = {}
	local starting_point = string.find(input, "0")
	while starting_point do
		table.insert(starting_points, starting_point)
		starting_point = string.find(input, "0", starting_point + 1)
	end

	local part1 = 0
	local part2 = 0
	for _, start in ipairs(starting_points) do
		local peaks, paths = find_hikes(input, start, rows, cols)
		part2 = part2 + #paths
		for _, _ in pairs(peaks) do
			part1 = part1 + 1
		end
	end

	return part1, part2
end

return day10
