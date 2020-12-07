lines = readlines("d07.in")

baggraph = Dict{String,Vector{Tuple{Int,String}}}()

function invertgraph(baggraph)
    invertedgraph = Dict{String,Set{String}}()
    for (outerbag, innerbags) in baggraph
        for (_, innerbag) in innerbags
            push!(invertedgraph, innerbag => union!(get(invertedgraph, innerbag, Set{String}()), [outerbag]))
        end
    end
    return invertedgraph
end

function containingbags(invertedgraph, desiredbag)
    bags = Set{String}()
    visit = Set([desiredbag])
    while !isempty(visit)
        bag = pop!(visit)
        if bag in keys(invertedgraph)
            outers = invertedgraph[bag]
            union!(bags, outers)
            union!(visit, outers)
            pop!(invertedgraph, bag)
        end
    end
    return bags
end

function countbags(baggraph, desiredbag)
  innerbags = baggraph[desiredbag]
  if isempty(innerbags)
    return 1
  else
    return 1 + sum(n * countbags(baggraph, innerbag) for (n, innerbag) in innerbags)
  end
end

for line in lines
    m = match(r"^([\w ]+) bags contain ", line)
    outerbag = m.captures[1]
    innerbags = eachmatch(r"(\d+) ([\w ]+) bags?[,.]", line[length(m.match)+1:end])
    push!(baggraph, outerbag => [Tuple([parse(Int, i.captures[1]), i.captures[2]]) for i in innerbags])
end

desiredbag = "shiny gold"

P1 = length(containingbags(invertgraph(baggraph),desiredbag))
P2 = countbags(baggraph, desiredbag) - 1

println("P1: ", P1)
println("P2: ", P2)
