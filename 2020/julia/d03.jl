using DelimitedFiles

lines = readdlm("d03.in", ' ', String)
const height, width = size(lines, 1), length(lines[1])

function trees(right, down)
    x, y, tree = 0, 0, 0
    while y < height
        if lines[y+1][x+1] == '#'
            tree += 1
        end
        y += down
        x = (x + right) % width
    end
    return tree
end

P1 = trees(3, 1)
P2 = P1 * trees(1, 1) * trees(5, 1) * trees(7, 1) * trees(1, 2)

println("P1: ", P1)
println("P2: ", P2)
