using DelimitedFiles

function part1()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    grid = fill(false, 6, 50)
    for line in lines
        if startswith(line, "rect")
            _, dimensions = split(line)
            x, y = parse.(Int, split(dimensions, 'x'))
            for i in 1:y
                for j in 1:x
                    grid[i, j] = true
                end
            end
        elseif startswith(line, "rotate column")
            dimensions = line[17:end]
            x, steps = parse.(Int, split(dimensions, " by "))
            x += 1
            newgrid = copy(grid)
            for i in 1:size(grid, 1)
                newgrid[i, x] =
                    checkbounds(Bool, grid[:, x], i - steps) ? grid[i-steps, x] :
                    grid[i-steps+size(grid, 1), x]
            end
            grid = newgrid
        elseif startswith(line, "rotate row")
            dimensions = line[14:end]
            y, steps = parse.(Int, split(dimensions, " by "))
            y += 1
            newgrid = copy(grid)
            for i in 1:size(grid, 2)
                newgrid[y, i] =
                    checkbounds(Bool, grid[y, :], i - steps) ? grid[y, i-steps] :
                    grid[y, i-steps+size(grid, 2)]
            end
            grid = newgrid
        end
    end
    return count(grid)
end

function part2()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    grid = fill(false, 6, 50)
    for line in lines
        if startswith(line, "rect")
            _, dimensions = split(line)
            x, y = parse.(Int, split(dimensions, 'x'))
            for i in 1:y
                for j in 1:x
                    grid[i, j] = true
                end
            end
        elseif startswith(line, "rotate column")
            dimensions = line[17:end]
            x, steps = parse.(Int, split(dimensions, " by "))
            x += 1
            newgrid = copy(grid)
            for i in 1:size(grid, 1)
                newgrid[i, x] =
                    checkbounds(Bool, grid[:, x], i - steps) ? grid[i-steps, x] :
                    grid[i-steps+size(grid, 1), x]
            end
            grid = newgrid
        elseif startswith(line, "rotate row")
            dimensions = line[14:end]
            y, steps = parse.(Int, split(dimensions, " by "))
            y += 1
            newgrid = copy(grid)
            for i in 1:size(grid, 2)
                newgrid[y, i] =
                    checkbounds(Bool, grid[y, :], i - steps) ? grid[y, i-steps] :
                    grid[y, i-steps+size(grid, 2)]
            end
            grid = newgrid
        end
    end
    return writedlm("day8.csv", grid, ',') # open in table viewer
end
