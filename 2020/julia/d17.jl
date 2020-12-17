function generateall(input)
    cubes = Set{Tuple{Int,Int,Int}}()
    hypercubes = Set{Tuple{Int,Int,Int,Int}}()
    for (i, r) in enumerate(input)
        for (j, c) in enumerate(r)
            if c == '#'
                push!(cubes, (i, j, 0))
                push!(hypercubes, (i, j, 0, 0))
            end
        end
    end
    return cubes, hypercubes
end

function generatecuberange()
    r = (-1:1)
    return collect((x, y, z) for x in r for y in r for z in r if x != 0 || y != 0 || z != 0)
end

function generatehypercuberange()
    r = (-1:1)
    return collect((x, y, z, w) for x in r for y in r for z in r for w in r if x != 0 || y != 0 || z != 0 || w != 0)
end

function nextcubes(cubes)
    newcubes = deepcopy(cubes)
    marked = Dict()
    for (x, y, z) in cubes
        neighbors = 0
        for (dx, dy, dz) in generatecuberange()
            cube = (x + dx, y + dy, z + dz)
            if ∈(cube, cubes)
                neighbors += 1
            else
                push!(marked, cube => (get!(marked, cube, 0) + 1))
            end
        end
        if ∉(neighbors, [2, 3])
            pop!(newcubes, (x, y, z))
        end
    end
    for (cube, count) in marked
        if count == 3
            push!(newcubes, cube)
        end
    end
    return newcubes
end

function nexthypercubes(hypercubes)
    newhypercubes = deepcopy(hypercubes)
    marked = Dict()
    for (x, y, z, w) in hypercubes
        neighbors = 0
        for (dx, dy, dz, dw) in generatehypercuberange()
            cube = (x + dx, y + dy, z + dz, w + dw)
            if ∈(cube, hypercubes)
                neighbors += 1
            else
                push!(marked, cube => (get!(marked, cube, 0) + 1))
            end
        end
        if ∉(neighbors, [2, 3])
            pop!(newhypercubes, (x, y, z, w))
        end
    end
    for (cube, count) in marked
        if count == 3
            push!(newhypercubes, cube)
        end
    end
    return newhypercubes
end

function cycle(something, next, cycle = 6)
    i = 0
    while i < cycle
        something = next(something)
        i += 1
    end
    return something
end

input = readlines("d17.in")
cubes, hypercubes = generateall(input)
cubes = cycle(cubes, nextcubes)
hypercubes = cycle(hypercubes, nexthypercubes)

println("P1: ", length(cubes))
println("P2: ", length(hypercubes))
