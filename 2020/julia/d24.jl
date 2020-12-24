function readinput(filename)
    groups = map(x -> eachmatch(r"(e|se|sw|w|nw|ne)", x), readlines(filename))
end

function sumtuple(a, b, dims)
    return ntuple(i -> a[i] + b[i], dims)
end

function blacktiles(lines)
    blacks = Set()
    for line in lines
        point = (0,0,0)
        for d in line
            point = sumtuple(point, hd[d[1]], 3)
        end
        if point in blacks
            pop!(blacks, point)
        else
            push!(blacks, point)
        end
    end
    return blacks
end

function changetiles(blacks)
    newblacks = Set()
    check = Set()
    for b in blacks
        push!(check,b)
        for d in values(hd)
            push!(check,sumtuple(b,d,3))
        end
    end
    for c in check
        n = 0
        for d in values(hd)
            if sumtuple(c,d,3) in blacks
                n += 1
            end
        end
        if c in blacks && (n == 1 || n == 2)
            push!(newblacks,c)
        end
        if !(c in blacks) && n == 2
            push!(newblacks,c)
        end
    end
    return newblacks
end

function looptiles(blacks, cycles)
    for i in 1:cycles
        blacks = changetiles(blacks)
    end
    return blacks
end

hd = Dict("e"=>(1,-1,0),"se"=>(0,-1,1),"sw"=>(-1,0,1),"w"=>(-1,1,0),"nw"=>(0,1,-1),"ne"=>(1,0,-1))

lines = readinput("d24.in")
blacks1 = blacktiles(lines)
blacks2 = looptiles(blacks1, 100)

println("P1: ", length(blacks1))
println("P2: ", length(blacks2))
