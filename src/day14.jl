using MD5
using Memoization

"""
Return the MD5 hash of `salt` after appending `postfix`.
"""
@memoize hash(salt::AbstractString, postfix::Int) = bytes2hex(md5(salt * string(postfix)))

"""
Return the result of MD5 hashing `str` 2017 times.
"""
@memoize function stretchedhash(str::AbstractString)
    for _ in 1:2017
        str = bytes2hex(md5(str))
    end
    return str
end

@memoize stretchedhash(salt::AbstractString, postfix::Int) =
    stretchedhash(salt * string(postfix))

"""
Return the character that makes up the first triplet in `str`. Return `'x'` if there are no
triplets.
"""
function findfirsttriplet(str::AbstractString)
    for i in 1:length(str)-2
        if str[i] == str[i+1] == str[i+2]
            return str[i]
        end
    end
    return 'x'
end

"""
Return whether `str` contains any sequence of `needle` five times in a row.
"""
containsfiverow(str::AbstractString, needle::Char) = any(
    i -> str[i] == str[i+1] == str[i+2] == str[i+3] == str[i+4] == needle,
    1:length(str)-4,
)

"""
Return whether `salt * string(postfix)` is a key for part 1.
"""
function iskey1(salt::AbstractString, postfix::Int)
    hashed = hash(salt, postfix)
    triplet = findfirsttriplet(hashed)
    return triplet != 'x' && any(
        str -> containsfiverow(str, triplet),
        [hash(salt, postfix + i) for i in 1:1000],
    )
end

"""
Return whether `salt * string(postfix)` is a key for part 2.
"""
function iskey2(salt::AbstractString, postfix::Int)
    hashed = stretchedhash(salt, postfix)
    triplet = findfirsttriplet(hashed)
    return triplet != 'x' && any(
        str -> containsfiverow(str, triplet),
        [stretchedhash(salt, postfix + i) for i in 1:1000],
    )
end

function part1()
    input = open("input/day14.txt") do f
        return readline(f)
    end

    index = 0
    keycount = 0
    while keycount < 64
        if iskey1(input, index)
            keycount += 1
        end
        index += 1
    end
    return index - 1
end

function part2()
    input = open("input/day14.txt") do f
        return readline(f)
    end

    index = 0
    keycount = 0
    while keycount < 64
        if iskey2(input, index)
            keycount += 1
        end
        index += 1
    end
    return index - 1
end
