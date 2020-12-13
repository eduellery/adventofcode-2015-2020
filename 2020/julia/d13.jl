input = readlines("d13.in")

function validids(ids)
    return map(x -> parse(Int, x), filter(x -> tryparse(Int, x) != nothing, ids))
end

function validpositions(ids)
    return findall(!=(nothing), tryparse.(Int, ids)) .- 1
end

function findearliest(timestamp, ids)
    delay, i = findmin(mod.(-timestamp,ids))
    return delay, ids[i]
end

function crt(n, a)
    Π = prod(n)
    return mod(sum(ai * invmod(Π ÷ ni, ni) * Π ÷ ni for (ni, ai) in zip(n, -a)), Π)
end

timestamp = parse(Int, input[1])
ids = split(input[2],",")

println("P1: ", prod(findearliest(timestamp, validids(ids))))
println("P2: ", crt(validids(ids), validpositions(ids)))
