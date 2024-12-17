local day17 = {}


day17.part1 = function(file)
	local input = io.open(file, 'r'):read('a')
	local instruction_set = {}
	local registers = { a = 0, b = 0, c = 0 }
	local pointer = 1
	local output = ""

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
	local combo_operands = { literal_0, literal_1, literal_2, literal_3, register_a, register_b, register_c, "" }

	local adv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.a = math.tointeger(registers.a // 2 ^ oper())
	end
	local bxl = function(operand)
		registers.b = registers.b ~ operand
	end
	local bst = function(operand)
		local oper = combo_operands[1 + operand]
		registers.b = oper() % 8
	end
	local jnz = function(operand)
		if registers.a ~= 0 then
			pointer = operand
		end
	end
	local bxc = function(operand)
		registers.b = registers.b ~ registers.c
	end
	local out = function(operand)
		local oper = combo_operands[1 + operand]
		output = output .. tostring(oper() % 8) .. ","
	end
	local bdv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.b = math.tointeger(registers.a // 2 ^ oper())
	end
	local cdv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.c = math.tointeger(registers.a // 2 ^ oper())
	end

	local instructions = { adv, bxl, bst, jnz, bxc, out, bdv, cdv }

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
		print(registers.a, registers.b, registers.c)
		instruction_set[pointer].opcode(instruction_set[pointer].operand)
		pointer = pointer + 1
	end

	print("a: " .. registers.a .. " b: " .. registers.b .. " c: " .. registers.c)
	return string.sub(output, 1, #output - 1)
end

day17.part2 = function(file)
	local input = io.open(file, 'r'):read('a')
	local instruction_set = {}
	local registers = { a = 0, b = 0, c = 0 }
	local pointer = 1
	local output = ""

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
	local combo_operands = { literal_0, literal_1, literal_2, literal_3, register_a, register_b, register_c, "" }

	local adv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.a = math.tointeger(registers.a // 2 ^ oper())
	end
	local bxl = function(operand)
		registers.b = registers.b ~ operand
	end
	local bst = function(operand)
		local oper = combo_operands[1 + operand]
		registers.b = oper() % 8
	end
	local jnz = function(operand)
		if registers.a ~= 0 then
			pointer = operand
		end
	end
	local bxc = function(operand)
		registers.b = registers.b ~ registers.c
	end
	local out = function(operand)
		local oper = combo_operands[1 + operand]
		output = output .. tostring(oper() % 8) .. ","
	end
	local bdv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.b = math.tointeger(registers.a // 2 ^ oper())
	end
	local cdv = function(operand)
		local oper = combo_operands[1 + operand]
		registers.c = math.tointeger(registers.a // 2 ^ oper())
	end

	local instructions = { adv, bxl, bst, jnz, bxc, out, bdv, cdv }

	local count = 0
	local original_instruction = ""
	for match in string.gmatch(input, "%d+") do
		count = count + 1
		if count == 1 then
			registers.a = tonumber(match)
		elseif count == 2 then
			registers.b = tonumber(match)
		elseif count == 3 then
			registers.c = tonumber(match)
		elseif count % 2 == 0 then
			original_instruction = original_instruction .. match .. ","
			table.insert(instruction_set, { opcode = instructions[tonumber(match) + 1] })
		else
			original_instruction = original_instruction .. match .. ","
			instruction_set[#instruction_set].operand = tonumber(match)
		end
	end
end



return day17
