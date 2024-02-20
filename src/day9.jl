"""
Return the decompressed `str` while not decompressing inside already compressed substrings.
"""
function decompress(str::AbstractString)
    out = ""
    i = 1
    while i <= length(str)
        if str[i] == '('
            j = findfirst(c -> c == ')', str[i:end])
            j += i - 1
            len, multiplier = parse.(Int, split(str[i+1:j-1], 'x'))
            out *= repeat(str[j+1:j+len], multiplier)
            i = j + len + 1
        else
            out *= str[i]
            i += 1
        end
    end
    return out
end

"""
Return the length of the decompressed `str` while decompressing inside already compressed
substrings.
"""
function decompress2(str::AbstractString)
    weights = ones(Int, length(str))
    i = 1
    len = 0
    while i <= length(str)
        if str[i] == '('
            j = findfirst(c -> c == ')', str[i:end])
            j += i - 1
            l, multiplier = parse.(Int, split(str[i+1:j-1], 'x'))
            for k in j+1:j+l
                weights[k] *= multiplier
            end
            i = j + 1
        else
            len += weights[i]
            i += 1
        end
    end
    return len
end

function part1()
    input = open("input/day9.txt") do f
        return readline(f)
    end

    return length(decompress(input))
end

function part2()
    input = open("input/day9.txt") do f
        return readline(f)
    end

    return decompress2(input)
end
