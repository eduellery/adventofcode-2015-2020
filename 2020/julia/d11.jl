function readinput(filename)
    map(group -> filter(!isempty, split(group, "")), readlines(filename))
end

function countadjacentoccupied(values, dd, row, col, m, n)
    occupied = 0
    for (x, y) in dd
        r, c = row + x, col + y
        if !(r in 1:m && c in 1:n)
            continue
        end
        occupied += values[r][c] == "#"
    end
    return occupied
end

function countoccupied(values, m, n)
    return sum(values[r][c] == "#" for r in 1:m for c in 1:n)
end

function shuffleseats(original, threshold = 4)
    changed = deepcopy(original)
    for i in 1:m
        for j in 1:n
            if original[i][j] == "L" && countadjacentoccupied(original, dd, i, j, m, n) == 0
                changed[i][j] = "#"
            elseif original[i][j] == "#" && countadjacentoccupied(original, dd, i, j, m, n) >= threshold
                changed[i][j] = "L"
            end
        end
    end
    return changed
end

function convergeseats(seats)
    while true
        next = shuffleseats(seats)
        if next == seats
            return next
        end
        seats = next
    end
end

dd = [(1, 0),(-1, 0),(0, 1),(0, -1),(1, 1),(1, -1),(-1, 1),(-1, -1)]

seats = readinput("d11.in")

m = length(seats)
n = length(seats[1])

println("P1: ", countoccupied(convergeseats(seats), m, n))
