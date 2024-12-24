local day24 = {}

local function startswith(text, begin)
	if string.sub(text, 1, #begin) == begin then
		return true
	else
		return false
	end
end

day24.part1 = function(file)
	local input = io.open(file, 'r')
	local z_gates = {}
	local gates = {}
	local starting_lines = true
	for line in input:lines() do
		if starting_lines then
			if line == "" then
				starting_lines = false
			else
				local gate, value = string.match(line, '(.+):.(%d)')
				local f = function()
					return tonumber(value)
				end
				gates[gate] = f
			end
		else
			local gate1, op, gate2, gate3 = string.match(line, '(%g+)%s(%g+)%s(%g+)%s%->%s(%g+)')
			local f
			if op == "AND" then
				f = function()
					if gates[gate1] ~= nil and gates[gate2] ~= nil then
						return gates[gate1]() & gates[gate2]()
					end
					return nil
				end
			elseif op == "OR" then
				f = function()
					if gates[gate1] ~= nil and gates[gate2] ~= nil then
						return gates[gate1]() | gates[gate2]()
					end
					return nil
				end
			else
				f = function()
					if gates[gate1] ~= nil and gates[gate2] ~= nil then
						return gates[gate1]() ~ gates[gate2]()
					end
					return nil
				end
			end
			gates[gate3] = f

			if startswith(gate3, 'z') then
				z_gates[tonumber(string.sub(gate3, 2))] = f
			end
		end
	end
	local result = ""
	for i = #z_gates, 0, -1 do
		result = result .. z_gates[i]()
	end

	return tonumber(result, 2)
end

return day24
