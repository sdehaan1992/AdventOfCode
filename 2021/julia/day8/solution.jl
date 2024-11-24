example_input = "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce"

function count_digits_unique_segments()
    output_values = [strip(split(value, "|")[2]) for value in eachline("2021/day8/input")]
    count = 0

    for output_value in output_values, word in split(output_value, r"\W")
        if length(word) ∈ [2, 3, 4, 7]
            count += 1
        end
    end

    count
end

function screen_readout()
    test_values = [strip(split(value, "|")[1]) for value in eachline("2021/day8/input")]
    output_values = [strip(split(value, "|")[2]) for value in eachline("2021/day8/input")]
    count = 0

    for idx in eachindex(test_values)
        test_value = test_values[idx]
        mapping = Dict{String,Int}()
        words = split(test_value, r"\W")
        for unique_value in zip([1, 7, 4], [2, 3, 4])
            mapping[filter(len -> isequal(length(len), last(unique_value)), words)[1]] = first(unique_value)
        end

        one = missing
        for keyvalue in mapping
            if keyvalue.second == 1
                one = keyvalue.first
                break
            end
        end

        # Determine 9
        len_of_six = filter(len -> isequal(length(len), 6), words)
        comparison = join(keys(mapping))
        for idx in eachindex(len_of_six)
            possible_nine = len_of_six[idx]
            contains_all = true
            for character in comparison
                if character ∉ possible_nine
                    contains_all = false
                    break
                end
            end
            if contains_all
                idk = popat!(len_of_six, idx)
                mapping[idk] = 9
                break
            end
        end

        six = missing
        # Determine 6 & 0
        for idx in eachindex(len_of_six)
            possible_six = len_of_six[idx]
            is_six = false
            for character in one
                if character ∉ possible_six
                    is_six = true
                    break
                end
            end
            if is_six
                idk = popat!(len_of_six, idx)
                mapping[idk] = 6
                six = idk
                mapping[pop!(len_of_six)] = 0
                break
            end
        end

        # Determine 3
        len_of_five = filter(len -> isequal(length(len), 5), words)
        for idx in eachindex(len_of_five)
            possible_three = len_of_five[idx]
            is_three = false
            for character in one
                if character ∉ possible_three
                    is_three = true
                    break
                end
            end
            if !is_three
                idk = popat!(len_of_five, idx)
                mapping[idk] = 3
                break
            end
        end

        # Determine 5 & 2
        for idx in eachindex(len_of_five)
            possible_five = len_of_five[idx]
            is_five = true
            for character in possible_five
                if character ∉ six
                    is_five = false
                    break
                end
            end
            if !is_five
                idk = popat!(len_of_five, idx)
                mapping[idk] = 2
                mapping[pop!(len_of_five)] = 5
                break
            end
        end

        mapping[filter(len -> isequal(length(len), 7), words)[1]] = 8

        output = ""
        words = split(output_values[idx], r"\W")
        for word in words
            for (key, value) in mapping
                if isequal(length(key), length(word)) && issubset(key, word)
                    output *= string(value)
                end
            end
        end
        count += parse(Int, output)
    end

    count
end