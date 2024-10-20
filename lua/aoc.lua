local day1 = require("days.day1")
local day2 = require("days.day2")
local benchmark = require("benchmark")

local function execute(day, part, f, ...)
	local r, d, u = benchmark.run(f, ...)
	print("Day, " .. day .. " Part, " .. part .. ":\n   Exectution time: " .. d .. " " .. u .. "\n   Result: " .. r)
end

-- execute(1, 1, day1.part1, "../input/day1.txt")
-- execute(1, 2, day1.part2, "../input/day1.txt")
execute(2, 1, day2.part1, "../input/day2.txt")
execute(2, 2, day2.part2, "../input/day2.txt")
