example_input = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

function find_polymer_formula()
    lines = [line for line in readlines("2021/day14/input")]
    # lines = [line for line in readlines(IOBuffer(example_input))]
    polymer_template = lines[1]
    instruction_set = Dict{String,Tuple{String,String}}()

    for line in lines[3:end]
        pairing, insertion = map(value -> strip(value), split(line, "->"))
        instruction_set[pairing] = (pairing[1] * insertion, insertion * pairing[2])
    end

    pair_counter = Dict(pair => 0 for pair in keys(instruction_set))
    element_counter = Dict{Char,Int64}()

    for key in keys(pair_counter), character in key
        element_counter[character] = 0
    end

    foreach(char -> element_counter[char] += 1, polymer_template)

    for idx in 1:length(polymer_template)-1
        pair_counter[polymer_template[idx]*polymer_template[idx+1]] += 1
    end

    for step in 1:40
        updated_pair_counter = copy(pair_counter)
        for pair in pair_counter
            if pair[2] > 0
                to_be_added_pairs = instruction_set[pair[1]]
                updated_pair_counter[to_be_added_pairs[1]] += pair[2]
                updated_pair_counter[to_be_added_pairs[2]] += pair[2]
                updated_pair_counter[pair[1]] -= pair[2]

                element_counter[to_be_added_pairs[1][2]] += pair[2]
            end
        end

        pair_counter = updated_pair_counter
    end

    maximum(values(element_counter)) - minimum(values(element_counter))
end