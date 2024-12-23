local day21 = {}

local numeric_grid = {
	{ { display = '7' }, { display = '8' }, { display = '9' } },
	{ { display = '4' }, { display = '5' }, { display = '6' } },
	{ { display = '1' }, { display = '2' }, { display = '3' } },
	{ { display = " " }, { display = '0' }, { display = 'A' } }
}

local directional_grid = {
	{ { display = " " }, { display = '^' }, { display = 'A' } },
	{ { display = '<' }, { display = 'v' }, { display = '>' } }
}

local numeric_sequences = {}
local directional_sequences = {}

local function dijkstra(start_node, neighbour_finder)
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
				neighbour.node.from = { node = curr_node, sign = neighbour.sign }
			end
		end
		table.sort(known_nodes, sort_nodes)
	end
end

local function get_neighbours(node)
	return node.neighbours
end

local function build_seq_table()
	for i = 1, #numeric_grid do
		for j = 1, #numeric_grid[i] do
			if numeric_grid[i][j].display ~= " " then
				table.insert(numeric_sequences, { from = numeric_grid[i][j], to = {} })
				dijkstra(numeric_grid[i][j], get_neighbours)
				for i2 = 1, #numeric_grid do
					for j2 = 1, #numeric_grid[i] do
						local curr_node = numeric_grid[i2][j2]
						local sequence = ""
						while curr_node.from do
							sequence = curr_node.from.sign .. sequence
							curr_node = curr_node.from.node
						end
						sequence = sequence .. 'A'
						-- print(sequence)
						table.insert(numeric_sequences[#numeric_sequences].to, {
							display = numeric_grid[i2][j2].display,
							sequence =
								sequence
						})
					end
				end
				for i2 = 1, #numeric_grid do
					for j2 = 1, #numeric_grid[i] do
						numeric_grid[i2][j2].distance = nil
						numeric_grid[i2][j2].from = nil
					end
				end
			end
		end
	end
end

