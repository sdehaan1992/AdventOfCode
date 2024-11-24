example_input = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"

using DelimitedFiles

mutable struct BingoData
    numbers::Vector{Int64}
    boards::Vector{Matrix{Int64}}

    BingoData(numbers) = new(numbers, [])
end

function parse_data()
    lines = split(String(read("2021/day4/input")), r"\n\n")
    data = BingoData(map(number -> parse(Int64, number), split(popfirst!(lines), ',')))
    for board in lines
        push!(data.boards, readdlm(IOBuffer(board), Int64))
    end

    data
end

function play_bingo_to_win()
    data = parse_data()

    for number in data.numbers
        for board in data.boards
            for idx in eachindex(board)
                if board[idx] == number
                    board[idx] = -1
                end
            end

            if find_potential_winner(board)
                return sum(filter(unmarked -> !isequal(unmarked, -1), board)) * number
            end
        end
    end
end

function play_bingo_to_lose()
    data = parse_data()
    discarded_boards = []

    for number in data.numbers
        for board_idx in eachindex(data.boards)
            if board_idx ∉ discarded_boards
                board = data.boards[board_idx]
                for idx in eachindex(board)
                    if board[idx] == number
                        board[idx] = -1
                    end
                end

                if find_potential_winner(board)
                    push!(discarded_boards, board_idx)
                    if length(discarded_boards) == length(data.boards)
                        return sum(filter(unmarked -> !isequal(unmarked, -1), board)) * number
                    end
                end
            end
        end
    end
end

function find_potential_winner(board)
    for column in 1:5:25
        if view(board, column:column+4) == [-1, -1, -1, -1, -1]
            return true
        end
    end

    for row in 1:5
        if view(board, row:5:25) == [-1, -1, -1, -1, -1]
            return true
        end
    end

    false
end