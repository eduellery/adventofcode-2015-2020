function readinput(filename)
    map(value -> parse(Int, value), readlines(filename))
end

lines = readinput("d01.in")
length = size(lines, 1)

sum = 2020
P1, P2 = 0, 0

for i in 1:length
    for j in i+1:length
        if lines[i] + lines[j] == sum
            global P1 = lines[i] * lines[j]
        end
        for k in j+1:length
            if lines[i] + lines[j] + lines[k] == sum
                global P2 = lines[i] * lines[j] * lines[k]
            end
        end
    end
end

println("P1: ", P1)
println("P2: ", P2)
