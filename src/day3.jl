function part1()
    lines = open("input/day3.txt") do f
        return readlines(f)
    end

    possibletriangles = 0
    for line in lines
        sides = parse.(Int, split(line))
        sort!(sides)
        if sides[1] + sides[2] > sides[3]
            possibletriangles += 1
        end
    end
    return possibletriangles
end

function part2()
    lines = open("input/day3.txt") do f
        return readlines(f)
    end

    possibletriangles = 0
    for i in 1:length(lines)÷3
        line1 = split(lines[3*i-2])
        line2 = split(lines[3*i-1])
        line3 = split(lines[3*i])
        triangle1 = sort(parse.(Int, [line1[1], line2[1], line3[1]]))
        triangle2 = sort(parse.(Int, [line1[2], line2[2], line3[2]]))
        triangle3 = sort(parse.(Int, [line1[3], line2[3], line3[3]]))
        if triangle1[1] + triangle1[2] > triangle1[3]
            possibletriangles += 1
        end
        if triangle2[1] + triangle2[2] > triangle2[3]
            possibletriangles += 1
        end
        if triangle3[1] + triangle3[2] > triangle3[3]
            possibletriangles += 1
        end
    end
    return possibletriangles
end
