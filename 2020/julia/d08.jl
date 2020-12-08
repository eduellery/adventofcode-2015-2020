function readinput(filename)
    map(group -> filter(!isempty, split(group, " ")), split(read(filename, String), "\n", keepempty=false))
end

function findindex!(accumulators, instructions)
    index, accumulator = 1, 0
    visited = falses(length)
    while true
        if index > length || visited[index]
            append!(accumulators, accumulator)
            accumulator = 0
            break
        else
            visited[index] = true
            instruction = instructions[index][1]
            amount = parse(Int64, instructions[index][2])
            if instruction == "jmp"
                index += amount
            elseif instruction == "acc"
                accumulator += amount
                index += 1
            else
                index += 1
            end
        end
    end
    return index
end

function swap(frominstructions, index)
    toinstructions = deepcopy(frominstructions)
    if toinstructions[index][1] == "nop"
        toinstructions[index][1] = "jmp"
    else
        toinstructions[index][1] = "nop"
    end
    return toinstructions
end

original = readinput("d08.in")
length = size(original, 1)

changeable = Set()
for i in 1:length
    if original[i][1] == "jmp" || original[i][1] == "nop"
        push!(changeable, i)
    end
end

instructions = deepcopy(original)
accumulators = []

while true
    lastindex = findindex!(accumulators, instructions)
    if lastindex > length
        break
    else
        changed = pop!(changeable)
        global instructions = swap(original, changed)
    end
end

println("P1: ", first(accumulators))
println("P2: ", last(accumulators))
