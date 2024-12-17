local pathfinding = {}

pathfinding.dijkstra = function(nodes, start_node, neighbour_finder, end_node)
	local function sort_nodes(node_a, node_b)
		return node_a.distance > node_b.distance
	end

	local known_nodes = {}
	start_node.distance = 0
	table.insert(known_nodes, start_node)

	while #known_nodes > 0 do
		local curr_node = table.remove(known_nodes)
		for _, neighbour in pairs(neighbour_finder(curr_node)) do
			if (neighbour.node.distance or math.huge) > curr_node.distance + (neighbour.distance or 1) then
				if (neighbour.node.distance or math.huge) == math.huge then
					table.insert(known_nodes, neighbour.node)
				end
				neighbour.node.distance = curr_node.distance + (neighbour.distance or 1)
				neighbour.node.from = curr_node
			end
		end
		table.sort(known_nodes, sort_nodes)
	end
end

pathfinding.dijkstra_all = function(nodes, start_node, neighbour_finder, end_node)
	local function sort_nodes(node_a, node_b)
		return node_a.distance > node_b.distance
	end

	local known_nodes = {}
	start_node.distance = 0
	table.insert(known_nodes, start_node)

	while #known_nodes > 0 do
		local curr_node = table.remove(known_nodes)
		for _, neighbour in pairs(neighbour_finder(curr_node)) do
			if (neighbour.node.distance or math.huge) >= curr_node.distance + (neighbour.distance or 1) then
				if (neighbour.node.distance or math.huge) == math.huge then
					table.insert(known_nodes, neighbour.node)
				end
				neighbour.node.distance = curr_node.distance + (neighbour.distance or 1)
				if not neighbour.node.from then
					neighbour.node.from = {}
				end
				table.insert(neighbour.node.from, curr_node)
			end
		end
		table.sort(known_nodes, sort_nodes)
	end
end
return pathfinding
