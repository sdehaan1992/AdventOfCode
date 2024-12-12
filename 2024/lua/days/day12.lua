local day12 = {}

local plots, numrows, numcols, num_regions

local function get_dimensions(grid)
	local cols = string.find(grid, "\n", 1, true)
	local rows = string.len(grid) // cols

	return rows, cols - 1
end

local function get_neighbours_locations(point, rows, cols)
	local neighbours = {}
	if point > cols then
		table.insert(neighbours, point - cols)
	end
	if point <= (rows * cols) - cols then
		table.insert(neighbours, point + cols)
	end
	if point % cols > 0 then
		table.insert(neighbours, point + 1)
	end
	if (point - 1) % cols > 0 then
		table.insert(neighbours, point - 1)
	end

	return neighbours
end

local function get_directional_neighbours(point, rows, cols)
	local neighbours = { u = nil, d = nil, l = nil, r = nil, lu = nil, ld = nil, ru = nil, rd = nil }
	if point > cols then
		neighbours.u = point - cols
		if point % cols > 0 then
			neighbours.ru = point - cols + 1
		end
		if (point - 1) % cols > 0 then
			neighbours.lu = point - cols - 1
		end
	end
	if point <= (rows * cols) - cols then
		neighbours.d = point + cols
		if point % cols > 0 then
			neighbours.rd = point + cols + 1
		end
		if (point - 1) % cols > 0 then
			neighbours.ld = point + cols - 1
		end
	end
	if point % cols > 0 then
		neighbours.r = point + 1
	end
	if (point - 1) % cols > 0 then
		neighbours.l = point - 1
	end

	return neighbours
end

local function merge_regions(plots, region_into, region_from)
	for _, plot in ipairs(plots) do
		if plot.region == region_from then
			plot.region = region_into
		end
	end
end

day12.part1 = function(file)
	local grid = io.open(file, 'r'):read('a')
	numrows, numcols = get_dimensions(grid)
	plots = {}
	local regions = {}
	num_regions = 0
	local input, _ = string.gsub(grid, "\n", "")
	for i = 1, string.len(input) do
		local neighbours = get_neighbours_locations(i, numrows, numcols)
		local plot = { type = string.sub(input, i, i), perimeter = (4 - #neighbours), region = 0 }
		table.insert(plots, plot)
		for idx, neighbour_idx in ipairs(neighbours) do
			if string.sub(input, neighbour_idx, neighbour_idx) ~= plot.type then
				plot.perimeter = plot.perimeter + 1
			else
				if neighbour_idx < i then
					if plots[neighbour_idx].region ~= plot.region then
						merge_regions(plots, plots[neighbour_idx].region, plot.region)
					end
				end
			end
		end
		if plot.region == 0 then
			num_regions = num_regions + 1
			plot.region = num_regions
		end
	end

	for i = 1, num_regions do
		regions[i] = { area = 0, perimeter = 0 }
	end

	for _, plot in ipairs(plots) do
		regions[plot.region].area = regions[plot.region].area + 1
		regions[plot.region].perimeter = regions[plot.region].perimeter + plot.perimeter
	end

	local result = 0
	for _, region in ipairs(regions) do
		result = result + (region.area * region.perimeter)
	end

	return result
end

day12.part2 = function(file)
	if not plots then
		day12.part1(file)
	end
	for plot_idx, plot in ipairs(plots) do
		local neighbours = get_directional_neighbours(plot_idx, numrows, numcols)
		local up, left, right, down, leftup, leftdown, rightup, rightdown
		if neighbours.u then
			up = plots[neighbours.u].type
		end
		if neighbours.l then
			left = plots[neighbours.l].type
		end
		if neighbours.r then
			right = plots[neighbours.r].type
		end
		if neighbours.d then
			down = plots[neighbours.d].type
		end
		if neighbours.ld then
			leftdown = plots[neighbours.ld].type
		end
		if neighbours.lu then
			leftup = plots[neighbours.lu].type
		end
		if neighbours.ru then
			rightup = plots[neighbours.ru].type
		end
		if neighbours.rd then
			rightdown = plots[neighbours.rd].type
		end

		local corners = 0
		if up == plot.type and left == plot.type then
			if leftup ~= plot.type then
				corners = corners + 1
			end
		elseif up ~= plot.type and left ~= plot.type then
			corners = corners + 1
		end
		if up == plot.type and right == plot.type then
			if rightup ~= plot.type then
				corners = corners + 1
			end
		elseif up ~= plot.type and right ~= plot.type then
			corners = corners + 1
		end
		if down == plot.type and right == plot.type then
			if rightdown ~= plot.type then
				corners = corners + 1
			end
		elseif down ~= plot.type and right ~= plot.type then
			corners = corners + 1
		end
		if down == plot.type and left == plot.type then
			if leftdown ~= plot.type then
				corners = corners + 1
			end
		elseif down ~= plot.type and left ~= plot.type then
			corners = corners + 1
		end

		plot.corners = corners
	end

	local regions = {}
	for i = 1, num_regions do
		regions[i] = { area = 0, corners = 0 }
	end
	for _, plot in ipairs(plots) do
		regions[plot.region].area = regions[plot.region].area + 1
		regions[plot.region].corners = regions[plot.region].corners + plot.corners
	end

	local result = 0
	for _, region in ipairs(regions) do
		result = result + (region.area * region.corners)
	end

	return result
end

return day12
