local day15 = {}

local function get_dimensions(map)
	local cols = string.find(map, "\n")
	local rows = string.len(map) // cols

	return rows, cols - 1
end

local function move_part1(movement, object, grid)
	if movement == "<" then
		if grid[object.row][object.col - 1] == "O" then
			move_part1(movement, { row = object.row, col = object.col - 1 }, grid)
		end
		if grid[object.row][object.col - 1] == "." then
			grid[object.row][object.col - 1] = grid[object.row][object.col]
			grid[object.row][object.col] = "."
			return { row = object.row, col = object.col - 1 }
		else
			return object
		end
	elseif movement == ">" then
		if grid[object.row][object.col + 1] == "O" then
			move_part1(movement, { row = object.row, col = object.col + 1 }, grid)
		end
		if grid[object.row][object.col + 1] == "." then
			grid[object.row][object.col + 1] = grid[object.row][object.col]
			grid[object.row][object.col] = "."
			return { row = object.row, col = object.col + 1 }
		else
			return object
		end
	elseif movement == "v" then
		if grid[object.row + 1][object.col] == "O" then
			move_part1(movement, { row = object.row + 1, col = object.col }, grid)
		end
		if grid[object.row + 1][object.col] == "." then
			grid[object.row + 1][object.col] = grid[object.row][object.col]
			grid[object.row][object.col] = "."
			return { row = object.row + 1, col = object.col }
		else
			return object
		end
	else
		if grid[object.row - 1][object.col] == "O" then
			move_part1(movement, { row = object.row - 1, col = object.col }, grid)
		end
		if grid[object.row - 1][object.col] == "." then
			grid[object.row - 1][object.col] = grid[object.row][object.col]
			grid[object.row][object.col] = "."
			return { row = object.row - 1, col = object.col }
		else
			return object
		end
	end
end

local function can_move(movement, object, grid, is_wide_object)
	if movement == "<" then
		if grid[object.row][object.col - 1] == "]" or grid[object.row][object.col - 1] == "[" then
			if not can_move(movement, { row = object.row, col = object.col - 1 }, grid) then
				return false
			end
		end
		if grid[object.row][object.col - 1] == "#" then
			return false
		else
			return true
		end
	elseif movement == ">" then
		if grid[object.row][object.col + 1] == "]" or grid[object.row][object.col + 1] == "[" then
			if not can_move(movement, { row = object.row, col = object.col + 1 }, grid) then
				return false
			end
		end
		if grid[object.row][object.col + 1] == "#" then
			return false
		else
			return true
		end
	elseif movement == "v" then
		if not is_wide_object then
			if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" then
				if not can_move(movement, { row = object.row + 1, col = object.col }, grid, true) then
					return false
				end
			end
			if grid[object.row + 1][object.col] == "#" then
				return false
			else
				return true
			end
		else
			if grid[object.row][object.col] == "[" then
				if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" or grid[object.row + 1][object.col + 1] == "[" then
					if grid[object.row + 1][object.col + 1] == "[" then
						if not can_move(movement, { row = object.row + 1, col = object.col + 1 }, grid, true) then
							return false
						end
					end
					if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" then
						if not can_move(movement, { row = object.row + 1, col = object.col }, grid, true) then
							return false
						end
					end
				end
				if grid[object.row + 1][object.col] == "#" or grid[object.row + 1][object.col + 1] == "#" then
					return false
				else
					return true
				end
			else
				if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" or grid[object.row + 1][object.col - 1] == "]" then
					if grid[object.row + 1][object.col - 1] == "]" then
						if not can_move(movement, { row = object.row + 1, col = object.col - 1 }, grid, true) then
							return false
						end
					end
					if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" then
						if not can_move(movement, { row = object.row + 1, col = object.col }, grid, true) then
							return false
						end
					end
				end
				if grid[object.row + 1][object.col] == "#" or grid[object.row + 1][object.col - 1] == "#" then
					return false
				else
					return true
				end
			end
		end
	else
		if not is_wide_object then
			if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" then
				if not can_move(movement, { row = object.row - 1, col = object.col }, grid, true) then
					return false
				end
			end
			if grid[object.row - 1][object.col] == "#" then
				return false
			else
				return true
			end
		else
			if grid[object.row][object.col] == "[" then
				if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" or grid[object.row - 1][object.col + 1] == "[" then
					if grid[object.row - 1][object.col + 1] == "[" then
						if not can_move(movement, { row = object.row - 1, col = object.col + 1 }, grid, true) then
							return false
						end
					end
					if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" then
						if not can_move(movement, { row = object.row - 1, col = object.col }, grid, true) then
							return false
						end
					end
				end
				if grid[object.row - 1][object.col] == "#" or grid[object.row - 1][object.col + 1] == "#" then
					return false
				else
					return true
				end
			else
				if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" or grid[object.row - 1][object.col - 1] == "]" then
					if grid[object.row - 1][object.col - 1] == "]" then
						if not can_move(movement, { row = object.row - 1, col = object.col - 1 }, grid, true) then
							return false
						end
					end
					if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" then
						if not can_move(movement, { row = object.row - 1, col = object.col }, grid, true) then
							return false
						end
					end
				end
				if grid[object.row - 1][object.col] == "#" or grid[object.row - 1][object.col - 1] == "#" then
					return false
				else
					return true
				end
			end
		end
	end
