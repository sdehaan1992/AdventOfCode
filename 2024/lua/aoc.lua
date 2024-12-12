local day1 = require("days.day1")
local day2 = require("days.day2")
local day3 = require("days.day3")
local day4 = require("days.day4")
local day5 = require("days.day5")
local day6 = require("days.day6")
local day7 = require("days.day7")
local day8 = require("days.day8")
local day9 = require("days.day9")
local day10 = require("days.day10")
local day11 = require("days.day11")
local day12 = require("days.day12")
local benchmark = require("benchmark")

local function execute(day, part, f, ...)
	local d, u, r1, r2 = benchmark.run(f, ...)

	if r2 ~= nil then
		print("Day, " .. day .. " Part, " .. part .. ":\n   Execution time: " .. d .. " " .. u .. "\n   Result: " .. r1)
		print("Day, " .. day .. " Part, " .. part + 1 ..
			":\n   Execution time: N/A \n   Result: " .. r2)
	else
		print("Day, " .. day .. " Part, " .. part .. ":\n   Execution time: " .. d .. " " .. u .. "\n   Result: " .. r1)
	end
end

-- execute(1, 1, day1.part1, "../input/day1.txt")
-- execute(1, 2, day1.part2, "../input/day1.txt")
-- execute(2, 1, day2.part1, "../input/day2.txt")
-- execute(2, 2, day2.part2, "../input/day2.txt")
-- execute(3, 1, day3.part1, "../input/day3.txt")
-- execute(3, 2, day3.part2, "../input/day3.txt")
-- execute(4, 1, day4.part1, "../input/day4.txt")
-- execute(4, 2, day4.part2, "../input/day4.txt")
-- execute(5, 1, day5.part1, "../input/day5.txt")
-- execute(5, 2, day5.part2, "../input/day5.txt")
-- execute(6, 1, day6.part1, "../input/day6.txt")
-- execute(6, 2, day6.part2, "../input/day6.txt")
-- execute(7, 1, day7.part1, "../input/day7.txt")
-- execute(7, 2, day7.part2, "../input/day7.txt")
-- execute(8, 1, day8.part1, "../input/day8.txt")
-- execute(8, 2, day8.part2, "../input/day8.txt")
-- execute(9, 1, day9.part1, "../input/day9.txt")
-- execute(9, 2, day9.part2, "../input/day9.txt")
-- execute(10, 1, day10.part1, "../input/day10.txt")
-- execute(11, 1, day11.part1, "../input/day11.txt")
-- execute(11, 2, day11.part2, "../input/day11.txt")
-- execute(12, 1, day12.part1, "../input/day12.txt")
execute(12, 2, day12.part2, "../input/day12-example.txt")
