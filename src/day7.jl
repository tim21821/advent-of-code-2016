"""
Return whether `str` contains an ABBA sequence.
"""
containsabba(str::AbstractString) = any(
    i -> str[i] != str[i+1] && str[i] == str[i+3] && str[i+1] == str[i+2],
    1:length(str)-3,
)

"""
Return all ABA sequences in `str`.
"""
function getabas(str::AbstractString)
    abas = Vector{String}()
    for i in 1:length(str)-2
        if str[i] != str[i+1] && str[i] == str[i+2]
            push!(abas, str[i:i+2])
        end
    end
    return abas
end

"""
Return all corresponding BAB sequences to `abas`.
"""
getbabs(abas::Vector{String}) = [s[2] * s[1] * s[2] for s in abas]

const INSIDE_BRACKETS_RE = r"\[([a-z]+)\]"

"""
Return whether `ip` supports TLS.
"""
function supportstls(ip::AbstractString)
    hypernetsequences = eachmatch(INSIDE_BRACKETS_RE, ip)
    for sequence in hypernetsequences
        if any(containsabba, sequence.captures)
            return false
        end
    end
    return containsabba(ip)
end

"""
Return whether `ip` supports SSL.
"""
function supportsssl(ip::AbstractString)
    hypernetsequences = Vector{String}()
    for sequence in eachmatch(INSIDE_BRACKETS_RE, ip)
        append!(hypernetsequences, sequence.captures)
    end
    outsidebrackets = replace(ip, INSIDE_BRACKETS_RE => "")
    abas = getabas(outsidebrackets)
    if isempty(abas)
        return false
    end

    babs = getbabs(abas)
    return any(seq -> any(bab -> occursin(bab, seq), babs), hypernetsequences)
end

function part1()
    lines = open("input/day7.txt") do f
        return readlines(f)
    end

    return count(supportstls, lines)
end

function part2()
    lines = open("input/day7.txt") do f
        return readlines(f)
    end

    return count(supportsssl, lines)
end
