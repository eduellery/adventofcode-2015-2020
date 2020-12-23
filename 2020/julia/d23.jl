struct LinkedList
    next :: Vector{Int32}
end

function run!(list :: LinkedList, currentcup :: Int, n :: Int)
    wrap(n) = mod1(n, length(list.next))
    for _ in 1:n
        pickedcup1 = list.next[currentcup]
        pickedcup2 = list.next[pickedcup1]
        pickedcup3 = list.next[pickedcup2]
        afterpickedup = list.next[pickedcup3]
        list.next[currentcup] = afterpickedup

        targetcup = wrap(currentcup - 1)
        while targetcup in (pickedcup1, pickedcup2, pickedcup3)
            targetcup = wrap(targetcup - 1)
        end
        aftertargetcup = list.next[targetcup]

        list.next[targetcup] = pickedcup1
        list.next[pickedcup3] = aftertargetcup
        currentcup = afterpickedup
    end
end

function cuporder(start, list, size)
    n = list.next[start]
    s = ""
    for _ in 2:size
        s = join([s, repr(n)])
        n = list.next[n]
    end
    return parse(Int64, s)
end

function cycle(numbers, cycles; part2=false, N=10^6)
    list = LinkedList(Int32[])
    if part2
        sizehint!(list.next, N)
    end
    indexof(n) = findfirst(i -> i == mod1(n, length(numbers)), numbers)
    for n in 1:length(numbers)
        push!(list.next, numbers[mod1(indexof(n) + 1, length(numbers))])
    end
    if part2
        for n in (length(numbers)+1):N
            push!(list.next, n+1)
        end
        list.next[N] = first(numbers)
        list.next[last(numbers)] = length(numbers)+1
    end
    run!(list, first(numbers), cycles)
    if part2
        return Int64(list.next[1]) * list.next[list.next[1]]
    else
        return cuporder(1, list, length(numbers))
    end
end

# test = [3,8,9,1,2,5,4,6,7] # 10:92658374 100:67384529; part2:149245887792
input = [5,3,8,9,1,4,7,6,2]

println("P1: ", cycle(input, 100))
println("P2: ", cycle(input, 10^7; part2 = true))
