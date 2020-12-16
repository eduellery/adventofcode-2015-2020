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

function inrange(rule, field)
    return field in rule[1] || field in rule[2]
end

function rulesapplies(rules, field)
    return any(rule -> inrange(rule, field), values(rules))
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

function rulesbyposition(rules, myticket, validtickets)
    possibilities = Dict()
    for i in 1:length(myticket)
        for (label, rule) in rules
            if all(field -> inrange(rule, field), ticket[i] for ticket in validtickets)
                possibilities[i] = push!(get(possibilities, i, String[]), label)
            end
        end
    end
    return possibilities
end

function rulesorder(possiblerules)
    rulespositions = Dict()
    while !isempty(possiblerules)
        for (i, labels) in possiblerules
            if length(labels) == 1
                label = labels[1]
                rulespositions[label] = i
                pop!(possiblerules, i)
                for (i, labels) in possiblerules
                    setdiff!(labels, [label])
                end
                break
            end
        end
    end
    return rulespositions
end

function findfields(myticket, rulespositions, searchstring)
    return collect(myticket[i] for (label, i) in rulespositions if contains(label, searchstring))
end

input = readinput("d16.in")

rules = parserules(input[1])
myticket = tointarray(input[2][2])
nearbytickets = Dict((index, val) for (index, val) in enumerate(map(x -> tointarray(x), input[3][2:end])))

invalidtickets, invalidfields = findinvalid(rules, nearbytickets)
validtickets = setdiff(values(nearbytickets), invalidtickets)
possiblerules = rulesbyposition(rules, myticket, validtickets)
rulespositions = rulesorder(possiblerules)
departurefields = findfields(myticket, rulespositions, "departure")

println("P1: ", sum(invalidfields))
println("P2: ", prod(departurefields))
