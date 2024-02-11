const MOVEMENTS = Dict(
    'U' => CartesianIndex(-1, 0),
    'D' => CartesianIndex(1, 0),
    'L' => CartesianIndex(0, -1),
    'R' => CartesianIndex(0, 1),
)
const keypad1 = [1 2 3; 4 5 6; 7 8 9]

const keypad2 = [0 0 1 0 0; 0 2 3 4 0; 5 6 7 8 9; 0 'A' 'B' 'C' 0; 0 0 'D' 0 0]

function part1()
    lines = open("input/day2.txt") do f
        return readlines(f)
    end

    position = CartesianIndex(2, 2)
    ans = ""
    for line in lines
        for c in line
            movement = MOVEMENTS[c]
            if checkbounds(Bool, keypad1, position + movement)
                position += movement
            end
        end
        ans *= string(keypad1[position])
    end
    return ans
end

function part2()
    lines = open("input/day2.txt") do f
        return readlines(f)
    end

    position = CartesianIndex(3, 1)
    ans = ""
    for line in lines
        for c in line
            movement = MOVEMENTS[c]
            if checkbounds(Bool, keypad2, position + movement) &&
               keypad2[position+movement] != 0
                position += movement
            end
        end
        ans *= string(keypad2[position])
    end
    return ans
end
