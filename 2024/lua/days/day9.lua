local day9 = {}

day9.part1 = function(file)
	local input = io.open(file, 'r'):read('l')
	local result = 0
	local id = 0
	local disk_idx = 1
	local fragmented = {}
	local is_data = false
	local disk = {}
	local data = {}

	for char in string.gmatch(input, '.') do
		is_data = not is_data
		local value = tonumber(char)
		if is_data then
			for i = disk_idx, disk_idx + value - 1 do
				disk[i] = id
				table.insert(data, id)
			end
			disk_idx = disk_idx + value
			id = id + 1
		else
			for i = disk_idx, disk_idx + value - 1 do
				table.insert(fragmented, i)
			end
			disk_idx = disk_idx + value
		end
	end

	local total_data = #data
	while #fragmented ~= 0 do
		disk[table.remove(fragmented, 1)] = table.remove(data)
	end

	for i = 1, total_data do
		result = (i - 1) * disk[i] + result
	end

	return result
end

local function print_disk(files, fragmented)
	local disk = {}
	for i = 1, #files do
		for data = 1, files[i].size do
			table.insert(disk, files[i].file_id)
		end
		for empty = 1, fragmented[i] do
			table.insert(disk, ".")
		end
	end

	local str = ""
	for _, value in pairs(disk) do
		str = str .. value
	end
	return str
end

day9.part2 = function(file)
	local input = io.open(file, 'r'):read('l')
	local result = 0
	local fragmented = {}
	local is_data = false
	local disk = {}
	local fileid = 0

	for char in string.gmatch(input, '.') do
		is_data = not is_data
		local value = tonumber(char)
		if is_data then
			fileid = fileid + 1
			table.insert(disk, { file_id = fileid, size = value })
		else
			table.insert(disk, { size = value })
		end
	end

	-- local new_order = {}
	-- for _, copy in pairs(files) do
	-- 	table.insert(new_order, copy)
	-- end
	--
	-- print_disk(new_order, fragmented)
	-- local moves = 0
	-- for i = #files, 2, -1 do
	-- 	print("checking file_id: " .. files[i].file_id .. " of size " .. files[i].size)
	-- 	print("BEFORE")
	-- 	print_disk(new_order, fragmented)
	-- 	for j = 1, i - 1 do
	-- 		if files[i].size <= fragmented[j] then
	-- 			fragmented[j] = fragmented[j] - files[i].size
	-- 			fragmented[i] = fragmented[i - 1] + fragmented[i] + files[i].size
	-- 			local thing = table.remove(new_order, i + moves)
	-- 			table.insert(new_order, j + 1, thing)
	-- 			table.remove(fragmented, i - 1)
	-- 			table.insert(fragmented, j, 0)
	-- 			moves = moves + 1
	-- 			break
	-- 		end
	-- 	end
	-- 	print_disk(new_order, fragmented)
	-- 	print("AFTER")
	-- end
	--
	-- local disk = {}
	-- for i = 1, #files do
	-- 	for data = 1, new_order[i].size do
	-- 		table.insert(disk, new_order[i].file_id)
	-- 	end
	-- 	for empty = 1, fragmented[i] do
	-- 		table.insert(disk, 0)
	-- 	end
	-- end
	--
	-- for i = 1, #disk do
	-- 	result = result + disk[i] * (i - 1)
	-- end

	return result
end

return day9
