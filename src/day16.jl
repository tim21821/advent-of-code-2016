"""
Return the result of applying the modified dragon curve to `str` until it is at least
`diskspace` long.
"""
function dragoncurve(str::AbstractString, diskspace::Int)
    if length(str) >= diskspace
        return str
    end

    b = reverse(str)
    b = replace(b, '0' => '1', '1' => '0')
    return dragoncurve(str * '0' * b, diskspace)
end

"""
Return the checksum of `str`.
"""
function checksum(str::AbstractString)
    if length(str) % 2 == 1
        return str
    end

    buffer = IOBuffer(sizehint = length(str) ÷ 2)
    for i in 1:length(str)÷2
        print(buffer, str[2i-1] == str[2i] ? '1' : '0')
    end
    return checksum(String(take!(buffer)))
end

function part1()
    input = open("input/day16.txt") do f
        return readline(f)
    end

    extended = dragoncurve(input, 272)
    return checksum(extended[1:272])
end

function part2()
    input = open("input/day16.txt") do f
        return readline(f)
    end

    extended = dragoncurve(input, 35651584)
    return checksum(extended[1:35651584])
end
