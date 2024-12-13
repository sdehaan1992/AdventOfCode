local day13 = {}

local function execute(file, is_part_two)
	local local_file = io.open(file, 'r'):read('a')
	local nums = 0
	local result = 0
	local machines = {}
	for num in string.gmatch(local_file, "%d+") do
		nums = nums + 1
		if nums == 1 then
			table.insert(machines, { ax = tonumber(num) })
		else
			local machine = machines[#machines]
			if nums == 2 then
				machine.ay = tonumber(num)
			elseif nums == 3 then
				machine.bx = tonumber(num)
			elseif nums == 4 then
				machine.by = tonumber(num)
			elseif nums == 5 then
				if is_part_two then
					machine.px = tonumber(num) + 10000000000000
				else
					machine.px = tonumber(num)
				end
			else
				if is_part_two then
					machine.py = tonumber(num) + 10000000000000
				else
					machine.py = tonumber(num)
				end
			end
			nums = nums % 6
		end
	end

	for _, machine in pairs(machines) do
		local a = 0
		local b = ((machine.py * machine.ax) - (machine.px * machine.ay)) /
			((machine.by * machine.ax) - (machine.bx * machine.ay))
		if math.tointeger(b) then
			a = (machine.px - (machine.bx * b)) / machine.ax
			if math.tointeger(a) then
				if not is_part_two and a <= 100 and b <= 100 then
					result = result + (a * 3) + b
				else
					result = result + (a * 3) + b
				end
			end
		end
	end

	return math.tointeger(result)
end

day13.part1 = function(file)
	return execute(file, false)
end

day13.part2 = function(file)
	return execute(file, true)
end

return day13
