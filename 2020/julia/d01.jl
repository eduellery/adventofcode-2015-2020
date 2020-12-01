using DelimitedFiles
using Base.Iterators

values = readdlm("d01.in", '\t', Int, '\n')
length = size(values, 1)
sum = 2020
P1 = 0
P2 = 0

for i in 1:length
    for j in i+1:length
        if values[i] + values[j] == sum
            global P1 = values[i] * values[j]
        end
        for k in j+1:length
            if values[i] + values[j] + values[k] == sum
                global P2 = values[i] * values[j] * values[k]
            end
        end
    end
end

println("P1: ", P1)
println("P2: ", P2)