local pathfinding = {}

pathfinding.dijkstra = function(nodes, start_node, neighbour_finder, end_node)
	local function sort_nodes(node_a, node_b)
		return node_a.distance > node_b.distance
	end

	local known_nodes = {}
	start_node.distance = 0
	table.insert(known_nodes, start_node)

	while #known_nodes > 0 do
		local node = table.remove(known_nodes)
		for _, neighbour in pairs(neighbour_finder(node)) do
			if (neighbour.node.distance or math.huge) > node.distance + (neighbour.distance or 1) then
				if (neighbour.node.distance or math.huge) == math.huge then
					table.insert(known_nodes, neighbour.node)
				end
				neighbour.node.distance = node.distance + (neighbour.distance or 1)
				neighbour.node.from = node
			end
		end
		table.sort(known_nodes, sort_nodes)
	end
end

return pathfinding
