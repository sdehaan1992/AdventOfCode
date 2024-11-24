example_input = "16,1,2,0,4,2,7,1,2,14"


# Brute Force Part 1
function align_horizontally()
    positions = [position for position in parse.(Int, split(read("2021/day7/input", String), ","))]
    closest = missing

    for pos in minimum(positions):maximum(positions)
        current = sum(value -> abs(pos - value), positions)
        if closest === missing || current < closest
            closest = current
        end
    end

    closest
end

# Brute Force Part 2
function align_horizontally2()
    positions = [position for position in parse.(Int, split(read("2021/day7/input", String), ","))]
    gauss_summation(difference) = (difference * (difference + 1)) ÷ 2
    closest = missing

    for pos in minimum(positions):maximum(positions)
        current = sum(value -> gauss_summation(abs(pos - value)), positions)
        if closest === missing || current < closest
            closest = current
        end
    end

    closest
end