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

local function print_disk(disk)
	local str = ""
	for _, value in ipairs(disk) do
		if value.file_id == 0 then
			str = str .. string.rep("0", value.size)
		else
			str = str .. string.rep(tostring(value.file_id), value.size)
		end
	end
	print(str)
end

day9.part2 = function(file)
	local input = io.open(file, 'r'):read('l')
	local result = 0
	local is_data = false
	local fileid = 0
	local disk = {}

	for char in string.gmatch(input, '.') do
		is_data = not is_data
		local value = tonumber(char)
		if is_data then
			table.insert(disk, { file_id = fileid, size = value })
			fileid = fileid + 1
		else
			table.insert(disk, { file_id = 0, size = value })
		end
	end

	local already_checked = {}
	local i = #disk
	while i >= 2 do
		if disk[i].file_id ~= 0 and already_checked[disk[i].file_id] == nil then
			local file_on_disk = disk[i]
			already_checked[file_on_disk.file_id] = {}
			for j = 2, i - 1 do
				if disk[j].file_id == 0 and disk[j].size >= file_on_disk.size then
					table.insert(disk, j, file_on_disk)
					disk[j + 1].size = disk[j + 1].size - file_on_disk.size
					disk[i + 1]      = {
						file_id = 0,
						size = file_on_disk.size,
					}
					i                = i + 1
					break
				end
			end
		end
		i = i - 1
	end

	local idx = 0
	for i = 1, #disk do
		for j = idx, idx + disk[i].size - 1 do
			result = result + j * disk[i].file_id
		end
		idx = idx + disk[i].size
	end

	return result
end

return day9
