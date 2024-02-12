const letters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
]

"""
Return the five most common letters in `str`, sorted alphabetically if tied.
"""
function getchecksum(str::AbstractString)
    counts = [(letter, count(i -> str[i] == letter, eachindex(str))) for letter in letters]
    sort!(counts; by = v -> v[2], rev = true)
    return counts[1][1] * counts[2][1] * counts[3][1] * counts[4][1] * counts[5][1]
end

"""
Return the sector id of `str` if `str` represents a valid room. Return `0` otherwise.
"""
function validroomid(str::AbstractString)
    encryptedname, sector_checksum = rsplit(str, '-'; limit = 2)
    name = join(split(encryptedname, '-'), "")
    sector, checksum = split(sector_checksum, '[')
    sectorid = parse(Int, sector)
    checksum = checksum[1:end-1]
    return getchecksum(name) == checksum ? sectorid : 0
end

"""
Return the sector id given in `str`.
"""
function getsectorid(str::AbstractString)
    _, sector_checksum = rsplit(str, '-'; limit = 2)
    sector, _ = split(sector_checksum, '[')
    return parse(Int, sector)
end

"""
Shift `c` by `shift`, wrapping from `'z'` to `'a'`.
"""
function shiftchar(c::Char, shift::Int)
    while Int(c) + shift >= Int('z')
        shift -= 26
    end
    return c + shift
end

"""
Return whether `str` contains the word `"north"` after shifting by the sector id.
"""
function storesnorth(str::AbstractString)
    sectorid = getsectorid(str)
    roomname, _ = rsplit(str, '-'; limit = 2)
    words = split(roomname, '-')
    characters = collect.(words)
    return any(c -> occursin("north", join(shiftchar.(c, sectorid))), characters)
end

function part1()
    lines = open("input/day4.txt") do f
        return readlines(f)
    end

    return sum(validroomid.(lines))
end

function part2()
    lines = open("input/day4.txt") do f
        return readlines(f)
    end

    for line in lines
        if storesnorth(line)
            return getsectorid(line)
        end
    end
end
