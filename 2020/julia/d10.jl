function readinput(filename)
    map(value -> parse(Int, value), readlines(filename))
end

function getjoltdifferences(jolts)
    basejolt = 0
    joltdifferences = Dict(1 => 0, 2 => 0, 3 => 0)
    joltdifferences[3] += 1
    while length(jolts) > 0
        jolt = popfirst!(jolts)
        joltdifferences[jolt - basejolt] += 1
        basejolt = jolt
    end
    return joltdifferences
end

function getjoltcombinations(jolts)
    pushfirst!(jolts, 0)
    n = length(jolts)
    joltcombinations = zeros(Int, n)
    joltcombinations[1] = 1
    for i in 1:n-1
        for k in i+1:n
            if jolts[k] - jolts[i] <= 3
                joltcombinations[k] += joltcombinations[i]
            end
        end
    end
    return joltcombinations
end

jolts = sort!(readinput("d10.in"))
joltdifferences = getjoltdifferences(deepcopy(jolts))
joltcombinations = getjoltcombinations(deepcopy(jolts))
println("P1: ", joltdifferences[1] * joltdifferences[3])
println("P2: ", joltcombinations[end])
