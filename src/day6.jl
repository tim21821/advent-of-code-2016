using DataStructures

"""
Return the most common element in `acc`.
"""
mostcommon(acc::Accumulator) = sort(collect(acc); by = k -> k[2], rev = true)[1][1]

"""
Return the least common element in `acc`.
"""
leastcommon(acc::Accumulator) = sort(collect(acc); by = k -> k[2])[1][1]

function part1()
    lines = open("input/day6.txt") do f
        return readlines(f)
    end

    data = stack(collect.(lines); dims = 1)
    msg = ""
    for col in eachcol(data)
        msg *= mostcommon(counter(col))
    end
    return msg
end

function part2()
    lines = open("input/day6.txt") do f
        return readlines(f)
    end

    data = stack(collect.(lines); dims = 1)
    msg = ""
    for col in eachcol(data)
        msg *= leastcommon(counter(col))
    end
    return msg
end
