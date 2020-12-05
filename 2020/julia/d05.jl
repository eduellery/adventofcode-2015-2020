using DelimitedFiles

lines = readlines("d05.in")

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

seats = []

for line in lines
    row = findposition(line[1:end-3], rows, 'F')
    col = findposition(line[8:end], columns, 'L')
    id = row * 8 + col
    append!(seats, id)
end

allseats = Set(minimum(seats) : maximum(seats))

println("P1: ", maximum(seats))
println("P2: ", only(setdiff(allseats, seats)))
