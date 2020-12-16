function readinput(filename)
    map(group -> filter(!isempty, split(group, "\n")), split(read(filename, String), "\n\n"))
end

function parserules(value)
    matches = map(x -> match(r"^([\w\s]+): (\d+)-(\d+) or (\d+)-(\d+)$", x), value)
    return Dict(map(m -> (m.captures[1], (parse(Int, m.captures[2]):parse(Int, m.captures[3]),parse(Int, m.captures[4]):parse(Int, m.captures[5]))), matches))
end

function tointarray(value)
    map(x -> parse(Int,x), split(value, ","))
end

function rulesapplies(rules, field)
    return any(r -> (field in r[1] || field in r[2]), values(rules))
end

function findinvalid(rules, nearbytickets)
    invalidtickets = Set()
    invalidfields = Int[]
    for ticket in values(nearbytickets)
        for field in ticket
            if !rulesapplies(rules, field)
                push!(invalidtickets, ticket)
                push!(invalidfields, field)
            end
        end
    end
    return invalidtickets, invalidfields
end

input = readinput("d16.in")

rules = parserules(input[1])
myticket = tointarray(input[2][2])
nearbytickets = Dict((index, val) for (index, val) in enumerate(map(x -> tointarray(x), input[3][2:end])))

invalidtickets, invalidfields = findinvalid(rules, nearbytickets)

println("P1: ", sum(invalidfields))
