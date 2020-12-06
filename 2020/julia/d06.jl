lines = readlines("d06.in")
append!(lines, [""])

P1, P2 = 0, 0
groupanswers = Set()
individualanswers = []

for line in lines
    if line == ""
        global P1 += length(groupanswers)
        for answer in individualanswers
            intersect!(groupanswers, answer)
        end
        global P2 += length(groupanswers)
        global groupanswers = Set()
        global individualanswers = []
    else
        answer = Set()
        for char in line
            push!(groupanswers, char)
            push!(answer, char)
        end
        push!(individualanswers, answer)
    end
end

println("P1: ", P1)
println("P2: ", P2)