end

local function move_part2(movement, object, grid, is_wide_object)
	if movement == "<" then
		if grid[object.row][object.col - 1] == "]" or grid[object.row][object.col - 1] == "[" then
			move_part2(movement, { row = object.row, col = object.col - 1 }, grid)
		end
		if grid[object.row][object.col - 1] == "." then
			grid[object.row][object.col - 1] = grid[object.row][object.col]
			grid[object.row][object.col] = "."
			return { row = object.row, col = object.col - 1 }
		else
			return object
		end
	elseif movement == ">" then
		if grid[object.row][object.col + 1] == "]" or grid[object.row][object.col + 1] == "[" then
			move_part2(movement, { row = object.row, col = object.col + 1 }, grid)
		end
		if grid[object.row][object.col + 1] == "." then
			grid[object.row][object.col + 1] = grid[object.row][object.col]
			grid[object.row][object.col] = "."
			return { row = object.row, col = object.col + 1 }
		else
			return object
		end
	elseif movement == "v" then
		if not is_wide_object then
			if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" then
				move_part2(movement, { row = object.row + 1, col = object.col }, grid, true)
			end
			if grid[object.row + 1][object.col] == "." then
				grid[object.row + 1][object.col] = grid[object.row][object.col]
				grid[object.row][object.col] = "."
				return { row = object.row + 1, col = object.col }
			else
				return object
			end
		else
			if grid[object.row][object.col] == "[" then
				if grid[object.row + 1][object.col] == "#" or grid[object.row + 1][object.col + 1] == "#" then
					return object
				end
				if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" or grid[object.row + 1][object.col + 1] == "[" then
					if grid[object.row + 1][object.col + 1] == "[" then
						move_part2(movement, { row = object.row + 1, col = object.col + 1 }, grid, true)
					end
					if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" then
						move_part2(movement, { row = object.row + 1, col = object.col }, grid, true)
					end
				end
				if grid[object.row + 1][object.col] == "." and grid[object.row + 1][object.col + 1] == "." then
					grid[object.row + 1][object.col] = grid[object.row][object.col]
					grid[object.row + 1][object.col + 1] = grid[object.row][object.col + 1]
					grid[object.row][object.col] = "."
					grid[object.row][object.col + 1] = "."
					return { row = object.row + 1, col = object.col }
				end
			else
				if grid[object.row + 1][object.col] == "#" or grid[object.row + 1][object.col - 1] == "#" then
					return object
				end
				if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" or grid[object.row + 1][object.col - 1] == "]" then
					if grid[object.row + 1][object.col - 1] == "]" then
						move_part2(movement, { row = object.row + 1, col = object.col - 1 }, grid, true)
					end
					if grid[object.row + 1][object.col] == "[" or grid[object.row + 1][object.col] == "]" then
						move_part2(movement, { row = object.row + 1, col = object.col }, grid, true)
					end
				end
				if grid[object.row + 1][object.col] == "." and grid[object.row + 1][object.col - 1] == "." then
					grid[object.row + 1][object.col] = grid[object.row][object.col]
					grid[object.row + 1][object.col - 1] = grid[object.row][object.col - 1]
					grid[object.row][object.col] = "."
					grid[object.row][object.col - 1] = "."
					return { row = object.row + 1, col = object.col }
				end
			end
		end
	else
		if not is_wide_object then
			if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" then
				move_part2(movement, { row = object.row - 1, col = object.col }, grid, true)
			end
			if grid[object.row - 1][object.col] == "." then
				grid[object.row - 1][object.col] = grid[object.row][object.col]
				grid[object.row][object.col] = "."
				return { row = object.row - 1, col = object.col }
			else
				return object
			end
		else
			if grid[object.row][object.col] == "[" then
				if grid[object.row - 1][object.col] == "#" or grid[object.row - 1][object.col + 1] == "#" then
					return object
				end
				if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" or grid[object.row - 1][object.col + 1] == "[" then
					if grid[object.row - 1][object.col + 1] == "[" then
						move_part2(movement, { row = object.row - 1, col = object.col + 1 }, grid, true)
					end
					if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" then
						move_part2(movement, { row = object.row - 1, col = object.col }, grid, true)
					end
				end
				if grid[object.row - 1][object.col] == "." and grid[object.row - 1][object.col + 1] == "." then
					grid[object.row - 1][object.col] = grid[object.row][object.col]
					grid[object.row - 1][object.col + 1] = grid[object.row][object.col + 1]
					grid[object.row][object.col] = "."
					grid[object.row][object.col + 1] = "."
					return { row = object.row - 1, col = object.col }
				end
			else
				if grid[object.row - 1][object.col] == "#" or grid[object.row - 1][object.col - 1] == "#" then
					return object
				end
				if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" or grid[object.row - 1][object.col - 1] == "]" then
					if grid[object.row - 1][object.col - 1] == "]" then
						move_part2(movement, { row = object.row - 1, col = object.col - 1 }, grid, true)
					end
					if grid[object.row - 1][object.col] == "[" or grid[object.row - 1][object.col] == "]" then
						move_part2(movement, { row = object.row - 1, col = object.col }, grid, true)
					end
				end
				if grid[object.row - 1][object.col] == "." and grid[object.row - 1][object.col - 1] == "." then
					grid[object.row - 1][object.col] = grid[object.row][object.col]
					grid[object.row - 1][object.col - 1] = grid[object.row][object.col - 1]
					grid[object.row][object.col] = "."
					grid[object.row][object.col - 1] = "."
					return { row = object.row - 1, col = object.col }
				end
			end
		end
	end
