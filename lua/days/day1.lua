local day1 = {}

day1.part1 = function(file)
	local local_file = io.open(file, "r")
	local most_calories = 0
	local current_elf = 0

	for pack in local_file:lines() do
		if pack ~= '' then
			current_elf = current_elf + tonumber(pack)
		else
			if current_elf > most_calories then
				most_calories = current_elf
			end
			current_elf = 0
		end
	end
	local_file:close()
	return most_calories
end

day1.part2 = function(file)
	local local_file = io.open(file, "r")
	local elfs = {}
	local current_elf = 0

	for pack in local_file:lines() do
		if pack ~= '' then
			current_elf = current_elf + tonumber(pack)
		else
			table.insert(elfs, current_elf)
			current_elf = 0
		end
	end
	local_file:close()
	table.sort(elfs)
	return elfs[#elfs] + elfs[#elfs - 1] + elfs[#elfs - 2]
end

return day1
