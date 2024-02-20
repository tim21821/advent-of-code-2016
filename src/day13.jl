using DataStructures

const UP = CartesianIndex(0, -1)
const DOWN = CartesianIndex(0, 1)
const LEFT = CartesianIndex(-1, 0)
const RIGHT = CartesianIndex(1, 0)

"""
Return whether `position` is an open space depending on the `favoritenumber`.
"""
function isopenspace(position::CartesianIndex{2}, favoritenumber::Int)
    x, y = position[1], position[2]
    hashedpos = x * x + 3 * x + 2 * x * y + y + y * y + favoritenumber
    return count_ones(hashedpos) % 2 == 0
end

function part1()
    input = open("input/day13.txt") do f
        return readline(f)
    end

    favoritenumber = parse(Int, input)
    target = CartesianIndex(31, 39)
    visited = Set{CartesianIndex{2}}()
    queue = PriorityQueue{CartesianIndex{2},Int}()
    enqueue!(queue, CartesianIndex(1, 1) => 0)
    while !isempty(queue)
        pos, steps = dequeue_pair!(queue)
        if pos == target
            return steps
        end
        push!(visited, pos)

        posup = pos + UP
        if posup[2] >= 0 && isopenspace(posup, favoritenumber) && !(posup in visited)
            queue[posup] = steps + 1
        end

        posdown = pos + DOWN
        if isopenspace(posdown, favoritenumber) && !(posdown in visited)
            queue[posdown] = steps + 1
        end

        posleft = pos + LEFT
        if posleft[1] >= 0 && isopenspace(posleft, favoritenumber) && !(posleft in visited)
            queue[posleft] = steps + 1
        end

        posright = pos + RIGHT
        if isopenspace(posright, favoritenumber) && !(posright in visited)
            queue[posright] = steps + 1
        end
    end
end

function part2()
    input = open("input/day13.txt") do f
        return readline(f)
    end

    favoritenumber = parse(Int, input)
    visited = Set{CartesianIndex{2}}()
    currentpositions = Set([CartesianIndex(1, 1)])
    for _ in 1:50
        union!(visited, currentpositions)
        nextpositions = Set{CartesianIndex{2}}()
        for pos in currentpositions
            posup = pos + UP
            if posup[2] >= 0 && isopenspace(posup, favoritenumber)
                push!(nextpositions, posup)
            end

            posdown = pos + DOWN
            if isopenspace(posdown, favoritenumber)
                push!(nextpositions, posdown)
            end

            posleft = pos + LEFT
            if posleft[1] >= 0 && isopenspace(posleft, favoritenumber)
                push!(nextpositions, posleft)
            end

            posright = pos + RIGHT
            if isopenspace(posright, favoritenumber)
                push!(nextpositions, posright)
            end
        end
        currentpositions = nextpositions
    end
    return length(union(visited, currentpositions))
end
