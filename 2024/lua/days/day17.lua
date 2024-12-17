local day17 = {}

local registers = { a = 0, b = 0, c = 0 }

local function get_combo_operands()
	local literal_0 = function()
		return 0
	end
	local literal_1 = function()
		return 1
	end
	local literal_2 = function()
		return 2
	end
	local literal_3 = function()
		return 3
	end
	local register_a = function()
		return registers.a
	end
	local register_b = function()
		return registers.b
	end
	local register_c = function()
		return registers.c
	end
	return { literal_0, literal_1, literal_2, literal_3, register_a, register_b, register_c, "" }
end

local function get_instructions()
	local pointer = 1
	local combo_operands = get_combo_operands()
	local adv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.a = math.tointeger(registers.a // 2 ^ oper())
		pointer = pointer + 1
		return pointer
	end
	local bxl = function(operand)
		registers.b = registers.b ~ operand
		pointer = pointer + 1
		return pointer
	end
	local bst = function(operand)
		local oper = combo_operands[1 + operand]
		registers.b = oper() % 8
		pointer = pointer + 1
		return pointer
	end
	local jnz = function(operand)
		if registers.a ~= 0 then
			pointer = operand + 1
			return pointer
		end
		return pointer + 1
	end
	local bxc = function(operand)
		registers.b = registers.b ~ registers.c
		pointer = pointer + 1
		return pointer
	end
	local out = function(operand)
		local oper = combo_operands[1 + operand]
		pointer = pointer + 1
		return pointer, tostring(oper() % 8)
	end
	local bdv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.b = math.tointeger(registers.a // 2 ^ oper())
		pointer = pointer + 1
		return pointer
	end
	local cdv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.c = math.tointeger(registers.a // 2 ^ oper())
		pointer = pointer + 1
		return pointer
	end

	return { adv, bxl, bst, jnz, bxc, out, bdv, cdv }, pointer
end

day17.part1 = function(file)
	local input = io.open(file, 'r'):read('a')
	local instruction_set = {}
	local output = ""
	local instructions, pointer = get_instructions()

	local count = 0
	for match in string.gmatch(input, "%d+") do
		count = count + 1
		if count == 1 then
			registers.a = tonumber(match)
		elseif count == 2 then
			registers.b = tonumber(match)
		elseif count == 3 then
			registers.c = tonumber(match)
		elseif count % 2 == 0 then
			table.insert(instruction_set, { opcode = instructions[tonumber(match) + 1] })
		else
			instruction_set[#instruction_set].operand = tonumber(match)
		end
	end

	while pointer <= #instruction_set do
		local result = nil
		pointer, result = instruction_set[pointer].opcode(instruction_set[pointer].operand)
		if result then
			output = output .. result .. ","
		end
	end

	return string.sub(output, 1, #output - 1)
end

day17.part2 = function(file)
	local input = io.open(file, 'r'):read('a')
	local instruction_set = {}
	local instructions, _ = get_instructions()

	local original_instructions = {}
	local count = 0
	for match in string.gmatch(input, "%d+") do
		count = count + 1
		if count == 1 then
			registers.a = tonumber(match)
		elseif count == 2 then
			registers.b = tonumber(match)
		elseif count == 3 then
			registers.c = tonumber(match)
		elseif count % 2 == 0 then
			table.insert(original_instructions, match)
			table.insert(instruction_set, { opcode = instructions[tonumber(match) + 1] })
		else
			table.insert(original_instructions, match)
			instruction_set[#instruction_set].operand = tonumber(match)
		end
	end

	local previous_a = function(a)
		local list = {}
		for _, value in ipairs(a) do
			for i = value * 8, (value + 1) * 8 - 1 do
				table.insert(list, i)
			end
		end
		return list
	end

	local single_run = function(possible_a, expected_output)
		local correct = {}
		for _, a in ipairs(possible_a) do
			local output = ""
			registers.a = a
			for i = 1, #instruction_set - 1 do
				_, output = instruction_set[i].opcode(instruction_set[i].operand)
			end
			if output == expected_output then
				table.insert(correct, a)
			end
		end

		return correct
	end

	local possible_as = previous_a({ 0 })
	while #original_instructions ~= 0 do
		possible_as = single_run(previous_a(possible_as), table.remove(original_instructions))
	end

	return possible_as[1]
end

return day17