end

day15.part1 = function(file)
	local input = io.open(file, 'r'):read('a')
	local split = string.find(input, "\n\n")
	local map_as_string = string.sub(input, 1, split)
	local movements = string.gsub(string.sub(input, split + 2), "\n", "")
	local rows, cols = get_dimensions(map_as_string)
	local grid = {}

	local robot_pos

	for i = 1, rows do
		grid[i] = {}
	end

	local row_count = 0
	for line in string.gmatch(map_as_string, "(.-)\n") do
		row_count = row_count + 1
		for char in string.gmatch(line, ".") do
			table.insert(grid[row_count], char)
			if char == "@" then
				robot_pos = { row = row_count, col = #grid[row_count] }
			end
		end
	end

	for char in string.gmatch(movements, ".") do
		robot_pos = move_part1(char, robot_pos, grid)
	end

	local result = 0
	for i = 1, rows do
		for j = 1, cols do
			if grid[i][j] == "O" then
				result = 100 * (i - 1) + (j - 1) + result
			end
		end
	end

	return result
end

day15.part2 = function(file)
	local input = io.open(file, 'r'):read('a')
	local split = string.find(input, "\n\n")
	local map_as_string = string.sub(input, 1, split)
	local movements = string.gsub(string.sub(input, split + 2), "\n", "")
	local rows, cols = get_dimensions(map_as_string)
	local grid = {}

	local robot_pos

	for i = 1, rows do
		grid[i] = {}
	end

	local row_count = 0
	for line in string.gmatch(map_as_string, "(.-)\n") do
		row_count = row_count + 1
		for char in string.gmatch(line, ".") do
			if char == "O" then
				table.insert(grid[row_count], "[")
				table.insert(grid[row_count], "]")
			else
				table.insert(grid[row_count], char)
				if char == "@" then
					robot_pos = { row = row_count, col = #grid[row_count] }
				end
				if char == "." or char == "@" then
					table.insert(grid[row_count], ".")
				else
					table.insert(grid[row_count], "#")
				end
			end
		end
	end

	for char in string.gmatch(movements, ".") do
		if can_move(char, robot_pos, grid) then
			robot_pos = move_part2(char, robot_pos, grid)
		end
	end

	cols = cols * 2
	local result = 0
	for i = 1, rows do
		for j = 1, cols do
			if grid[i][j] == "[" then
				result = 100 * (i - 1) + (j - 1) + result
			end
		end
	end

	return result
end

return day15
