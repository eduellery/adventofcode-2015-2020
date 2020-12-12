function move(instructions, dir = Complex(1, 0), way = Complex(10, 1), pos = Complex(0, 0))
    pos1 = pos2 = pos
    directions = Dict([("N", Complex(0, 1)), ("S", Complex(0, -1)), ("E", Complex(1, 0)), ("W", Complex(-1, 0))])
    for instruction in instructions
        (cmd, num) = match(r"([NSEWLRF])([0-9]+)", instruction).captures
        val = parse(Int, num)
        if cmd == "F"
            pos1, pos2 = map(x -> x[1] += x[2] * val, [[pos1, dir], [pos2, way]])
        elseif cmd == "L"
            dir, way = map(x -> x *= Complex(0, 1)^div(val, 90), [dir, way])
        elseif cmd == "R"
            dir, way = map(x -> x *= Complex(0, -1)^div(val, 90), [dir, way])
        else
            pos1, way = map(x -> x += val * get(directions, cmd, nothing), [pos1, way])
        end
    end
    return map(x -> abs(real(x)) + abs(imag(x)), [pos1, pos2])
end

instructions = readlines("d12.in")
(pos1, pos2) = move(instructions)
println("P1: ", pos1)
println("P2: ", pos2)