local function build_directional_seq_table()
	for i = 1, #directional_grid do
		for j = 1, #directional_grid[i] do
			if directional_grid[i][j].display ~= " " then
				table.insert(directional_sequences, { from = directional_grid[i][j], to = {} })
				dijkstra(directional_grid[i][j], get_neighbours)
				for i2 = 1, #directional_grid do
					for j2 = 1, #directional_grid[i] do
						local curr_node = directional_grid[i2][j2]
						local sequence = ""
						while curr_node.from do
							sequence = curr_node.from.sign .. sequence
							curr_node = curr_node.from.node
						end
						sequence = sequence .. 'A'
						-- print("inserting sequence from " .. directional_sequences[#directional_sequences].from.display)
						-- print("sequence to " .. directional_grid[i2][j2].display .. ": " .. sequence)
						table.insert(directional_sequences[#directional_sequences].to, {
							display = directional_grid[i2][j2].display,
							sequence =
								sequence
						})
					end
				end
				for i2 = 1, #directional_grid do
					for j2 = 1, #directional_grid[i] do
						directional_grid[i2][j2].distance = nil
						directional_grid[i2][j2].from = nil
					end
				end
			end
		end
	end
end

day21.part1 = function(file)
	numeric_grid[1][1].neighbours = { { node = numeric_grid[1][2], sign = '>' }, { node = numeric_grid[2][1], sign = 'v' } }
	numeric_grid[1][2].neighbours = { { node = numeric_grid[1][1], sign = '<' }, { node = numeric_grid[1][3], sign = '>' }, { node = numeric_grid[2][2], sign = 'v' } }
	numeric_grid[1][3].neighbours = { { node = numeric_grid[1][2], sign = '<' }, { node = numeric_grid[2][3], sign = 'v' } }
	numeric_grid[2][1].neighbours = { { node = numeric_grid[1][1], sign = '^' }, { node = numeric_grid[2][2], sign = '>' }, { node = numeric_grid[3][1], sign = 'v' } }
	numeric_grid[2][2].neighbours = { { node = numeric_grid[1][2], sign = '^' }, { node = numeric_grid[2][1], sign = '<' }, { node = numeric_grid[2][3], sign = '>' }, { node = numeric_grid[3][2], sign = 'v' } }
	numeric_grid[2][3].neighbours = { { node = numeric_grid[2][2], sign = '<' }, { node = numeric_grid[1][3], sign = '^' }, { node = numeric_grid[3][3], sign = 'v' } }
	numeric_grid[3][1].neighbours = { { node = numeric_grid[2][1], sign = '^' }, { node = numeric_grid[3][2], sign = '>' } }
	numeric_grid[3][2].neighbours = { { node = numeric_grid[2][2], sign = '^' }, { node = numeric_grid[3][1], sign = '<' }, { node = numeric_grid[3][3], sign = '>' }, { node = numeric_grid[4][2], sign = 'v' } }
	numeric_grid[3][3].neighbours = { { node = numeric_grid[3][2], sign = '<' }, { node = numeric_grid[2][3], sign = '^' }, { node = numeric_grid[4][3], sign = 'v' } }
	numeric_grid[4][2].neighbours = { { node = numeric_grid[3][2], sign = '^' }, { node = numeric_grid[4][3], sign = '>' } }
	numeric_grid[4][3].neighbours = { { node = numeric_grid[4][2], sign = '<' }, { node = numeric_grid[3][3], sign = '^' } }

	directional_grid[1][2].neighbours = { { node = directional_grid[1][3], sign = '>' }, { node = directional_grid[2][2], sign = 'v' } }
	directional_grid[1][3].neighbours = { { node = directional_grid[1][2], sign = '<' }, { node = directional_grid[2][3], sign = 'v' } }
	directional_grid[2][1].neighbours = { { node = directional_grid[2][2], sign = '>' } }
	directional_grid[2][2].neighbours = { { node = directional_grid[1][2], sign = '^' }, { node = directional_grid[2][1], sign = '<' }, { node = directional_grid[2][3], sign = '>' } }
	directional_grid[2][3].neighbours = { { node = directional_grid[2][2], sign = '<' }, { node = directional_grid[1][3], sign = '^' } }


	build_seq_table()
	build_directional_seq_table()

	local input = io.open(file, 'r')
	for line in input:lines() do
		local numbers = {}
		for char in string.gmatch(line, '.') do
			table.insert(numbers, char)
		end
		local from = 'A'
		local full_sequence = ""

		for _, number in ipairs(numbers) do
			for _, value in pairs(numeric_sequences) do
				if value.from.display == from then
					for _, towards in pairs(value.to) do
						if towards.display == number then
							full_sequence = full_sequence .. towards.sequence
						end
					end
				end
			end
			from = number
		end
		print(#full_sequence)

		from = 'A'
		local new_sequence = ""
		for i = 1, #full_sequence do
			local number = string.sub(full_sequence, i, i)
			for _, value in pairs(directional_sequences) do
				if value.from.display == from then
					for _, towards in pairs(value.to) do
						if towards.display == number then
							new_sequence = new_sequence .. towards.sequence
						end
					end
				end
			end
			from = number
		end
		print(#new_sequence)

		from = 'A'
		local final_sequence = ""
		for i = 1, #new_sequence do
			local number = string.sub(new_sequence, i, i)
			for _, value in pairs(directional_sequences) do
				if value.from.display == from then
					for _, towards in pairs(value.to) do
						if towards.display == number then
							final_sequence = final_sequence .. towards.sequence
						end
					end
				end
			end
			from = number
		end
		print(#final_sequence)
		print(string.rep('-', 30))
	end


	-- for _, value in pairs(numeric_sequences) do
	-- 	if value.from.display == from then
	-- 		for _, towards in pairs(value.to) do
	-- 			if towards.display == to then
	-- 				print(towards.sequence)
	-- 			end
	-- 		end
	-- 	end
	-- end
end

return day21
