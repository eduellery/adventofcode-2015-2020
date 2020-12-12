function step(position, scalar, direction)
    return map(+, position, map(*, (scalar, scalar), direction))
end

function changedirection(direction, clockwise, angle)
    newdirection = Nothing
    if direction == "N"
        if angle == 90
            newdirection = clockwise ? "E" : "W"
        elseif angle == 180
            newdirection = "S"
        elseif angle == 270
            newdirection = clockwise ? "W" : "E"
        end
    elseif direction == "E"
        if angle == 90
            newdirection = clockwise ? "S" : "N"
        elseif angle == 180
            newdirection = "W"
        elseif angle == 270
            newdirection = clockwise ? "N" : "S"
        end
    elseif direction == "S"
        if angle == 90
            newdirection = clockwise ? "W" : "E"
        elseif angle == 180
            newdirection = "N"
        elseif angle == 270
            newdirection = clockwise ? "E" : "W"
        end
    elseif direction == "W"
        if angle == 90
            newdirection = clockwise ? "N" : "S"
        elseif angle == 180
            newdirection = "E"
        elseif angle == 270
            newdirection = clockwise ? "S" : "N"
        end
    end
    return newdirection
end

function changewaypoint(waypoint, clockwise, angle)
    newwaypoint = deepcopy(waypoint)
    factor = clockwise ? get(right, angle, nothing) : get(left, angle, nothing)
    if angle in [90, 270]
        newwaypoint = reverse(waypoint)
    end
    newwaypoint = map(*, factor, newwaypoint)
    return newwaypoint
end

function move(values, direction = "E", position = (0, 0), waypoint = (10, 1))
    correctposition = deepcopy(position)
    for value in values
        m = match(r"^(\w)(\d+)", value)
        (char, digit) = m.captures[1], parse(Int, m.captures[2])
        if char == "F"
            position = step(position, digit, get(dd, direction, nothing))
            correctdirection = map(*, (digit, digit), waypoint)
            correctposition = map(+, correctposition, correctdirection)
        elseif char == "L"
            direction = changedirection(direction, false, digit)
            waypoint = changewaypoint(waypoint, false, digit)
        elseif char == "R"
            direction = changedirection(direction, true, digit)
            waypoint = changewaypoint(waypoint, true, digit)
        else
            position = step(position, digit, get(dd, char, nothing))
            waypoint = step(waypoint, digit, get(dd, char, nothing))
        end
    end
    return direction, waypoint, position, correctposition
end

values = readlines("d12.in")
dd = Dict([("N", (0, 1)), ("S", (0, -1)), ("E", (1, 0)), ("W", (-1, 0))])
right = Dict([(90, (1, -1)), (180, (-1, -1)), (270, (-1, 1))])
left = Dict([(270, (1, -1)), (180, (-1, -1)), (90, (-1, 1))])
_, _, position, correctposition = move(values)

println("P1: ", sum(broadcast(abs, position)))
println("P2: ", sum(broadcast(abs, correctposition)))
