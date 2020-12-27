function readinput(filename)
    return filter(!isempty, split(read(filename, String),"\n"))
end

function gentiles(lines)
    tiles = Dict()
    tileid = 0
    for line in lines
        if startswith(line, "Tile ")
            tileid = line[6:end-1]
        else
            push!(tiles, tileid => append!((get!(tiles, tileid, [])),[line]))
        end
    end
    return tiles
end

function getedges(tile)
    prefix :: Array{Any,1} = [tile[1], join(x[end] for x in tile), tile[end], join(x[1] for x in tile)]
    append!(prefix, [tile])
    return prefix
end

function fliptile(tile)
    return collect(reverse(x) for x in tile)
end

function rotate(tile, num)
    newtile = tile
    for _ in 1:num
        reversetile = reverse(newtile)
        newtile = []
        for i in 1:length(reversetile[1])
            slice = ""
            for r in reversetile
                slice *= r[i]
            end
            push!(newtile, slice)
        end
    end
    return newtile
end

function genedges(tiles)
    edges = Dict()
    for (tileid, tile) in tiles
        e = []
        append!(e, [getedges(tile)])
        append!(e, [getedges(rotate(tile, 1))])
        append!(e, [getedges(rotate(tile, 2))])
        append!(e, [getedges(rotate(tile, 3))])
        append!(e, [getedges(fliptile(tile))])
        append!(e, [getedges(fliptile(rotate(tile, 1)))])
        append!(e, [getedges(fliptile(rotate(tile, 2)))])
        append!(e, [getedges(fliptile(rotate(tile, 3)))])
        push!(edges, tileid => e)
    end
    return edges
end

function geteligibles(curr, eligibles)
    return collect([(a,b) for (a,b) in eligibles if !(a in [c[1] for c in curr])])
end

function multcorner(nextedges, sidesize, totalsize)
    a = parse(Int,nextedges[1][1])
    b = parse(Int,nextedges[sidesize][1])
    c = parse(Int,nextedges[totalsize][1])
    d = parse(Int,nextedges[totalsize - sidesize + 1][1])
    return a * b * c * d
end

function mountimage(lines)
    alltiles = gentiles(lines)
    alledges = genedges(alltiles)
    sidesize = Int(sqrt(length(alltiles)))
    totalsize = length(alltiles)
    northedges, eastedges, southedges, westedges = Dict(), Dict(), Dict(), Dict()

    for (tileid, edges) in alledges
        for edge in edges
            e = pop!(northedges, edge[1], [])
            push!(e, (tileid, edge))
            push!(northedges, edge[1] => e)

            e = pop!(eastedges, edge[2], [])
            push!(e, (tileid, edge))
            push!(eastedges, edge[2] => e)

            e = pop!(southedges, edge[3], [])
            push!(e, (tileid, edge))
            push!(southedges, edge[3] => e)

            e = pop!(westedges, edge[4], [])
            push!(e, (tileid, edge))
            push!(westedges, edge[4] => e)
        end
    end

    for (itileid, iedges) in alledges
        for iedge in iedges
            eligibles = geteligibles([(itileid, iedge)], get(westedges, iedge[2], []))
            stack = [([(itileid, iedge)], eligibles)]

            while !isempty(stack)
                (currentedges, eligibles) = pop!(stack)

                if isempty(eligibles)
                    continue
                end

                currenteligible = pop!(eligibles)
                push!(stack, (currentedges, eligibles))
                nextedges = deepcopy(currentedges)
                push!(nextedges, currenteligible)

                if length(nextedges) == totalsize
                    return (multcorner(nextedges, sidesize, totalsize), nextedges)
                end

                nexteligibles = []

                if length(nextedges) < sidesize
                    nexteligibles = geteligibles(nextedges, get(westedges, currenteligible[2][2], []))
                else
                    above = nextedges[length(nextedges)-sidesize+1]
                    nexteligibles = geteligibles(nextedges, get(northedges, above[2][3], []))
                    if length(nextedges) % sidesize > 1
                        prev = nextedges[end]
                        nexteligibles = collect([n for n in nexteligibles if n[2][4] == prev[2][2]])
                    end
                end

                if !isempty(nexteligibles)
                    push!(stack, (nextedges, nexteligibles))
                end
            end
        end
    end
    return nothing
end

function combine(tiles)
    tilessize = length(tiles)
    side = Int(sqrt(tilessize))
    lines = []
    for i in collect(1:side:tilessize)
        tls = tiles[i:i+side-1]
        for idx in 1:length(tls[1])
            push!(lines, join(x[idx] for x in tls))
        end
    end
    return lines
end

function readmonster(filename)
    lines = readlines(filename)
    head, offset = -1, -1
    mid, low = [], []
    for (i, line) in enumerate(lines)
        for (j, char) in enumerate(line)
            if i == 1 && char == '#'
                head = j
            elseif i == 2 && char == '#'
                append!(mid, j - head)
            elseif i == 3 && char == '#'
                append!(low, j - head)
            elseif i != 1 && j > head && j - head > offset
                offset = j - head
            end
        end
    end
    return (head, offset, mid, low)
end

function findmonsters(image, monster="d20.monster")
    side = length(image[1])
    (head, offset, mid, low) = readmonster(monster)
    count = 0
    for i in 19:side
        for j in 1:length(image)-1
            if image[j][i] == '#'
                if i < side-offset && all([image[j+1][i + k] == '#' for k in mid])
                    if  i < side-offset && all([image[j+2][i + k] == '#' for k in low])
                        count += 1
                    end
                end
            end
        end
    end
    return count
end

function monsterhunt(image; showimage=false)
    bordertiles = [i[2][5] for i in image]
    nobordertiles = [[i[2:end-1] for i in j[2:end-1]] for j in bordertiles]

    bordertiles = combine(bordertiles)
    nobordertiles = combine(nobordertiles)
    if showimage
        println("------BORDER------")
        println(join(bordertiles, '\n'))
        println("-----NOBORDER-----")
        println(join(rotate(bordertiles, 1),'\n'))
        println("------------------")
    end
    total = findmonsters(nobordertiles)
    total += findmonsters(rotate(nobordertiles, 2))
    total += findmonsters(rotate(nobordertiles, 3))
    total += findmonsters(rotate(nobordertiles, 4))
    total += findmonsters(fliptile(nobordertiles))
    total += findmonsters(fliptile(rotate(nobordertiles, 2)))
    total += findmonsters(fliptile(rotate(nobordertiles, 3)))
    total += findmonsters(fliptile(rotate(nobordertiles, 4)))

    return (count("#",join(nobordertiles)) - total * 15)
end

lines = readinput("d20.in")
P1,image = mountimage(lines)
println("P1: ", P1)
P2 = monsterhunt(image)
println("P2: ", P2)
