example_input = "199
200
208
210
200
207
240
269
260
263"

function get_answer()
    increased_depth = -1
    previous_line = -1
    for line in eachline("2021/day1/input")
        if parse(Int, line) > previous_line
            increased_depth += 1
        end
        previous_line = parse(Int, line)
    end

    increased_depth
end

function get_answer2()
    depths = [parse(Int, depth) for depth in eachline("2021/day1/input")]
    increased_depth = 0
    for idx in 3:length(depths)-1
        if sum(depths[idx-2:idx]) < sum(depths[idx-1:idx+1])
            increased_depth += 1
        end
    end

    increased_depth
end