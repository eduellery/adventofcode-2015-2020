function readinput(filename)
    (rules, messages) = split(read(filename, String), "\n\n")
    ruledict = Dict()
    for group in eachmatch(r"(\d+): (.*)", rules)
        ruledict[group[1]] = group[2]
    end
    return ruledict, split(messages)
end

function parserule(ruledict, target)
    targetrules = ruledict[target]
    if occursin(r"[ab]", targetrules)
        return strip(targetrules, '\"')
    end
    for rule in eachmatch(r"(\d+)", targetrules)
        targetrules = replace(
            targetrules,
            rule[1] => parserule(ruledict, rule[1]);
            count = 1
        )
    end
    if occursin("|", targetrules)
        return "($targetrules)"
    else
        return targetrules
    end
end

function makeregex(rules, target)
    rule = replace(parserule(rules, target), " " => "")
    Regex("^$rule\$")
end

(rules, messages) = readinput("d19.in")
rule = makeregex(rules, "0")
println("P1: ", count(i->!isnothing(match(rule, i)), messages))

function repeat(ruledict, target)
    rule = ruledict[target]
    template = rule
    for i in 1:2
        rule = replace(rule, target => "($rule)")
    end
    replace(rule, "($template)"=>split(template, "|")[1])
end

rules["8"] = "42 | 42 8" # original
rules["8"] = "42 | 42 (42)+" # no self-reference
rules["11"] = "42 31 | 42 11 31" # original
rules["11"] = repeat(rules, "11") # no self-reference

rule = makeregex(rules, "0")
println("P2: ", count(i->!isnothing(match(rule, i)), messages))
