function decode()
    transmission = IOBuffer(parse_transmission(read(open("2021/day16/input"), String)))
    version = 0

    while !eof(transmission) && transmission.size - transmission.ptr > 10
        version += read_decimal_from_stream(transmission, 3)
        packet_type_id = read_decimal_from_stream(transmission, 3)

        if packet_type_id == 4
            while true
                end_marker = read_decimal_from_stream(transmission, 1)
                skip(transmission, 4)
                if end_marker == 0
                    break
                end
            end
        else
            length_type_id = read_decimal_from_stream(transmission, 1)
            if length_type_id == 0
                skip(transmission, 15)
            else
                skip(transmission, 11)
            end
        end
    end

    version
end

function read_transmission()
    transmission = IOBuffer(parse_transmission(read(open("2021/day16/input"), String)))
    # transmission = IOBuffer(parse_transmission(example_input_2))
    decode_complete(transmission)
end

function decode_complete(transmission::IOBuffer, subpackets=[], num_of_packets=Inf)::Int64
    packet_value = 0
    
    while !eof(transmission) && transmission.size - transmission.ptr >= 10 && length(subpackets) < num_of_packets
        skip(transmission, 3)
        packet_type_id = read_decimal_from_stream(transmission, 3)
        packet_value = 0

        if packet_type_id == 4
            bit_group = ""
            while true
                end_marker = read_decimal_from_stream(transmission, 1)
                bit_group *= read_binary_string_from_stream(transmission, 4)
                if end_marker == 0
                    break
                end
            end

            packet_value += parse(Int, bit_group, base=2)

        else
            length_type_id = read_decimal_from_stream(transmission, 1)
            inner_packets = Vector{Int64}()
            if length_type_id == 0
                sub_packets_length = read_decimal_from_stream(transmission, 15)
                decode_complete(IOBuffer(String(read(transmission, sub_packets_length))), inner_packets)
            else
                num_of_subpackets = read_decimal_from_stream(transmission, 11)
                decode_complete(transmission, inner_packets, num_of_subpackets)
            end

            if packet_type_id == 0
                packet_value += sum(inner_packets)
            elseif packet_type_id == 1
                packet_value += prod(inner_packets)
            elseif packet_type_id == 2
                packet_value = minimum(inner_packets)
            elseif packet_type_id == 3
                packet_value = maximum(inner_packets)
            elseif packet_type_id == 5
                packet_value = inner_packets[1] > inner_packets[2] ? 1 : 0
            elseif packet_type_id == 6
                packet_value = inner_packets[1] < inner_packets[2] ? 1 : 0
            elseif packet_type_id == 7
                packet_value = inner_packets[1] == inner_packets[2] ? 1 : 0
            end
        end

        push!(subpackets, packet_value)
    end

    packet_value
end

function parse_transmission(transmission::String)
    buffer = IOBuffer(transmission)
    binary_vector = Vector{Vector{Int}}()
    while !eof(buffer)
        push!(binary_vector, reverse(digits(parse(Int, String(read(buffer, 1)), base=16), base=2, pad=4)))
    end

    join(join.(binary_vector))
end

read_decimal_from_stream(io::IO, nb::Int) = parse(Int, join(map(number -> number - 48, read(io, nb))), base=2)
read_binary_string_from_stream(io::IO, nb::Int) = join(map(number -> number - 48, read(io, nb)))