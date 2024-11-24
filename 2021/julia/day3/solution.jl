example_input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"

function power_consumption()
    data = [line for line in eachline("2021/day3/input")]
    gamma_rate = ""
    epsilon_rate = ""
    for idx in eachindex(data[1])
        zeros = 0
        ones = 0
        for sig_bit in data
            if sig_bit[idx] == '1'
                ones += 1
            else
                zeros += 1
            end
        end

        if zeros > ones
            gamma_rate *= "0"
            epsilon_rate *= "1"
        else
            gamma_rate *= "1"
            epsilon_rate *= "0"
        end
    end

    parse(Int, gamma_rate, base=2) * parse(Int, epsilon_rate, base=2)
end

power_consumption()

function life_support()
    data = [line for line in eachline("2021/day3/input")]
    copy_data = copy(data)

    # Oxygen
    for column in eachindex(copy_data[1])
        test = 0
        for row in length(copy_data):-1:1
            if copy_data[row][column] == '1'
                test += 1
            else
                test -= 1
            end
        end

        if length(copy_data) == 1
            break
        end
        if test < 0
            filter!(value -> isequal(value[column], '0'), copy_data)
        else
            filter!(value -> isequal(value[column], '1'), copy_data)
        end
    end

    oxygen = copy_data[1]

    # CO2
    for column in eachindex(data[1])
        test = 0
        for row in length(data):-1:1
            if data[row][column] == '1'
                test += 1
            else
                test -= 1
            end
        end

        if length(data) == 1
            break
        end
        if test < 0
            filter!(value -> isequal(value[column], '1'), data)
        else
            filter!(value -> isequal(value[column], '0'), data)
        end
    end

    co2 = data[1]

    parse(Int, oxygen, base=2) * parse(Int, co2, base=2)
end