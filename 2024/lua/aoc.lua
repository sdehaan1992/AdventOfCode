local day1 = require("days.day1")
local benchmark = require("benchmark")

local function execute(day, part, f, ...)
	local r, d, u = benchmark.run(f, ...)
	print("Day, " .. day .. " Part, " .. part .. ":\n   Exectution time: " .. d .. " " .. u .. "\n   Result: " .. r)
end

execute(1, 1, day1.part1, "../input/day1.txt")
execute(1, 2, day1.part2, "../input/day1.txt")
