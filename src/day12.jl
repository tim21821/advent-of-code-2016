"""
Return whether `str` contains only digits.
"""
isnumber(str::AbstractString) = all(isdigit, str)

function part1()
    lines = open("input/day12.txt") do f
        readlines(f)
    end

    registers = Dict('a' => 0, 'b' => 0, 'c' => 0, 'd' => 0)
    i = 1
    while i <= length(lines)
        line = lines[i]
        if startswith(line, "cpy")
            _, source_str, destination_str = split(line)
            source = isnumber(source_str) ? parse(Int, source_str) : registers[only(source_str)]
            destination = only(destination_str)
            registers[destination] = source
            i += 1
        elseif startswith(line, "inc")
            register = line[end]
            registers[register] += 1
            i += 1
        elseif startswith(line, "dec")
            register = line[end]
            registers[register] -= 1
            i += 1
        elseif startswith(line, "jnz")
            _, val_str, jmp_str = split(line)
            jump = parse(Int, jmp_str)
            value = isnumber(val_str) ? parse(Int, val_str) : registers[only(val_str)]
            if value != 0
                i += jump
            else
                i += 1
            end
        end
    end
    return registers['a']
end

function part2()
    lines = open("input/day12.txt") do f
        readlines(f)
    end

    registers = Dict('a' => 0, 'b' => 0, 'c' => 1, 'd' => 0)
    i = 1
    while i <= length(lines)
        line = lines[i]
        if startswith(line, "cpy")
            _, source_str, destination_str = split(line)
            source = isnumber(source_str) ? parse(Int, source_str) : registers[only(source_str)]
            destination = only(destination_str)
            registers[destination] = source
            i += 1
        elseif startswith(line, "inc")
            register = line[end]
            registers[register] += 1
            i += 1
        elseif startswith(line, "dec")
            register = line[end]
            registers[register] -= 1
            i += 1
        elseif startswith(line, "jnz")
            _, val_str, jmp_str = split(line)
            jump = parse(Int, jmp_str)
            value = isnumber(val_str) ? parse(Int, val_str) : registers[only(val_str)]
            if value != 0
                i += jump
            else
                i += 1
            end
        end
    end
    return registers['a']
end