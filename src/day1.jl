const NORTH = CartesianIndex(0, -1)
const SOUTH = CartesianIndex(0, 1)
const EAST = CartesianIndex(1, 0)
const WEST = CartesianIndex(-1, 0)

"""
Return the direction after doing a `turn` from the `currentdirection`.
"""
function getdirection(currentdirection::CartesianIndex{2}, turn::Char)
    if currentdirection == NORTH && turn == 'R'
        return EAST
    elseif currentdirection == NORTH && turn == 'L'
        return WEST
    elseif currentdirection == SOUTH && turn == 'R'
        return WEST
    elseif currentdirection == SOUTH && turn == 'L'
        return EAST
    elseif currentdirection == EAST && turn == 'R'
        return SOUTH
    elseif currentdirection == EAST && turn == 'L'
        return NORTH
    elseif currentdirection == WEST && turn == 'R'
        return NORTH
    elseif currentdirection == WEST && turn == 'L'
        return SOUTH
    end
end

function part1()
    input = open("input/day1.txt") do f
        return readline(f)
    end

    instructions = split(input, ", ")
    position = CartesianIndex(0, 0)
    direction = NORTH
    for instruction in instructions
        turn = instruction[1]
        steps = parse(Int, instruction[2:end])
        direction = getdirection(direction, turn)
        position += steps * direction
    end
    return abs(position[1]) + abs(position[2])
end

function part2()
    input = open("input/day1.txt") do f
        return readline(f)
    end

    instructions = split(input, ", ")
    position = CartesianIndex(0, 0)
    direction = NORTH
    visited = Set([position])
    for instruction in instructions
        turn = instruction[1]
        steps = parse(Int, instruction[2:end])
        direction = getdirection(direction, turn)
        for _ in 1:steps
            position += direction
            if position in visited
                return abs(position[1]) + abs(position[2])
            else
                push!(visited, position)
            end
        end
    end
end
