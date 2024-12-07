local day7 = {}

local function can_make_target(target, parts, is_part_two)
	local result = false
	local function create_and_evaluate(curr_value, part_idx)
		if part_idx <= #parts and curr_value <= target then
			local new_part = part_idx + 1
			create_and_evaluate(curr_value + parts[part_idx], new_part)
			create_and_evaluate(curr_value * parts[part_idx], new_part)
			if is_part_two then
				create_and_evaluate(tonumber(curr_value .. "" .. parts[part_idx]), new_part)
			end
		end

		if curr_value == target and part_idx > #parts then
			result = true
		end
	end

	create_and_evaluate(parts[1], 2)
	return result
end

local function execute(file, is_part_two)
	local local_file = io.open(file, 'r')
	local result = 0
	for line in local_file:lines() do
		local sep_idx = string.find(line, ':', 1, true)
		local target = tonumber(string.sub(line, 1, sep_idx - 1))
		local parts = {}
		for part in string.gmatch(line, '%d+', sep_idx) do
			table.insert(parts, tonumber(part))
		end

		if can_make_target(target, parts, is_part_two) then
			result = result + target
		end
	end

	return result
end

day7.part1 = function(file)
	return execute(file)
end

day7.part2 = function(file)
	return execute(file, true)
end

return day7
