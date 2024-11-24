example_input = "start-A
start-b
A-c
A-b
b-d
A-end
b-end"

struct Cave
    is_large::Bool
    name::String
    connections::Vector{String}
end

function find_paths()
    connectionList = [line for line in readlines("2021/day12/input")]
    # connectionList = [line for line in readlines(IOBuffer(example_input))]
    cave_system = Dict{String,Cave}()

    for connection in connectionList
        from, to = split(connection, "-")
        from_cave = haskey(cave_system, from) ? cave_system[from] : Cave(isequal(uppercase(from), from), from, [])
        to_cave = haskey(cave_system, to) ? cave_system[to] : Cave(isequal(uppercase(to), to), to, [])

        push!(from_cave.connections, to)
        push!(to_cave.connections, from)
        cave_system[from] = from_cave
        cave_system[to] = to_cave
    end

    paths_to_check = [["start"]]
    found_paths = Vector{Vector{String}}()

    while !isempty(paths_to_check)
        path = pop!(paths_to_check)
        for connection in cave_system[path[end]].connections
            cave = cave_system[connection]
            path_copy = copy(path)
            if isequal(connection, "end")
                push!(found_paths, push!(path_copy, connection))
            elseif (!cave.is_large && connection ∉ path) || cave.is_large
                push!(paths_to_check, push!(path_copy, connection))
            end
        end
    end

    length(found_paths)
end

function find_paths2()
    connectionList = [line for line in readlines("2021/day12/input")]
    # connectionList = [line for line in readlines(IOBuffer(example_input))]
    cave_system = Dict{String,Cave}()

    for connection in connectionList
        from, to = split(connection, "-")
        from_cave = haskey(cave_system, from) ? cave_system[from] : Cave(isequal(uppercase(from), from), from, [])
        to_cave = haskey(cave_system, to) ? cave_system[to] : Cave(isequal(uppercase(to), to), to, [])

        push!(from_cave.connections, to)
        push!(to_cave.connections, from)
        cave_system[from] = from_cave
        cave_system[to] = to_cave
    end

    paths_to_check = [["start"]]
    found_paths = Vector{Vector{String}}()

    while !isempty(paths_to_check)
        path = pop!(paths_to_check)

        revisited_small_cave = isequal(path[1], "hack") || count(cave -> isequal(lowercase(cave), cave), path) != length(unique(filter(cave -> isequal(lowercase(cave), cave), path)))
        if revisited_small_cave && !isequal(path[1], "hack")
            insert!(path, 1, "hack")
        end

        for connection in cave_system[path[end]].connections
            cave = cave_system[connection]
            path_copy = copy(path)
            if isequal(connection, "end")
                push!(found_paths, push!(path_copy, connection))
            elseif connection != "start" && (cave.is_large || !revisited_small_cave || (!cave.is_large && connection ∉ path))
                push!(paths_to_check, push!(path_copy, connection))
            end
        end
    end

    length(found_paths)
end

find_paths2()