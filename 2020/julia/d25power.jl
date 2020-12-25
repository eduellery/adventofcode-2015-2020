const MOD = 20201227

function root(value)
    for i in 1:10^9
        if powermod(7, i, MOD) == value
            return i
        end
    end
end

# println(powermod(5764801, root(17807724), MOD) == 14897079) # test
println("P1: ", powermod(19774466, root(7290641), MOD))
println("P2: resort deposit")
