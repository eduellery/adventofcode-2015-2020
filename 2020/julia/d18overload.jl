⊗(x,y)=x+y
⊕(x,y)=x*y
lines = readlines("d18.in")
linesp1 = replace.(lines, "*"=>"⊕")
linesp2 = replace.(linesp1, "+"=>"⊗")
results1 = @. eval(Meta.parse(linesp1))
results2 = @. eval(Meta.parse(linesp2))
println("P1: ", sum(results1))
println("P2: ", sum(results2))
