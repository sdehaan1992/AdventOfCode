example_input = "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]"

using Statistics

function corrupted_score()
    lines = [line for line in readlines("2021/day10/input")]
    # lines = [line for line in readlines(IOBuffer(example_input))]
    score = 0
    add_score(to_add) = begin
        if to_add == ']'
            57
        elseif to_add == ')'
            3
        elseif to_add == '}'
            1197
        else
            25137
        end
    end

    for line in lines
        closing_expected = Vector{Char}()
        for character in line
            if character ∈ "{[<"
                push!(closing_expected, character + 2)
            elseif character == '('
                push!(closing_expected, ')')
            else
                if popat!(closing_expected, length(closing_expected)) != character
                    score += add_score(character)
                    break
                end
            end
        end
    end

    score
end

function autocomplete()
    lines = [line for line in readlines("2021/day10/input")]
    # lines = [line for line in readlines(IOBuffer(example_input))]
    scores = Vector{Int}()

    for line in lines
        closing_expected = Vector{Char}()
        is_corrupted = false
        for character in line
            if character ∈ "{[<"
                push!(closing_expected, character + 2)
            elseif character == '('
                push!(closing_expected, ')')
            else
                if popat!(closing_expected, length(closing_expected)) != character
                    is_corrupted = true
                    break
                end
            end
        end

        if !is_corrupted
            score = 0
            for character_idx in length(closing_expected):-1:1
                character = closing_expected[character_idx]
                score *= 5
                if character == ')'
                    score += 1
                elseif character == ']'
                    score += 2
                elseif character == '}'
                    score += 3
                else
                    score += 4
                end
            end

            push!(scores, score)
        end
    end

    median(sort!(scores))
end