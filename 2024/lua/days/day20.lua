local day20 = {}

local grid = {}
local cols, rows = 0, 0

local function get_dimensions(map)
	local cols = string.find(map, "\n")
	local rows = string.len(map) // cols

	return rows, cols - 1
end

local function get_wall_neighbours(node)
	local neighbours = {}
	if node.row > 1 then
		local neighbour = grid[node.row - 1][node.col]
		if neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour })
		end
	end
	if node.row < #grid then
		local neighbour = grid[node.row + 1][node.col]
		if neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour })
		end
	end
	if node.col > 1 then
		local neighbour = grid[node.row][node.col - 1]
		if neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour })
		end
	end
	if node.col < #grid[node.row] then
		local neighbour = grid[node.row][node.col + 1]
		if neighbour.display ~= '#' then
			table.insert(neighbours, { node = neighbour })
		end
	end

	return neighbours
end

local function get_neighbours(node)
	if node.display == '#' then
		return {}
	end

	local neighbours = {}
	if node.row > 1 then
		local neighbour = grid[node.row - 1][node.col]
		table.insert(neighbours, { node = neighbour })
	end
	if node.row < #grid then
		local neighbour = grid[node.row + 1][node.col]
		table.insert(neighbours, { node = neighbour })
	end
	if node.col > 1 then
		local neighbour = grid[node.row][node.col - 1]
		table.insert(neighbours, { node = neighbour })
	end
	if node.col < #grid[node.row] then
		local neighbour = grid[node.row][node.col + 1]
		table.insert(neighbours, { node = neighbour })
	end

	return neighbours
end

day20.part1 = function(file)
	local input = io.open(file, 'r'):read('a')
	cols, rows = get_dimensions(input)

	for i = 1, rows do
		grid[i] = {}
	end

	local start = nil
	local walls = {}
	local finish = nil
	local row = 0
	for line in string.gmatch(input, '(.-)\n') do
		row = row + 1
		for char in string.gmatch(line, '.') do
			table.insert(grid[row], { display = char, row = row, col = #grid[row] + 1 })
			if char == 'S' then
				start = grid[row][#grid[row]]
			elseif char == 'E' then
				finish = grid[row][#grid[row]]
			elseif char == '#' then
				table.insert(walls, grid[row][#grid[row]])
			end
		end
	end

	require("pathfinding").dijkstra(start, get_neighbours)
	local cheats = 0
	for _, node in ipairs(walls) do
		for _, neighbour in ipairs(get_wall_neighbours(node)) do
			if neighbour.node.distance > node.distance then
				if neighbour.node.distance - node.distance > 100 then
					cheats = cheats + 1
				end
			end
		end
	end

	return cheats
end

day20.part2 = function(file)
	local input = io.open(file, 'r'):read('a')
	cols, rows = get_dimensions(input)

	for i = 1, rows do
		grid[i] = {}
	end

	local start = nil
	local walls = {}
	local finish = nil
	local row = 0
	for line in string.gmatch(input, '(.-)\n') do
		row = row + 1
		for char in string.gmatch(line, '.') do
			table.insert(grid[row], { display = char, row = row, col = #grid[row] + 1 })
			if char == 'S' then
				start = grid[row][#grid[row]]
			elseif char == 'E' then
				finish = grid[row][#grid[row]]
			end
		end
	end
	require("pathfinding").dijkstra(start, get_wall_neighbours)
	local path = {}
	local curr_node = finish
	while curr_node do
		table.insert(path, curr_node)
		curr_node = curr_node.from
	end

	local cheats = 0
	for _, node in ipairs(path) do
		for i = 1, #grid do
			for j = 1, #grid[i] do
				local manhattan_distance = math.abs(node.row - i) + math.abs(node.col - j)
				if manhattan_distance <= 20 and grid[i][j].display ~= '#' and node.distance + manhattan_distance + 100 <= grid[i][j].distance then
					cheats = cheats + 1
				end
			end
		end
	end

	return cheats
end

return day20
