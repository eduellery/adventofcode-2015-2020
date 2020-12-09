function readinput(filename)
    map(value -> parse(Int, value), readlines(filename))
end

function sumexist(numbers, number)
    i = 1
    for x in numbers[1:end-1]
        i += 1
        for y in numbers[i:end]
            if x + y == number
                return true
            end
        end
    end
    return false
end

function findinvalid(values, preamble = 25)
    queue = []
    for value in values[1:preamble]
        push!(queue, value)
    end
    for value in values[preamble+1:end]
        if !sumexist(queue, value)
            return value
        end
        pop = popfirst!(queue)
        push!(queue, value)
    end
    return -1
end

function findsum(values, invalid)
    n = 1
    for x in values[1:end-1]
        group = []
        n += 1
        push!(group, x)
        for y in values[n:end]
            push!(group, y)
            if sum(group) == P1
                return deepcopy(group)
            end
        end
    end
    return []
end

values = readinput("d09.in")
P1 = findinvalid(values)
sumgroup = findsum(values, P1)
P2 = minimum(sumgroup) + maximum(sumgroup)

println("P1: ", P1)
println("P2: ", P2)
