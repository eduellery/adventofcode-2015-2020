using DelimitedFiles
using Base.Iterators

values = readdlm("d01.in", '\t', Int, '\n')
sum = 2020

function matching_sum(numbers, sum)
    for (a, b) in product(numbers, numbers)
        if a + b == sum
            return a * b
        end
    end
end

println("P1: ", matching_sum(values, sum))