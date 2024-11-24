example_input = "1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581"

import Base: isless

mutable struct Node
    distance::Union{Float64,Int}
    risk::Int
    coordinate::CartesianIndex

    Node(distance, risk) = new(distance, risk, CartesianIndex(0, 0))
end

isless(x::Node, y::Node) = <(x.distance, y.distance)

function get_potential_neighbours(position::CartesianIndex, diagonals=false)
    if !diagonals
        [CartesianIndex(position.I[1], position.I[2] + 1), CartesianIndex(position.I[1], position.I[2] - 1), CartesianIndex(position.I[1] + 1, position.I[2]), CartesianIndex(position.I[1] - 1, position.I[2])]
    else
        [CartesianIndex(position.I[1], position.I[2] + 1), CartesianIndex(position.I[1], position.I[2] - 1), CartesianIndex(position.I[1] + 1, position.I[2]), CartesianIndex(position.I[1] - 1, position.I[2]),
            CartesianIndex(position.I[1] + 1, position.I[2] + 1), CartesianIndex(position.I[1] + 1, position.I[2] - 1), CartesianIndex(position.I[1] - 1, position.I[2] + 1), CartesianIndex(position.I[1] - 1, position.I[2] - 1)]
    end
end

function lowest_risk()
        # grid = permutedims(reshape([Node(Inf, parse(Int, line)) for line in readeach(IOBuffer(example_input), Char) if line != '\n'], (10, 10)))
        grid = permutedims(reshape([Node(Inf, parse(Int, line)) for line in readeach(open("2021/day15/input"), Char) if line != '\n'], (100, 100)))
        to_be_added_grid = copy(grid)

        for vertical in 1:4
            to_be_added_grid = map(node -> node.risk == 9 ? Node(Inf, 1) : Node(Inf, node.risk + 1), to_be_added_grid)
            grid = vcat(grid, to_be_added_grid)
        end

        to_be_added_grid = copy(grid)

        for horizontal in 1:4
            to_be_added_grid = map(node -> node.risk == 9 ? Node(Inf, 1) : Node(Inf, node.risk + 1), to_be_added_grid)
            grid = hcat(grid, to_be_added_grid)
        end

        for location in CartesianIndices(grid)
            grid[location].coordinate = location
        end

    mutalated_dijkstra(grid, grid[1, 1])

    grid[500, 500]

    # size(grid)
end

function mutalated_dijkstra(grid, source::Node)
    range = CartesianIndex(1, 1):CartesianIndex(size(grid))
    unvisited = Set(node for node in grid)
    seen_but_not_visited = Set([source])
    source.distance = 0

    while !isempty(seen_but_not_visited)
        current = pop!(seen_but_not_visited, sort([node for node in seen_but_not_visited])[1])
        delete!(unvisited, current)
        neighbours = filter(neighbour -> neighbour ∈ range && (grid[neighbour] ∈ unvisited || grid[neighbour] ∈ seen_but_not_visited), get_potential_neighbours(current.coordinate))
        for neighbour_idx in neighbours
            neighbour = grid[neighbour_idx]
            neighbour.distance = current.distance + neighbour.risk < neighbour.distance ? current.distance + neighbour.risk : neighbour.distance
            push!(seen_but_not_visited, neighbour)
        end
    end
end