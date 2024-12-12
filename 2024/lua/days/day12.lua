local day12 = {}

local direction = { UP = 1, DOWN = 2, RIGHT = 3, LEFT = 4 }

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

local function merge_regions(plots, region_into, region_from)
	for _, plot in ipairs(plots) do
		if plot.region == region_from then
			plot.region = region_into
		end
	end
end

day12.part1 = function(file)
	local grid = io.open(file, 'r'):read('a')
	local rows, cols = get_dimensions(grid)
	local plots = {}
	local regions = {}
	local num_regions = 0
	local input, _ = string.gsub(grid, "\n", "")
	for i = 1, string.len(input) do
		local neighbours = get_neighbours_locations(i, rows, cols)
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
	local grid = io.open(file, 'r'):read('a')
	local rows, cols = get_dimensions(grid)
	local plots = {}
	local regions = {}
	local num_regions = 0
	local input, _ = string.gsub(grid, "\n", "")
	for i = 1, string.len(input) do
		local neighbours = get_neighbours_locations(i, rows, cols)
		local plot = { type = string.sub(input, i, i), perimeter = (4 - #neighbours), region = 0, corners = 0 }
		table.insert(plots, plot)
		for _, neighbour_idx in ipairs(neighbours) do
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

	-- for _, region in ipairs(regions) do
	-- 	local corners = 0
	for plot_idx, plot in ipairs(plots) do
		local corners = 0
		local neighbours = get_neighbours_locations(plot_idx, rows, cols)
		local regional_neighbours = {}
		for _, neighbour in ipairs(neighbours) do
			if plots[neighbour].region == plot.region then
				table.insert(regional_neighbours, neighbour)
			end
		end
		-- print("NEXT PLOT-----------------------------------------------------------")

		local regional_edges = 4 - #regional_neighbours
		-- print("Neighbour of plot of type: " .. plot.type .. " has " .. regional_edges .. " regional_edges")
		if regional_edges == 2 then
			if (plots[regional_neighbours[1]] == plots[plot_idx + 1] and plots[regional_neighbours[2]] == plots[plot_idx - 1]) or (plots[regional_neighbours[1]] == plots[plot_idx - cols] and plots[regional_neighbours[2]] == plots[plot_idx + cols]) then
				corners = corners
			else
				corners = corners + 1
				if plots[regional_neighbours[1]] == plots[plot_idx - cols] then
					if plots[regional_neighbours[2]] == plots[plot_idx + 1] then
						if plots[plot_idx - cols + 1].type ~= plot.type then
							corners = corners + 1
							-- print("right top is not a regional neighbour")
						end
					elseif plots[regional_neighbours[2]] == plots[plot_idx - 1] then
						if plots[plot_idx - cols - 1].type ~= plot.type then
							corners = corners + 1
							-- print("left top is not a regional neighbour")
						end
					end
				elseif plots[regional_neighbours[1]] == plots[plot_idx + cols] then
					if plots[regional_neighbours[2]] == plots[plot_idx + 1] then
						if plots[plot_idx + cols + 1].type ~= plot.type then
							corners = corners + 1
							-- print("right bottom is not a regional neighbour")
						end
					elseif plots[regional_neighbours[2]] == plots[plot_idx - 1] then
						if plots[plot_idx + cols - 1].type ~= plot.type then
							corners = corners + 1
							-- print("left bottom is not a regional neighbour")
						end
					end
				end
			end
		elseif regional_edges == 3 then
			corners = corners + 2
		elseif regional_edges == 4 then
			corners = corners + 4
		end
		-- end

		-- print("Region has " .. corners .. " corners")
		plot.corners = corners
		print("setting corners to " .. plot.corners)
	end

	for i = 1, num_regions do
		regions[i] = { area = 0, corners = 0 }
	end
	for _, plot in ipairs(plots) do
		regions[plot.region].area = regions[plot.region].area + 1
		regions[plot.region].corners = regions[plot.region].corners + plot.corners
	end

	local result = 0
	for _, region in ipairs(regions) do
		print("region has an area of " .. region.area .. " with " .. region.corners .. " corners")
		result = result + (region.area * region.corners)
	end

	return result
end

return day12
