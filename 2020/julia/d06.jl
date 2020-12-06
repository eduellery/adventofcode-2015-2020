lines = readlines("d06.in")
append!(lines, [""])

P1 = 0

answers = Set()
for line in lines
    if line == ""
        global P1 += length(answers)
        global answers = Set()
    else
        for char in line
            push!(answers, char)
        end
    end
end

println("P1: ", P1)
