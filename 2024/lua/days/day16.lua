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
	pathfinding.dijkstra(grid[start.row][start.col], get_neighbours)

	return grid[finish.row][finish.col].distance
end

day16.part2 = function(file)
	local nodekey = function(row, col, dir)
		return "r" .. tostring(row) .. ",c" .. tostring(col) .. "," .. dir
	end

	local neighbour_finder = function(node)
		local reachable_neighbours = {}
		for _, neighbour in pairs(node.neighbours) do
			if neighbour.node.display and neighbour.node.display ~= '#' then
				table.insert(reachable_neighbours, neighbour)
			end
		end
		return reachable_neighbours
	end

	local input = io.open(file, 'r'):read('a')
	rows, cols = get_dimensions(input)

	local start
	local finish
	local nodes = {}

	local row_count = 0
	for line in string.gmatch(input, "(.-)\n") do
		row_count = row_count + 1
		local col_count = 1
		for char in string.gmatch(line, ".") do
			local nodeN = { display = char, direction = "N", row = row_count, col = col_count }
			local nodeS = { display = char, direction = "S", row = row_count, col = col_count }
			local nodeW = { display = char, direction = "W", row = row_count, col = col_count }
			local nodeE = { display = char, direction = "E", row = row_count, col = col_count }
			nodeN.neighbours = { { node = nodeE, distance = 1000 }, { node = nodeW, distance = 1000 }, { node = nodeS, distance = 1000 } }
			nodeS.neighbours = { { node = nodeN, distance = 1000 }, { node = nodeW, distance = 1000 }, { node = nodeE, distance = 1000 } }
			nodeW.neighbours = { { node = nodeN, distance = 1000 }, { node = nodeS, distance = 1000 }, { node = nodeE, distance = 1000 } }
			nodeE.neighbours = { { node = nodeN, distance = 1000 }, { node = nodeW, distance = 1000 }, { node = nodeS, distance = 1000 } }
			nodes[nodekey(row_count, col_count, nodeN.direction)] = nodeN
			nodes[nodekey(row_count, col_count, nodeS.direction)] = nodeS
			nodes[nodekey(row_count, col_count, nodeW.direction)] = nodeW
			nodes[nodekey(row_count, col_count, nodeE.direction)] = nodeE
			col_count = col_count + 1
			if char == 'S' then
				start = nodeE
			elseif char == "E" then
				finish = { nodeN, nodeS, nodeE, nodeW }
			end
		end
	end

	for _, node in pairs(nodes) do
		if node.direction == 'N' then
			table.insert(node.neighbours, { node = nodes[nodekey(node.row - 1, node.col, node.direction)], distance = 1 })
		elseif node.direction == 'S' then
			table.insert(node.neighbours, { node = nodes[nodekey(node.row + 1, node.col, node.direction)], distance = 1 })
		elseif node.direction == 'E' then
			table.insert(node.neighbours, { node = nodes[nodekey(node.row, node.col + 1, node.direction)], distance = 1 })
		else
			table.insert(node.neighbours, { node = nodes[nodekey(node.row, node.col - 1, node.direction)], distance = 1 })
		end
	end

	pathfinding.dijkstra_all(start, neighbour_finder)

	local fastest_nodes = {}
	local function trace_route(node)
		fastest_nodes[nodekey(node.row, node.col, "")] = node
		for _, curr_node in ipairs(node.from) do
			if curr_node ~= start then
				trace_route(curr_node)
			end
		end
	end
	fastest_nodes[nodekey(start.row, start.col, "")] = start

	local min_route = math.min(finish[1].distance, finish[2].distance, finish[3].distance, finish[4].distance)
	for _, finish_node in ipairs(finish) do
		if finish_node.distance == min_route then
			trace_route(finish_node)
		end
	end

	local result = 0
	for _, node in pairs(fastest_nodes) do
		result = result + 1
	end

	return result
end

return day16
