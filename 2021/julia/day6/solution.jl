example_input = "3,4,3,1,2"

# Brute force Part 1
function fish_after_80_days()
    fishes = [fish for fish in parse.(Int, split(read("2021/day6/input", String), ","))]
    for day in 1:80
        map!(fish -> fish -= 1, fishes, fishes)
        append!(fishes, fill(8, count(fish -> isequal(fish, -1), fishes)))
        replace!(fishes, -1 => 6)
    end

    length(fishes)
end

# Be smarter for Part 2
function fish_after_256_days()
    num_of_new_fishes = fill(0, 9)
    starting_values = [fish for fish in parse.(Int, split(read("2021/day6/input", String), ","))]
    for idx in eachindex(num_of_new_fishes)
        num_of_new_fishes[idx] = count(value -> isequal(value + 1, idx), starting_values)
    end

    fishes = sum(num_of_new_fishes)

    for day in 1:256
        born = popfirst!(num_of_new_fishes)
        push!(num_of_new_fishes, born)
        num_of_new_fishes[7] += born
        fishes += born
    end

    fishes
end