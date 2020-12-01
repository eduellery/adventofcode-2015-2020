using DelimitedFiles
using Base.Iterators

values = readdlm("d01.in", '\t', Int, '\n')
sum = 2020

function matching_2sum(numbers, sum)
    for (a, b) in product(numbers, numbers)
        if a + b == sum
            return a * b
        end
    end
end

function matching_3sum(numbers, sum)
    for (a, b, c) in product(numbers, numbers, numbers)
        if a + b +c == sum
            return a * b * c
        end
    end
end

println("P1: ", matching_2sum(values, sum))
println("P2: ", matching_3sum(values, sum))