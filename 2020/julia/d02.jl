function readinput(filename)
    map(group -> filter(!isempty, split(group, " ")), readlines(filename))
end

lines = readinput("d02.in")

P1, P2 = 0, 0

for line in lines
    nums = parse.(Int, split(line[1], '-'))
    char = line[2][1]
    pass = line[3]
    x = count(x -> x == char, pass)
    if nums[1] <= x <= nums[2]
        global P1 += 1
    end
    if xor(pass[nums[1]] == char, pass[nums[2]] == char)
        global P2 += 1
    end
end

println("P1: ", P1)
println("P2: ", P2)
