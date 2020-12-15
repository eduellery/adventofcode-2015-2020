function readinput(filename)
    map(value -> parse(Int, value), split(read(filename, String), ","))
end

function nextitem!(lookup, item, pos)
    if haskey(lookup, item)
        next = pos - lookup[item]
        lookup[item] = pos
        return next
    else
        lookup[item] = pos
        return 0
    end
end

function iterate(input, turns=2020)
    next = pop!(input)
    lookup = Dict{Int, Int}((val, index) for (index, val) in enumerate(input))
    for i in (1+length(input)):(turns-1)
        next = nextitem!(lookup, next, i)
    end
    return next
end

numbers = readinput("d15.in")

println("P1: ", iterate(deepcopy(numbers)))
println("P2: ", iterate(deepcopy(numbers), 30000000))
