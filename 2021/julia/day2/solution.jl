example_input = "forward 5
down 5
forward 8
up 3
down 8
forward 2"

mutable struct Position
    horizontal::Int
    depth::Int
    aim::Int
end

function calculate_new_position()
    pos = Position(0, 0, 0)
    for line in eachline("2021/day2/input")
        instructions = split(line)
        numeric = parse(Int, instructions[2])
        if instructions[1] == "forward"
            pos.horizontal += numeric
        elseif instructions[1] == "up"
            pos.depth -= numeric
        else
            pos.depth += numeric
        end
    end

    pos.depth * pos.horizontal
end

function calculate_new_position2()
    pos = Position(0, 0, 0)
    for line in eachline("2021/day2/input")
        instructions = split(line)
        numeric = parse(Int, instructions[2])
        if instructions[1] == "forward"
            pos.horizontal += numeric
            if pos.aim != 0
                pos.depth += (numeric * pos.aim)
            end
        elseif instructions[1] == "up"
            pos.aim -= numeric
        else
            pos.aim += numeric
        end
    end

    pos.depth * pos.horizontal
end