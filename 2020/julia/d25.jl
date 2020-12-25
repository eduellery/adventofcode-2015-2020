function transform(value, subject)
    value *= subject
    value %= 20201227
    return value
end

function loop(subject, loop)
    value = 1
    for i in 1:loop
        value = transform(value, subject)
    end
    return value
end

function bail(subject, bail)
    value, loop = 1, 0
    while bail != value
        loop += 1
        value = transform(value, subject)
    end
    return loop
end

# println(loop(5764801, bail(7, 17807724)) == 14897079) # test
println("P1: ", loop(19774466, bail(7, 7290641)))
println("P2: resort deposit")
