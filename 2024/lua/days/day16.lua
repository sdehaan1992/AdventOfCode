local pathfinding = require("pathfinding")

local day16 = {}

local rows, cols = 0, 0
local grid = {}
local nodes = {}

local function get_dimensions(map)
	local cols = string.find(map, "\n")
	local rows = string.len(map) // cols

	return rows, cols - 1
end

local function get_neighbours(node)
	local found_node = nodes[node]
	if node.from then
		local from = nodes[node.from]
		if found_node.row < from.row then
			node.direction = 'N'
		elseif found_node.row > from.row then
			node.direction = 'S'
		elseif found_node.col < from.col then
			node.direction = 'W'
		else
			node.direction = 'E'
		end
	end

	local neighbours = {}
	if found_node.row > 1 then
		local neighbour = grid[found_node.row - 1][found_node.col]
		local distance_to_neighbour = 1
		if node.direction ~= 'N' then
			distance_to_neighbour = 1001
		end
		if neighbour and neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour, distance = distance_to_neighbour })
		end
	end
	if found_node.row < rows then
		local neighbour = grid[found_node.row + 1][found_node.col]
		local distance_to_neighbour = 1
		if node.direction ~= 'S' then
			distance_to_neighbour = 1001
		end
		if neighbour and neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour, distance = distance_to_neighbour })
		end
	end
	if found_node.col > 1 then
		local neighbour = grid[found_node.row][found_node.col - 1]
		local distance_to_neighbour = 1
		if node.direction ~= 'W' then
			distance_to_neighbour = 1001
		end
		if neighbour and neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour, distance = distance_to_neighbour })
		end
	end
	if found_node.col < cols then
		local neighbour = grid[found_node.row][found_node.col + 1]
		local distance_to_neighbour = 1
		if node.direction ~= 'E' then
			distance_to_neighbour = 1001
		end
		if neighbour and neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour, distance = distance_to_neighbour })
		end
	end

	return neighbours
end

day16.part1 = function(file)
	local input = io.open(file, 'r'):read('a')
	rows, cols = get_dimensions(input)

	local start
	local finish
	for i = 1, rows do
		grid[i] = {}
	end

	local row_count = 0
	for line in string.gmatch(input, "(.-)\n") do
		row_count = row_count + 1
		for char in string.gmatch(line, ".") do
			local node = { display = char }
			table.insert(grid[row_count], node)
			nodes[node] = { row = row_count, col = #grid[row_count] }
			if char == 'S' then
				start = { row = row_count, col = #grid[row_count] }
			elseif char == "E" then
				finish = { row = row_count, col = #grid[row_count] }
			end
		end
	end

	grid[start.row][start.col].direction = 'E'
	pathfinding.dijkstra(nodes, grid[start.row][start.col], get_neighbours)

	return grid[finish.row][finish.col].distance
end

day16.part2 = function(file)
	local input = io.open(file, 'r'):read('a')
	rows, cols = get_dimensions(input)

	local start
	local finish
	for i = 1, rows do
		grid[i] = {}
	end

	local row_count = 0
	for line in string.gmatch(input, "(.-)\n") do
		row_count = row_count + 1
		for char in string.gmatch(line, ".") do
			local node = { display = char }
			table.insert(grid[row_count], node)
			nodes[node] = { row = row_count, col = #grid[row_count] }
			if char == 'S' then
				start = { row = row_count, col = #grid[row_count] }
			elseif char == "E" then
				finish = { row = row_count, col = #grid[row_count] }
			end
		end
	end

	grid[start.row][start.col].direction = 'E'
	pathfinding.dijkstra(nodes, grid[start.row][start.col], get_neighbours)
	local path_length = grid[finish.row][finish.col].distance

	for i = 1, #grid do
		for j = 1, #grid[i] do
			grid[i][j].distance_from_start = grid[i][j].distance
			grid[i][j].distance = nil
			grid[i][j].direction = nil
			grid[i][j].from = nil
		end
	end

	grid[finish.row][finish.col].direction = 'S'
	pathfinding.dijkstra(nodes, grid[finish.row][finish.col], get_neighbours)
	local reversed_pathlength = grid[start.row][start.col].distance
	print(path_length)
	print(reversed_pathlength)

	local seats = {}
	for i = 1, #grid do
		for j = 1, #grid[i] do
			if grid[i][j].distance_from_start then
				if grid[i][j].distance_from_start + grid[i][j].distance <= path_length then
					seats[grid[i][j]] = 0
					grid[i][j].display = "O"
				end
			end
		end
	end

	-- local print_grid = ""
	-- for i = 1, #grid do
	-- 	for j = 1, #grid[i] do
	-- 		print_grid = print_grid .. grid[i][j].display
	-- 	end
	-- 	print_grid = print_grid .. "\n"
	-- end
	-- print(print_grid)

	local result = 0
	for _, _ in pairs(seats) do
		result = result + 1
	end
	return result
end

return day16
