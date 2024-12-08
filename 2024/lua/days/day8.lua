local day8 = {}

local valid_antinodes = {}

local function determine_antinode(check_ant, against_ant)
	local diff_row = math.abs(check_ant.row - against_ant.row)
	local diff_col = math.abs(check_ant.col - against_ant.col)

	local anti_nodes = {}

	if check_ant.row < against_ant.row then
		if check_ant.col < against_ant.col then
			table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col - diff_col })
			table.insert(anti_nodes, { row = against_ant.row + diff_row, col = against_ant.col + diff_col })
		elseif check_ant.col > against_ant.col then
			table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col + diff_col })
			table.insert(anti_nodes, { row = against_ant.row + diff_row, col = against_ant.col - diff_col })
		else -- same column
			table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col })
			table.insert(anti_nodes, { row = against_ant.row + diff_row, col = check_ant.col })
		end
	elseif check_ant.row > against_ant.row then
		if check_ant.col < against_ant.col then
			table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col - diff_col })
			table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col + diff_col })
		elseif check_ant.col > against_ant.col then
			table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col + diff_col })
			table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col - diff_col })
		else -- same column
			table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col })
			table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col })
		end
	else
		if check_ant.col < against_ant.col then
			table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col - diff_col })
			table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col + diff_col })
		elseif check_ant.col > against_ant.col then
			table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col + diff_col })
			table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col - diff_col })
		else -- same object, should be impossible
		end
	end

	for _, anti_node in pairs(anti_nodes) do
		if anti_node.row > 0 and anti_node.col > 0 and anti_node.row < 51 and anti_node.col < 51 then
			local duplicate = false
			for _, node in pairs(valid_antinodes) do
				if node.row == anti_node.row and node.col == anti_node.col then
					duplicate = true
					break
				end
			end
			if not duplicate then
				-- print("antinode at: " .. anti_node.row .. "," .. anti_node.col)
				table.insert(valid_antinodes, anti_node)
			end
		end
	end
end

local function determine_antinode2(check_ant, against_ant)
	local diff_row = math.abs(check_ant.row - against_ant.row)
	local diff_col = math.abs(check_ant.col - against_ant.col)
	local orig_row = diff_row
	local orig_col = diff_col

	local anti_nodes = {}

	if check_ant.row < against_ant.row then
		if check_ant.col < against_ant.col then
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col - diff_col })
				table.insert(anti_nodes, { row = against_ant.row + diff_row, col = against_ant.col + diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		elseif check_ant.col > against_ant.col then
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col + diff_col })
				table.insert(anti_nodes, { row = against_ant.row + diff_row, col = against_ant.col - diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		else -- same column
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col })
				table.insert(anti_nodes, { row = against_ant.row + diff_row, col = check_ant.col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		end
	elseif check_ant.row > against_ant.row then
		if check_ant.col < against_ant.col then
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col - diff_col })
				table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col + diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		elseif check_ant.col > against_ant.col then
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col + diff_col })
				table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col - diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		else -- same column
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col })
				table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		end
	else
		if check_ant.col < against_ant.col then
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col - diff_col })
				table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col + diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		elseif check_ant.col > against_ant.col then
			for i = 1, 50 do
				table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col + diff_col })
				table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col - diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		else -- same object, should be impossible
		end
	end

	table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col })
	table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col })

	for _, anti_node in pairs(anti_nodes) do
		if anti_node.row > 0 and anti_node.col > 0 and anti_node.row < 51 and anti_node.col < 51 then
			local duplicate = false
			for _, node in pairs(valid_antinodes) do
				if node.row == anti_node.row and node.col == anti_node.col then
					duplicate = true
					break
				end
			end
			if not duplicate then
				-- print("antinode at: " .. anti_node.row .. "," .. anti_node.col)
				table.insert(valid_antinodes, anti_node)
			end
		end
	end
end

day8.part1 = function(file)
	local local_file = io.open(file, 'r')
	local antennas = {}
	local result = 0
	local row = 0
	for line in local_file:lines() do
		row = row + 1
		local col = 0
		for char in line:gmatch('.') do
			col = col + 1
			if char ~= '.' then
				if antennas[char] == nil then
					antennas[char] = {}
				end
				table.insert(antennas[char], { row = row, col = col })
			end
		end
	end

	for _, type in pairs(antennas) do
		for i = 1, #type do
			for j = i + 1, #type do
				if i ~= j then
					determine_antinode(type[i], type[j])
				end
			end
		end
	end

	return #valid_antinodes
end

day8.part2 = function(file)
	valid_antinodes = {}
	local local_file = io.open(file, 'r')
	local antennas = {}
	local result = 0
	local row = 0
	for line in local_file:lines() do
		row = row + 1
		local col = 0
		for char in line:gmatch('.') do
			col = col + 1
			if char ~= '.' then
				if antennas[char] == nil then
					antennas[char] = {}
				end
				table.insert(antennas[char], { row = row, col = col })
			end
		end
	end

	for _, type in pairs(antennas) do
		for i = 1, #type do
			for j = i + 1, #type do
				if i ~= j then
					determine_antinode2(type[i], type[j])
				end
			end
		end
	end

	return #valid_antinodes
end
return day8
