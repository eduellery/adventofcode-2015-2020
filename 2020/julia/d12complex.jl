function move(instructions, dir = Complex(1, 0), way = Complex(10, 1), pos = Complex(0, 0))
    pos1 = 0
    pos2 = pos
    directions = Dict([("N", Complex(0, 1)), ("S", Complex(0, -1)), ("E", Complex(1, 0)), ("W", Complex(-1, 0))])
    for instruction in instructions
        (cmd, stringval) = match(r"([NSEWLRF])([0-9]+)", instruction).captures
        val = parse(Int, stringval)
        if cmd == "F"
            pos1 += dir * val
            pos2 += way * val
        elseif cmd == "L"
            dir *= Complex(0, 1)^div(val, 90)
            way *= Complex(0, 1)^div(val, 90)
        elseif cmd == "R"
            dir *= Complex(0, -1)^div(val, 90)
            way *= Complex(0, -1)^div(val, 90)
        else
            pos1 += val * get(directions, cmd, nothing)
            way += val * get(directions, cmd, nothing)
        end
    end
    return (abs(real(pos1)) + abs(imag(pos1)), abs(real(pos2)) + abs(imag(pos2)))
end

instructions = readlines("d12.in")
(pos1, pos2) = move(instructions)
println("P1: ", pos1)
println("P2: ", pos2)
