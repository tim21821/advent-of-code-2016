using DataStructures
using MD5

const TARGET = CartesianIndex(4, 4)
const UP = CartesianIndex(0, -1)
const DOWN = CartesianIndex(0, 1)
const LEFT = CartesianIndex(-1, 0)
const RIGHT = CartesianIndex(1, 0)

"""
Return whether a door represented by `c` is open.
"""
isdooropen(c::Char) = c in ('b', 'c', 'd', 'e', 'f')

function part1()
    input = open("input/day17.txt") do f
        return readline(f)
    end

    queue = PriorityQueue{Tuple{CartesianIndex{2},String},Int}()
    enqueue!(queue, (CartesianIndex(1, 1), input) => 0)
    while !isempty(queue)
        (position, path), steps = dequeue_pair!(queue)
        if position == TARGET
            return path[length(input)+1:end]
        end
        h = bytes2hex(md5(path))

        if isdooropen(h[1]) && position[2] > 1
            queue[(position + UP, path * 'U')] = steps + 1
        end
        if isdooropen(h[2]) && position[2] < 4
            queue[(position + DOWN, path * 'D')] = steps + 1
        end
        if isdooropen(h[3]) && position[1] > 1
            queue[(position + LEFT, path * 'L')] = steps + 1
        end
        if isdooropen(h[4]) && position[1] < 4
            queue[(position + RIGHT, path * 'R')] = steps + 1
        end
    end
end

function part2()
    input = open("input/day17.txt") do f
        return readline(f)
    end

    queue = PriorityQueue{Tuple{CartesianIndex{2},String},Int}()
    enqueue!(queue, (CartesianIndex(1, 1), input) => 0)
    stepstogoal = 0
    while !isempty(queue)
        (position, path), steps = dequeue_pair!(queue)
        if position == TARGET
            stepstogoal = steps
            continue
        end
        h = bytes2hex(md5(path))

        if isdooropen(h[1]) && position[2] > 1
            queue[(position + UP, path * 'U')] = steps + 1
        end
        if isdooropen(h[2]) && position[2] < 4
            queue[(position + DOWN, path * 'D')] = steps + 1
        end
        if isdooropen(h[3]) && position[1] > 1
            queue[(position + LEFT, path * 'L')] = steps + 1
        end
        if isdooropen(h[4]) && position[1] < 4
            queue[(position + RIGHT, path * 'R')] = steps + 1
        end
    end
    return stepstogoal
end
