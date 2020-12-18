function tokenize(line)
    (if all(isdigit, m.match); parse(Int, m.match) else Symbol(m.match) end for m in eachmatch(r"[0-9]+|[^ ]", line))
end

function postfix(tokens, precedence = false)
    ops = Symbol[]
    rpn = Union{Symbol,Int}[]
    for t in tokens
        if t isa Integer
            push!(rpn, t)
        elseif t in (:+, :*)
            while !isempty(ops) && ops[end] != Symbol("(")
                if precedence && t == :+ && ops[end] == :*
                    break
                end
                push!(rpn, pop!(ops))
            end
            push!(ops, t)
        elseif t == Symbol("(")
            push!(ops, t)
        elseif t == Symbol(")")
            op = pop!(ops)
            while op != Symbol("(")
                push!(rpn, op)
                op = pop!(ops)
            end
        end
    end
    while !isempty(ops)
        push!(rpn, pop!(ops))
    end
    return rpn
end

function evaluate(rpn)
    stack = Int[]
    for t in rpn
        if t isa Integer
            push!(stack, t)
        elseif t == :+
            push!(stack, pop!(stack) + pop!(stack))
        elseif t == :*
            push!(stack, pop!(stack) * pop!(stack))
        end
    end
    return first(stack)
end

function shuntingyard(tokens; precedence = false)
    rpn = postfix(tokens, precedence)
    return evaluate(rpn)
end

lines = readlines("d18.in")
tokens = [tokenize(line) for line in lines]

p1 = map(t -> shuntingyard(t), tokens)
p2 = map(t -> shuntingyard(t; precedence=true), tokens)

println("P1: ", sum(p1))
println("P2: ", sum(p2))
