example_input = "target area: x=20..30, y=-10..-5"
input = "target area: x=85..145, y=-163..-108"

shoot_probe() = parse(Int, match(r"-\d+", input).match) * (parse(Int, match(r"-\d+", input).match) + 1) ÷ 2

function distinct_velocities()
    x_range = parse(Int, match(r"x=((\d+)\.+(\d+))", input)[2]):parse(Int, match(r"x=((\d+)\.+(\d+))", input)[3])
    y_range = parse(Int, match(r"y=((-\d+)\.+(-\d+))", input)[2]):parse(Int, match(r"y=((-\d+)\.+(-\d+))", input)[3])
    get_min_x() = begin
        x = 1
        while (x * (x + 1)) ÷ 2 < minimum(x_range)
            x += 1
        end
        x
    end


    velocities = [(x, y) for x in x_range for y in y_range]

    max_y_velocity = (minimum(y_range) + 1) * -1
    max_x_to_check = ceil(maximum(x_range) / 2)
    min_x_to_check = get_min_x()

    for x_start in min_x_to_check:max_x_to_check
        for y_start in max_y_velocity:-1:(minimum(y_range)*2+1)
            x_pos, y_pos = (0, 0)
            x = x_start
            y = y_start
            while x_pos <= maximum(x_range) && y_pos >= minimum(y_range)
                x_pos += x
                y_pos += y
                x = x == 0 ? x : x - 1
                y -= 1
                if x_pos ∈ x_range && y_pos ∈ y_range
                    push!(velocities, (x_start, y_start))
                end
            end
        end
    end

    length(unique(velocities))
end