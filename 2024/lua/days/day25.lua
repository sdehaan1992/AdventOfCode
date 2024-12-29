local day25 = {}

local function create_lock(object)
	local heights = { 0, 0, 0, 0, 0 }
	local indices = { 7, 8, 9, 10, 11 }
	for i = 1, 5 do
		for idx, index in ipairs(indices) do
			if index ~= 0 then
				if string.sub(object, index, index) == '#' then
					heights[idx] = heights[idx] + 1
					indices[idx] = indices[idx] + 6
				else
					index = 0
				end
			end
		end
	end
	return heights
end

local function create_keys(object)
	local heights = { 0, 0, 0, 0, 0 }
	local indices = { 31, 32, 33, 34, 35 }
	for i = 1, 5 do
		for idx, index in ipairs(indices) do
			if index ~= 0 then
				if string.sub(object, index, index) == '#' then
					heights[idx] = heights[idx] + 1
					indices[idx] = indices[idx] - 6
				else
					index = 0
				end
			end
		end
	end
	return heights
end

day25.part1 = function(file)
	local input = io.open(file, 'r'):read('a') .. '\n'
	local locks = {}
	local keys = {}

	for object in string.gmatch(input, '.-\n\n') do
		if string.sub(object, 1, 5) == '#####' then
			table.insert(locks, create_lock(object))
		else
			table.insert(keys, create_keys(object))
		end
	end

	local result = 0
	for _, key in ipairs(keys) do
		for _, lock in ipairs(locks) do
			local overlap = false
			for loc, height in ipairs(key) do
				if height + lock[loc] > 5 then
					overlap = true
				end
			end
			if not overlap then
				result = result + 1
			end
		end
	end

	return result
end

return day25
