example_input = "2199943210
3987894921
9856789892
8767896789
9899965678"

get_potential_neighbours(position::CartesianIndex) = [CartesianIndex(position.I[1], position.I[2] + 1), CartesianIndex(position.I[1], position.I[2] - 1), CartesianIndex(position.I[1] + 1, position.I[2]), CartesianIndex(position.I[1] - 1, position.I[2])]

function get_lowest_points()::Tuple{Matrix{Int64}, Vector{CartesianIndex}}
    # lines = parse.(Int, permutedims(reshape([line for line in readeach(IOBuffer(example_input), Char) if line != '\n'], (10, 5))))
    lines = parse.(Int, permutedims(reshape([line for line in readeach(open("2021/day9/input"), Char) if line != '\n'], (100, 100))))

    lowest_points = Vector{CartesianIndex}()
    valid_indices = CartesianIndices(lines)

    for point_idx in valid_indices
        neighbours = filter!(index -> index ∈ valid_indices, get_potential_neighbours(point_idx))

        is_lowest_point = true
        for neighbour in neighbours
            if lines[neighbour] <= lines[point_idx]
                is_lowest_point = false
            end
        end

        if is_lowest_point
            push!(lowest_points, point_idx)
        end
    end

    lines, lowest_points
end

function risk_level()
    grid, lowest_points = get_lowest_points()
    sum(lowest_point -> grid[lowest_point] + 1, lowest_points)
end

function largest_basins()
    grid, lowest_points = get_lowest_points()
    basins = Vector{Set{CartesianIndex}}()

    valid_indices = CartesianIndices(grid)

    for lowest_point in lowest_points
        basin = Set{CartesianIndex}()
        push!(basins, basin)
        to_do_list = Set{CartesianIndex}()
        checked = Set{CartesianIndex}()
        push!(to_do_list, lowest_point)
        while !isempty(to_do_list)
            point = pop!(to_do_list)
            push!(basin, point)
            push!(checked, point)
            neighbours = filter!(index -> index ∈ valid_indices && index ∉ checked, get_potential_neighbours(point))

            for neighbour in neighbours
                if grid[neighbour] >= grid[point] && grid[neighbour] != 9
                    push!(to_do_list, neighbour)
                end
            end
        end
    end

    prod(reverse!(sort!(map(basin -> length(basin), basins)))[1:3])
end