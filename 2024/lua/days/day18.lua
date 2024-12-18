local day18 = {}

local grid = {}

local function print_grid()
	local str = ""
	for i = 1, #grid do
		for j = 1, #grid[i] do
			str = str .. grid[i][j].display
		end
		str = str .. "\n"
	end

	print(str)
end

local function get_neighbours(node)
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

day18.part1 = function(file, bits, dim)
	local input = io.open(file, 'r'):read('a')
	for i = 1, dim do
		grid[i] = {}
		for j = 1, dim do
			grid[i][j] = { display = '.', row = i, col = j }
		end
	end

	local count = 0
	for col, row in string.gmatch(input, "(%d+),(%d+)") do
		grid[tonumber(row) + 1][tonumber(col) + 1].display = '#'
		count = count + 1
		if count == bits then
			break
		end
	end

	require("pathfinding").dijkstra(grid[1][1], get_neighbours)

	return grid[dim][dim].distance
end

day18.part2 = function(file, bits, dim)
	local input = io.open(file, 'r'):read('a')
	for i = 1, dim do
		grid[i] = {}
		for j = 1, dim do
			grid[i][j] = { display = '.', row = i, col = j }
		end
	end

	local count = 0
	for col, row in string.gmatch(input, "(%d+),(%d+)") do
		grid[tonumber(row) + 1][tonumber(col) + 1].display = '#'
		count = count + 1
		if count == bits then
			break
		end
	end

	local pathfinding = require("pathfinding")
	pathfinding.dijkstra(grid[1][1], get_neighbours)

	local create_path = function()
		local path = {}
		local curr_node = grid[dim][dim]
		while curr_node.from do
			curr_node = curr_node.from
			table.insert(path, curr_node)
		end
		return path
	end

	local path = create_path()

	local is_blocked = function()
		for i = 1, #grid do
			for j = 1, #grid[i] do
				grid[i][j].distance = nil
				grid[i][j].from = nil
			end
		end

		pathfinding.dijkstra(grid[1][1], get_neighbours)
		path = create_path()
		return not grid[dim][dim].distance
	end

	for col, row in string.gmatch(input, "(%d+),(%d+)") do
		local bit_node = grid[tonumber(row) + 1][tonumber(col) + 1]
		bit_node.display = '#'
		for _, node in ipairs(path) do
			if bit_node == node then
				if is_blocked() then
					return col .. "," .. row
				else
					break
				end
			end
		end
	end
end

return day18
