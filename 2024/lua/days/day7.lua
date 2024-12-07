local day7 = {}

local function generate_combinations(numbers)
	local combinations = {}

	local function combine(nums, idx, current_expr)
		if idx == #nums then
			table.insert(combinations, current_expr)
			return
		end

		local next_num = nums[idx + 1]
		combine(nums, idx + 1, current_expr .. " + " .. next_num .. ")")
		combine(nums, idx + 1, current_expr .. " * " .. next_num .. ")")
	end

	combine(numbers, 1, string.rep('(', #numbers - 1) .. tostring(numbers[1]))

	return combinations
end

local function brute_force_part1(target, parts)
	local combinations = generate_combinations(parts)
	for _, entry in pairs(combinations) do
		local func = load("return " .. entry)
		if func() == target then
			return true
		end
	end
	return false
end

day7.part1 = function(file)
	local local_file = io.open(file, 'r')
	local result = 0
	for line in local_file:lines() do
		local sep_idx = string.find(line, ':', 1, true)
		local target = tonumber(string.sub(line, 1, sep_idx - 1))
		local parts = {}
		for part in string.gmatch(line, '%d+', sep_idx) do
			table.insert(parts, tonumber(part))
		end

		if brute_force_part1(target, parts) then
			result = result + target
		end
	end

	return result
end

day7.part2 = function(file)
end

return day7
