example_input = "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"

function overlapping_lines(diagonal_allowed=false)
    vectorized_data = [data for data in eachline("2021/day5/input")]
    points = Dict{CartesianIndex,Int}()
    add_to_dict(column, row) = begin
        key = CartesianIndex(column, row)
        haskey(points, key) ? points[key] += 1 : points[key] = 1
    end

    for data in vectorized_data
        datapoints = parse.(Int, split(data, r"->|,"))
        if datapoints[1] == datapoints[3]
            for i in min(datapoints[2], datapoints[4]):max(datapoints[2], datapoints[4])
                add_to_dict(datapoints[1], i)
            end
        elseif datapoints[2] == datapoints[4]
            for i in min(datapoints[1], datapoints[3]):max(datapoints[1], datapoints[3])
                add_to_dict(i, datapoints[2])
            end
        elseif diagonal_allowed
            starting_column = datapoints[1]
            starting_row = datapoints[2]
            final_column = datapoints[3]
            final_row = datapoints[4]

            if datapoints[1] > datapoints[3] && datapoints[2] > datapoints[4]
                while starting_column >= final_column && starting_row >= final_row
                    add_to_dict(starting_column, starting_row)
                    starting_column -= 1
                    starting_row -= 1
                end

            elseif datapoints[1] > datapoints[3]
                while starting_column >= final_column && starting_row <= final_row
                    add_to_dict(starting_column, starting_row)
                    starting_column -= 1
                    starting_row += 1
                end

            elseif datapoints[2] > datapoints[4]
                while starting_column <= final_column && starting_row >= final_row
                    add_to_dict(starting_column, starting_row)
                    starting_column += 1
                    starting_row -= 1
                end

            else
                while starting_column <= final_column && starting_row <= final_row
                    add_to_dict(starting_column, starting_row)
                    starting_column += 1
                    starting_row += 1
                end
            end
        end
    end
    length(filter!(value -> value.second > 1, points))
end