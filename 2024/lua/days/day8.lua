local day8 = {}

local valid_antinodes = {}
local rows = 0
local columns = 0

local function filter_antinodes(anti_nodes)
	for _, anti_node in pairs(anti_nodes) do
		if anti_node.row > 0 and anti_node.col > 0 and anti_node.row < rows + 1 and anti_node.col < columns + 1 then
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

local function determine_antinode(check_ant, against_ant, has_dissonance)
	local diff_row = math.abs(check_ant.row - against_ant.row)
	local diff_col = math.abs(check_ant.col - against_ant.col)
	local orig_row = diff_row
	local orig_col = diff_col

	local loops = 1
	if has_dissonance then
		loops = math.ceil(rows / math.min(orig_col, orig_row))
	end

	local anti_nodes = {}

	if check_ant.row < against_ant.row then
		if check_ant.col < against_ant.col then
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col - diff_col })
				table.insert(anti_nodes, { row = against_ant.row + diff_row, col = against_ant.col + diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		elseif check_ant.col > against_ant.col then
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col + diff_col })
				table.insert(anti_nodes, { row = against_ant.row + diff_row, col = against_ant.col - diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		else -- same column
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row - diff_row, col = check_ant.col })
				table.insert(anti_nodes, { row = against_ant.row + diff_row, col = check_ant.col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		end
	elseif check_ant.row > against_ant.row then
		if check_ant.col < against_ant.col then
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col - diff_col })
				table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col + diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		elseif check_ant.col > against_ant.col then
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col + diff_col })
				table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col - diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		else -- same column
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row + diff_row, col = check_ant.col })
				table.insert(anti_nodes, { row = against_ant.row - diff_row, col = against_ant.col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		end
	else
		if check_ant.col < against_ant.col then
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col - diff_col })
				table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col + diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		elseif check_ant.col > against_ant.col then
			for i = 1, loops do
				table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col + diff_col })
				table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col - diff_col })
				diff_row = diff_row + orig_row
				diff_col = diff_col + orig_col
			end
		else -- same object, should be impossible
		end
	end

	if has_dissonance then
		table.insert(anti_nodes, { row = check_ant.row, col = check_ant.col })
		table.insert(anti_nodes, { row = against_ant.row, col = against_ant.col })
	end

	filter_antinodes(anti_nodes)
end

local function execute(file, has_dissonance)
	local local_file = io.open(file, 'r')
	local antennas = {}
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
		columns = col
	end
	rows = row

	for _, type in pairs(antennas) do
		for i = 1, #type do
			for j = i + 1, #type do
				if i ~= j then
					determine_antinode(type[i], type[j], has_dissonance)
				end
			end
		end
	end

	return #valid_antinodes
end

day8.part1 = function(file)
	return execute(file, false)
end

day8.part2 = function(file)
	return execute(file, true)
end

return day8
