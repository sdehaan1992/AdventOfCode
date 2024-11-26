local day5 = {}

local function parse(file, part)
	local stacks = {}
	local instructions = {}
	local local_file = io.open(file, "r")
	local num_stacks = 0
	local building = true
	for line in local_file:lines() do
		if building then
			if line == '' then
				building = false
			else
				if num_stacks == 0 then
					num_stacks = math.ceil(string.len(line) / 4)
				end

				for i = 1, string.len(line), 4 do
					local curr = string.sub(line, i, i + 3)
					local stack_num = math.ceil(i / 4)
					local value = string.match(curr, '%u')
					if value ~= nil then
						local stack = stacks[stack_num]
						if stack ~= nil then
							table.insert(stack, value)
						else
							stacks[stack_num] = { value }
						end
					end
				end
			end
		else
			local instruction = {}
			for value in string.gmatch(line, '%d+') do
				table.insert(instruction, value)
			end
			table.insert(instructions, instruction)
		end
	end

	if part == 1 then
		for _, instruction in pairs(instructions) do
			for i = 1, tonumber(instruction[1]) do
				local object = table.remove(stacks[tonumber(instruction[2])], 1)
				table.insert(stacks[tonumber(instruction[3])], 1, object)
			end
		end
	else
		for _, instruction in pairs(instructions) do
			for i = tonumber(instruction[1]), 1, -1 do
				local object = table.remove(stacks[tonumber(instruction[2])], i)
				table.insert(stacks[tonumber(instruction[3])], 1, object)
			end
		end
	end

	local result = ""
	for i = 1, #stacks do
		result = result .. stacks[i][1]
	end
	return result
end

day5.part1 = function(file)
	return parse(file, 1)
end

day5.part2 = function(file)
	return parse(file, 2)
end

return day5
