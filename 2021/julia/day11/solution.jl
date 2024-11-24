example_input = "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526"

function get_potential_neighbours(position::CartesianIndex, diagonals=false)
    if !diagonals
        [CartesianIndex(position.I[1], position.I[2] + 1), CartesianIndex(position.I[1], position.I[2] - 1), CartesianIndex(position.I[1] + 1, position.I[2]), CartesianIndex(position.I[1] - 1, position.I[2])]
    else
        [CartesianIndex(position.I[1], position.I[2] + 1), CartesianIndex(position.I[1], position.I[2] - 1), CartesianIndex(position.I[1] + 1, position.I[2]), CartesianIndex(position.I[1] - 1, position.I[2]),
            CartesianIndex(position.I[1] + 1, position.I[2] + 1), CartesianIndex(position.I[1] + 1, position.I[2] - 1), CartesianIndex(position.I[1] - 1, position.I[2] + 1), CartesianIndex(position.I[1] - 1, position.I[2] - 1)]
    end
end

function flashes_after_100_steps()
    # lines = parse.(Int, permutedims(reshape([line for line in readeach(IOBuffer(example_input), Char) if line != '\n'], (10, 10))))
    lines = parse.(Int, permutedims(reshape([line for line in readeach(open("2021/day11/input"), Char) if line != '\n'], (10, 10))))
    valid_indices = reshape([index for index in CartesianIndices(lines)], length(lines))
    count_flashes = 0

    for step in 1:100
        neighbours_of_flashing_octopusses = copy(valid_indices)
        while !isempty(neighbours_of_flashing_octopusses)
            octopus_location = pop!(neighbours_of_flashing_octopusses)
            if lines[octopus_location] != -1
                lines[octopus_location] += 1
            end
            if lines[octopus_location] > 9
                count_flashes += 1
                for neighbour in filter!(value -> value ∈ valid_indices && lines[value] > -1, get_potential_neighbours(octopus_location, true))
                    push!(neighbours_of_flashing_octopusses, neighbour)
                end
                lines[octopus_location] = -1
            end
        end
        for flashed_octupus in eachindex(lines)
            if lines[flashed_octupus] < 0
                lines[flashed_octupus] = 0
            end
        end
    end

    count_flashes
end

function synchronized_flashes()
    # lines = parse.(Int, permutedims(reshape([line for line in readeach(IOBuffer(example_input), Char) if line != '\n'], (10, 10))))
    lines = parse.(Int, permutedims(reshape([line for line in readeach(open("2021/day11/input"), Char) if line != '\n'], (10, 10))))
    valid_indices = reshape([index for index in CartesianIndices(lines)], length(lines))
    count_flashes = 0
    step = 0

    while true
        step += 1
        flashes_at_start = count_flashes
        neighbours_of_flashing_octopusses = copy(valid_indices)
        while !isempty(neighbours_of_flashing_octopusses)
            octopus_location = pop!(neighbours_of_flashing_octopusses)
            if lines[octopus_location] != -1
                lines[octopus_location] += 1
            end
            if lines[octopus_location] > 9
                count_flashes += 1
                for neighbour in filter!(value -> value ∈ valid_indices && lines[value] > -1, get_potential_neighbours(octopus_location, true))
                    push!(neighbours_of_flashing_octopusses, neighbour)
                end
                lines[octopus_location] = -1
            end
        end
        for flashed_octupus in eachindex(lines)
            if lines[flashed_octupus] < 0
                lines[flashed_octupus] = 0
            end
        end

        if count_flashes - flashes_at_start == length(lines)
            return step
        end
    end
end