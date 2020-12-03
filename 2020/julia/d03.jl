using DelimitedFiles

lines = readdlm("d03.in", ' ', String)
height,width = size(lines, 1), length(lines[1])
right, down = 3, 1
x, y = 0, 0
P1 = 0

while y < height
    if lines[y+1][x+1] == '#'
        P1 += 1
    end
    y += down
    x = (x + right) % width
end

println("P1: ", P1)
