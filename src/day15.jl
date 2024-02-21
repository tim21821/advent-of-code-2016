const DISC_RE = r"^Disc #\d+ has (\d+) positions; at time=0, it is at position (\d+).$"

"""
Represent a Disc by the number of positions and its initial position.
"""
struct Disc
    numpositions::Int
    initialposition::Int
end

"""
Return a `Disc` constructed from `str` input.
"""
function fromstring(str::AbstractString)
    m = match(DISC_RE, str)
    numpositions = parse(Int, m[1])
    initialposition = parse(Int, m[2])
    return Disc(numpositions, initialposition)
end

"""
Return whether the `disc` will be passed at `time`.
"""
passdisc(disc::Disc, time::Int) = (disc.initialposition + time) % disc.numpositions == 0

"""
Return whether the `disc` will be passed when starting at `starttime` and the `disc` is at
`level`.
"""
passdisc(disc::Disc, starttime::Int, level::Int) = passdisc(disc, starttime + level)

function part1()
    lines = open("input/day15.txt") do f
        return readlines(f)
    end

    discs = fromstring.(lines)
    starttime = 0
    while !all(i -> passdisc(discs[i], starttime, i), eachindex(discs))
        starttime += 1
    end
    return starttime
end

function part2()
    lines = open("input/day15.txt") do f
        return readlines(f)
    end

    discs = fromstring.(lines)
    push!(discs, Disc(11, 0))
    starttime = 0
    while !all(i -> passdisc(discs[i], starttime, i), eachindex(discs))
        starttime += 1
    end
    return starttime
end
