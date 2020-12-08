function readinput(filename)
    map(group -> filter(!isempty, split(group, "\n")), split(read(filename, String), "\n\n"))
end

P1, P2 = 0, 0

groups = readinput("d06.in")

for group in groups
    global P1 += length(Set(join(group)))
    commonanswers = Set(first(group))
    for answers in group
        intersect!(commonanswers, answers)
    end
    global P2 += length(commonanswers)
end

println("P1: ", P1)
println("P2: ", P2)
