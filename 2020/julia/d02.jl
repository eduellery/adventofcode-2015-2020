using DelimitedFiles

lines = readdlm("d02.in", ' ', String)
length = size(lines, 1)
P1 = 0

for i in 1:length
    nums = parse.(Int, split(lines[i,1], '-'))
    char = lines[i,2][1]
    pass = lines[i,3]
    x = count(x -> x == char, pass)
    if nums[1] <= x <= nums[2]
        global P1 += 1
    end
end

println("P1: ", P1)
