using DelimitedFiles

lines = readlines("d05.in")

P1 = 0
const rows, columns = 127, 7

function findposition(line, upper, lowdelimiter)
    delta = (upper + 1) ÷ 2
    lower = 0
    for char in line
        if char == lowdelimiter
            upper -= delta
        else
            lower += delta
        end
        delta = delta ÷ 2
    end
    return lower
end

for line in lines
    row = findposition(line[1:end-3], rows, 'F')
    col = findposition(line[8:end], columns, 'L')
    id = row * 8 + col
    if id > P1
        global P1 = id
    end
end

println("P1: ", P1)
