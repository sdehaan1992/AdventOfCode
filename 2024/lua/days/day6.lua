local day6 = {}

local DIRECTION = { UP = {}, DOWN = {}, LEFT = {}, RIGHT = {} }

local function walk(guard, objects)
	if guard.direction == DIRECTION.UP then
		if objects[guard.row - 1][guard.col] ~= '#' then
			guard.row = guard.row - 1
		else
			guard.direction = DIRECTION.RIGHT
		end
	elseif guard.direction == DIRECTION.DOWN then
		if objects[guard.row + 1][guard.col] ~= '#' then
			guard.row = guard.row + 1
		else
			guard.direction = DIRECTION.LEFT
		end
	elseif guard.direction == DIRECTION.LEFT then
		if objects[guard.row][guard.col - 1] ~= '#' then
			guard.col = guard.col - 1
		else
			guard.direction = DIRECTION.UP
		end
	else
		if objects[guard.row][guard.col + 1] ~= '#' then
			guard.col = guard.col + 1
		else
			guard.direction = DIRECTION.DOWN
		end
	end
end

local function start_walking(guard, objects, row, col, block)
	while not ((guard.direction == DIRECTION.UP and guard.row == 1)
			or (guard.direction == DIRECTION.DOWN and guard.row == row)
			or (guard.direction == DIRECTION.LEFT and guard.col == 1)
			or (guard.direction == DIRECTION.RIGHT and guard.col == col)) do
		if block then
		else
			walk(guard, objects)
			if objects[guard.row][guard.col] == nil then
				guard.visits = guard.visits + 1
				objects[guard.row][guard.col] = { marker = 'X', direction = { guard.direction } }
			else
				for _, direction in pairs(objects[guard.row][guard.col].direction) do
					if direction == guard.direction then
						return false
					end
				end
				table.insert(objects[guard.row][guard.col].direction, guard.direction)
			end
		end
	end
	return true
end

day6.part1 = function(file)
	local local_file = io.open(file, "r")
	local guard = { col = 0, row = 0, direction = DIRECTION.UP, visits = 1 }
	local objects = {}
	local row = 0
	local col = 0
	for line in local_file:lines() do
		row = row + 1
		objects[row] = {}
		col = #line
		for i = 1, #line do
			local byte = string.byte(line, i, i)
			if byte == 35 then
				objects[row][i] = '#'
			elseif byte == 94 then
				guard.col = i
				guard.row = row
				objects[row][i] = { marker = "X", direction = { DIRECTION.UP } }
			end
		end
	end

	start_walking(guard, objects, row, col)
	return guard.visits
end

day6.part2 = function(file)
	local local_file = io.open(file, "r")
	local guard = { col = 0, row = 0, direction = DIRECTION.UP, visits = 0 }
	local objects = {}
	local row = 0
	local col = 0
	local starting_guard = {}
	for line in local_file:lines() do
		row = row + 1
		objects[row] = {}
		col = #line
		for i = 1, #line do
			local byte = string.byte(line, i, i)
			if byte == 35 then
				objects[row][i] = '#'
			elseif byte == 94 then
				guard.col = i
				starting_guard.col = i
				guard.row = row
				starting_guard.row = row
				objects[row][i] = { marker = "X", direction = { DIRECTION.UP } }
			end
		end
	end

	local result = 0
	for i = 1, row do
		for j = 1, col do
			local block_attempt = table.move(objects, 1, #objects, 1)
			guard.col = starting_guard.col
			guard.row = starting_guard.row
			block_attempt[i][j] = '#'
			if not start_walking(guard, block_attempt, row, col) then
				result = result + 1
			end
		end
	end

	return result
end

return day6
