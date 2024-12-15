local day14 = {}

day14.part1 = function(file)
	local local_file = io.open(file, 'r')
	local robots = {}
	for line in local_file:lines() do
		local x, y, mx, my = string.match(line, "(%d+),(%d+).-([-%d]+),([-%d]+)")
		table.insert(robots, { x = tonumber(x), y = tonumber(y), move_x = tonumber(mx), move_y = tonumber(my) })
	end

	local x_axis, y_axis = 101, 103
	local q1, q2, q3, q4 = 0, 0, 0, 0

	for _, robot in ipairs(robots) do
		robot.x = (robot.x + (100 * robot.move_x)) % x_axis
		robot.y = (robot.y + (100 * robot.move_y)) % y_axis
		if robot.x < x_axis // 2 then
			if robot.y < y_axis // 2 then
				q1 = q1 + 1
			elseif robot.y > y_axis // 2 then
				q2 = q2 + 1
			end
		elseif robot.x > x_axis // 2 then
			if robot.y < y_axis // 2 then
				q3 = q3 + 1
			elseif robot.y > y_axis // 2 then
				q4 = q4 + 1
			end
		end
	end

	return q1 * q2 * q3 * q4
end

--- Basically just print the grid after every second, making sure the entire grid fits on the terminal,
--- while using a small delay (I chose 0.01s) between every print. When a sudden flash appears, kill the program
--- and note down the loop. Set the starting location to a higher value by executing part 1 and repeat.
--- function below prints the christmas tree on my input
day14.part2 = function(file)
	local tree = 7286
	local local_file = io.open(file, 'r')
	local robots = {}
	for line in local_file:lines() do
		local x, y, mx, my = string.match(line, "(%d+),(%d+).-([-%d]+),([-%d]+)")
		table.insert(robots, { x = tonumber(x), y = tonumber(y), move_x = tonumber(mx), move_y = tonumber(my) })
	end

	local x_axis, y_axis = 101, 103

	local grid = {}

	for i = 1, x_axis do
		table.insert(grid, {})
		for j = 1, y_axis do
			grid[i][j] = "."
		end
	end

	for _, robot in ipairs(robots) do
		robot.x = (robot.x + (tree * robot.move_x)) % x_axis
		robot.y = (robot.y + (tree * robot.move_y)) % y_axis
		grid[robot.x + 1][robot.y + 1] = "#"
	end

	local print_grid = ""
	for i = 1, x_axis do
		for j = 1, y_axis do
			print_grid = print_grid .. grid[i][j]
		end
		print_grid = print_grid .. "\n"
	end
	print(print_grid)
	return tree
end

return day14
