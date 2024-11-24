example_input = "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"

# dot[1] == column
# dot[2] == row

function folding()
    dots_and_instructions = [line for line in readlines("2021/day13/input")]
    # dots_and_instructions = [line for line in readlines(IOBuffer(example_input))]
    split_at = findnext(line -> isempty(line), dots_and_instructions, 1)
    dots = map(dot -> CartesianIndex(parse(Int, split(dot, ",")[1]) + 1, parse(Int, split(dot, ",")[2]) + 1), dots_and_instructions[1:split_at-1])
    instructions = dots_and_instructions[split_at+1:end]
    dimensions = maximum(dots)

    part_1_flag = true

    for instruction in instructions
        axis, value = split(instruction, "=")
        fold_value = parse(Int, value) + 1
        if endswith(axis, "y")
            folded_rows = dimensions[2] - fold_value
            for row_num in dimensions[2]:-1:(dimensions[2]-folded_rows)
                to_be_folded_dots = splice!(dots, findall(dot -> dot[2] == row_num, dots))
                for dot in to_be_folded_dots
                    push!(dots, CartesianIndex(dot[1], fold_value - (dot[2] - fold_value)))
                end
            end

            dimensions = CartesianIndex(dimensions[1], dimensions[2] - fold_value)
        else
            folded_columns = dimensions[1] - fold_value
            for column_num in dimensions[1]:-1:(dimensions[1]-folded_columns)
                to_be_folded_dots = splice!(dots, findall(dot -> dot[1] == column_num, dots))
                for dot in to_be_folded_dots
                    push!(dots, CartesianIndex(fold_value - (dot[1] - fold_value), dot[2]))
                end
            end

            dimensions = CartesianIndex(dimensions[1] - fold_value, dimensions[2])
        end

        unique!(dots)
        if part_1_flag
            @info "Answer Part 1: $(length(dots))"
            part_1_flag = false
        end
    end

    grid = fill('.', (dimensions[2], dimensions[1]))
    for dot in dots
        grid[CartesianIndex(dot[2], dot[1])] = '#'
    end

    display(grid)
end