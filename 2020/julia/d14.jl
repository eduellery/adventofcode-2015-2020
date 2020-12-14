function readinput(values)
    return map(x -> split(x, " = "), readlines("d14.in"))
end

function masks(mask)
    and, or, x = UInt(0), UInt(0), UInt(0)
    for c in mask
        and, or, x = [and, or, x] .<<= 1
        if c == '0'
            and += 1
        elseif c == '1'
            or += 1
        else
            x += 1
        end
    end
    return (~and, or, x)
end

function allcombinations(x, floating)
    if floating == 0
        return x
    end
    i = 0
    while floating & UInt(1) == 0
        i += 1
        floating >>= 1
    end
    floating &= ~UInt(1)
    floating <<= i
    return cat(allcombinations(x, floating), allcombinations(xor(x, UInt(1)<<i), floating); dims=1)
end

function memoryallocation(instructions)
    P1, P2 = Dict(), Dict()
    and = or = x = 0
    for instruction in instructions
        cmd, val = instruction[1], instruction[2]
        if cmd == "mask"
            and, or, x = masks(val)
        else
            addr, val = parse(UInt, match(r"^mem\[(\d+)\]$", cmd)[1]), parse(UInt, val)
            P1[addr] = (val | or) & and
            for loc in allcombinations(addr | or, x)
                P2[loc] = val
            end
        end
    end
    return P1, P2
end

instructions = readinput("d14.in")
P1, P2 = memoryallocation(instructions)

println("P1: ", sum(values(P1)))
println("P2: ", sum(values(P2)))
