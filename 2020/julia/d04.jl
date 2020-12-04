using DelimitedFiles

lines = readlines("d04.in")
append!(lines, [""])

P1 = 0
P2 = 0

function lenientvalid(passport)
    valid = true
    for field in ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
        if !haskey(passport, field)
            valid = false
        end
    end
    return valid
end

function strictvalid(passport)
    valid = true
    if !(1920 <= parse(Int64, get(passport, "byr", "")) <= 2002)
        valid = false
    end
    if !(2010 <= parse(Int64, get(passport, "iyr", "")) <= 2020)
        valid = false
    end
    if !(2020 <= parse(Int64, get(passport, "eyr", "")) <= 2030)
        valid = false
    end
    hgt = get(passport, "hgt", "999cm")
    if endswith(hgt,"cm")
        if !(150 <= parse(Int64, hgt[1:end-2]) <= 193)
            valid = false
        end
    elseif endswith(hgt,"in")
        if !(59 <= parse(Int64, hgt[1:end-2]) <= 76)
            valid = false
        end
    else
        valid = false
    end
    if match(r"#[0-9a-f]{6}$", get(passport, "hcl", "NOT")) === nothing
        valid = false
    end
    if !(get(passport, "ecl", "NOT") in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
        valid = false
    end
    if match(r"^[0-9]{9}$", get(passport, "pid", "NOT")) === nothing
        valid = false
    end
    return valid
end

passport = Dict()
for line in lines
    if line == ""
        if lenientvalid(passport)
            global P1 += 1
            if strictvalid(passport)
                global P2 += 1
            end
        end
        global passport = Dict()
    else
        words = split(line)
        for word in words
            k, v = split(word, ':')
            global passport[k] = v
        end
    end
end

println("P1: ", P1)
println("P2: ", P2)
