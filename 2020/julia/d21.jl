function readinput(filename)
    ingredients = Vector()
    allergens = Vector()
    for line in readlines(filename)
        ingredients_str, contains_str = split(line, "(contains ")
        push!(ingredients, Set(String(m.match) for m in eachmatch(r"[a-z]+", ingredients_str)))
        push!(allergens, Set(String(m.match) for m in eachmatch(r"[a-z]+", contains_str)))
    end
    return (ingredients, allergens)
end

function getpotentialingredients(ingredients, allergens)
    allingredients = union(ingredients...)
    allallergens = union(allergens...)
    potentialingredients = Dict()
    for allergen in allallergens
        potentialingredients[allergen] = copy(allingredients)
        for (ilist, alist) in zip(ingredients, allergens)
            if allergen in alist
                intersect!(potentialingredients[allergen], ilist)
            end
        end
    end
    return potentialingredients
end

function part1(potentialingredients, ingredients)
    allingredients = union(ingredients...)
    unsafe = union(values(potentialingredients)...)
    return sum(count(ilist -> s in ilist, ingredients) for s in setdiff(allingredients, unsafe))
end

function part2(potentialingredients, ingredients, allergens)
    matched = Vector()
    while !isempty(potentialingredients)
        for (allergen, ingredients) in potentialingredients
            if length(ingredients) == 1
                ingredient = pop!(ingredients)
                push!(matched, (allergen, ingredient))
                delete!(potentialingredients, allergen)
                for ilist in values(potentialingredients)
                    delete!(ilist, ingredient)
                end
                break;
            end
        end
    end
    sort!(matched, by=((a,i),)->a)
    return join([i for (_,i) in matched], ",")
end

(ingredients, allergens) = readinput("d21.in")
potentialingredients = getpotentialingredients(ingredients, allergens)

println("P1: ", part1(potentialingredients, ingredients))
println("P2: ", part2(potentialingredients, ingredients, allergens))
