using MD5

"""
Return whether `str` starts with five zeros.
"""
hasfiveleadingzeros(str::AbstractString) =
    str[1] == '0' && str[2] == '0' && str[3] == '0' && str[4] == '0' && str[5] == '0'

function part1()
    input = open("input/day5.txt") do f
        return readline(f)
    end

    i = 0
    password = ""
    while length(password) < 8
        hash = bytes2hex(md5(input * string(i)))
        if hasfiveleadingzeros(hash)
            password *= hash[6]
        end
        i += 1
    end
    return password
end

function part2()
    input = open("input/day5.txt") do f
        return readline(f)
    end

    i = 0
    password = fill('A', 8)
    while any(c -> c == 'A', password)
        hash = bytes2hex(md5(input * string(i)))
        if hasfiveleadingzeros(hash)
            if isdigit(hash[6])
                pos = parse(Int, hash[6]) + 1
                if checkbounds(Bool, password, pos) && password[pos] == 'A'
                    password[pos] = hash[7]
                end
            end
        end
        i += 1
    end
    return join(password)
end
