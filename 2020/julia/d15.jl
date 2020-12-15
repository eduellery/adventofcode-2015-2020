function readinput(filename)
    map(value -> parse(Int, value), split(read(filename, String), ","))
end

function getvalueat(numbers, position = 2020)
    dict = Dict{Int,Array{Int}}()
    last = -1
    for i in 1:length(numbers)
        push!(dict, numbers[i] => [i])
        last = numbers[i]
    end
    for i in length(numbers)+1:position
        if last in keys(dict)
            value = get(dict, last, nothing)
            if length(value) == 1
                last = value[1] - i + 1
            else
                last = value[end] - value[end-1]
            end
            if last in keys(dict)
                append!(get(dict, last, nothing), i)
            else
                push!(dict, last => [i])
            end
        end
    end
    return last
end

numbers = readinput("d15.in")

println("P1: ", getvalueat(numbers))
println("P2: ", getvalueat(numbers, 30000000))
