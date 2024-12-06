local day6 = {}

local DIRECTION = { UP = 1, DOWN = 2, LEFT = 3, RIGHT = 4 }
local visits = {}
local objects = {}

local function walk(guard)
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

local function start_walking(guard, grid, row, col)
	local visit = {}
	while not ((guard.direction == DIRECTION.UP and guard.row == 1)
			or (guard.direction == DIRECTION.DOWN and guard.row == row)
			or (guard.direction == DIRECTION.LEFT and guard.col == 1)
			or (guard.direction == DIRECTION.RIGHT and guard.col == col)) do
		walk(guard)
		-- print("new loc: " .. guard.row .. "," .. guard.col)
		if grid[guard.row][guard.col] == nil then
			grid[guard.row][guard.col] = { marker = 'X', direction = { guard.direction } }
			table.insert(visit, { row = guard.row, col = guard.col })
		else
			for _, direction in pairs(grid[guard.row][guard.col].direction) do
				if direction == guard.direction then
					return visit, false
				end
			end
			table.insert(grid[guard.row][guard.col].direction, guard.direction)
		end
		-- table.insert(visit, { row = guard.row, col = guard.col })
	end
	return visit, true
end

day6.part1 = function(file)
	local local_file = io.open(file, "r")
	local guard = { col = 0, row = 0, direction = DIRECTION.UP, visits = 1 }
	local starting_point = {}
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
				starting_point.row = row
				starting_point.col = i
			end
		end
	end
	visits, _ = start_walking(guard, objects, row, col)
	table.insert(visits, 1, { row = starting_point.row, col = starting_point.col })
	return #visits
end

day6.part2 = function(file)
	if #visits == 0 then
		day6.part1(file)
	end

	local starting_point = { row = visits[1].row, col = visits[1].col }
	for i = 2, #visits do
		objects[visits[i].row][visits[i].col] = nil
	end

	local result = 0
	for i = 2, #visits do
		-- print("run number: " .. i)
		local add_object = { row = visits[i].row, col = visits[i].col }
		objects[add_object.row][add_object.col] = '#'
		-- print("setting object at: " .. add_object.row .. "," .. add_object.col)
		local guard = { row = starting_point.row, col = starting_point.col, direction = DIRECTION.UP }
		local attempt, success = start_walking(guard, objects, 130, 130)
		if not success then
			-- print("   failed")
			result = result + 1
			print(add_object.row .. "," .. add_object.col)
		end

		table.insert(attempt, 1, { row = starting_point.row, col = starting_point.col })
		for j = 1, #attempt do
			if attempt[j].row == 7 and attempt[j].col == 5 then
				-- print("clearing starting_point")
			end
			objects[attempt[j].row][attempt[j].col] = nil
			objects[add_object.row][add_object.col] = nil
		end
	end

	return result
end

return day6
