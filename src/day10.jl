const VALUE_RE = r"value (\d+) goes to bot (\d+)"
const HANDOFF_RE =
    r"bot (\d+) gives low to (output \d+|bot \d+) and high to (output \d+|bot \d+)"

function part1()
    lines = open("input/day10.txt") do f
        return readlines(f)
    end

    bots = Dict{Int,Vector{Int}}()
    while !isempty(lines)
        remaininglines = Vector{String}()
        for line in lines
            if startswith(line, "value")
                m = match(VALUE_RE, line)
                value = parse(Int, m[1])
                bot = parse(Int, m[2])
                if bot in keys(bots)
                    push!(bots[bot], value)
                    if 61 in bots[bot] && 17 in bots[bot]
                        return bot
                    end
                else
                    bots[bot] = [value]
                end
            else
                m = match(HANDOFF_RE, line)
                bot = parse(Int, m[1])
                if !(bot in keys(bots)) || length(bots[bot]) == 1
                    push!(remaininglines, line)
                    continue
                end
                destinationlow = m[2]
                destinationhigh = m[3]
                if startswith(destinationlow, "bot")
                    botlow = parse(Int, destinationlow[5:end])
                    if botlow in keys(bots)
                        push!(bots[botlow], minimum(bots[bot]))
                        if 61 in bots[botlow] && 17 in bots[botlow]
                            return botlow
                        end
                    else
                        bots[botlow] = [minimum(bots[bot])]
                    end
                end
                if startswith(destinationhigh, "bot")
                    bothigh = parse(Int, destinationhigh[5:end])
                    if bothigh in keys(bots)
                        push!(bots[bothigh], maximum(bots[bot]))
                        if 61 in bots[bothigh] && 17 in bots[bothigh]
                            return bothigh
                        end
                    else
                        bots[bothigh] = [maximum(bots[bot])]
                    end
                end
            end
        end
        lines = remaininglines
    end
end

function part2()
    lines = open("input/day10.txt") do f
        return readlines(f)
    end

    bots = Dict{Int,Vector{Int}}()
    output = Dict{Int,Int}()
    while !isempty(lines)
        remaininglines = Vector{String}()
        for line in lines
            if startswith(line, "value")
                m = match(VALUE_RE, line)
                value = parse(Int, m[1])
                bot = parse(Int, m[2])
                if bot in keys(bots)
                    push!(bots[bot], value)
                else
                    bots[bot] = [value]
                end
            else
                m = match(HANDOFF_RE, line)
                bot = parse(Int, m[1])
                if !(bot in keys(bots)) || length(bots[bot]) == 1
                    push!(remaininglines, line)
                    continue
                end
                destinationlow = m[2]
                destinationhigh = m[3]
                if startswith(destinationlow, "bot")
                    botlow = parse(Int, destinationlow[5:end])
                    if botlow in keys(bots)
                        push!(bots[botlow], minimum(bots[bot]))
                    else
                        bots[botlow] = [minimum(bots[bot])]
                    end
                else
                    outlow = parse(Int, destinationlow[8:end])
                    output[outlow] = minimum(bots[bot])
                end
                if startswith(destinationhigh, "bot")
                    bothigh = parse(Int, destinationhigh[5:end])
                    if bothigh in keys(bots)
                        push!(bots[bothigh], maximum(bots[bot]))
                    else
                        bots[bothigh] = [maximum(bots[bot])]
                    end
                else
                    outhigh = parse(Int, destinationhigh[8:end])
                    output[outhigh] = maximum(bots[bot])
                end
            end
        end
        if 0 in keys(output) && 1 in keys(output) && 2 in keys(output)
            return output[0] * output[1] * output[2]
        end
        lines = remaininglines
    end
end
