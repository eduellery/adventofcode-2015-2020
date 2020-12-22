function readinput(filename)
    groups = map(x -> filter(!isempty, split(x, "\n")), split(read(filename, String),"\n\n"))
    playerscards = collect(map(x -> parse(Int, x), group[2:end]) for group in groups)
    return playerscards
end

function playgame(original1, original2, recursive)
    player1 = copy(original1)
    player2 = copy(original2)
    previous = Set()
    while !isempty(player1) && !isempty(player2)
        if (player1, player2) in previous
            return (1, player1)
        end
        push!(previous, (copy(player1), copy(player2)))
        p1draw = popfirst!(player1)
        p2draw = popfirst!(player2)
        if recursive && p1draw <= length(player1) && p2draw <= length(player2)
            winner,_ = playgame(player1[1:p1draw], player2[1:p2draw], recursive)
            if winner == 1
                player1 = vcat(player1, p1draw, p2draw)
            else
                player2 = vcat(player2, p2draw, p1draw)
            end
        elseif p1draw > p2draw
            player1 = vcat(player1, p1draw, p2draw)
        else
            player2 = vcat(player2, p2draw, p1draw)
        end
    end
    if !isempty(player1)
        return (1, player1)
    else
        return (2, player2)
    end
end

function score(cards)
    score = 0
    for (i, card) in enumerate(reverse(cards))
        score += card * i
    end
    return score
end

playerscards = readinput("d22.in")
_,p1 = playgame(playerscards[1], playerscards[2], false)
println("P1: ", score(p1))
_,p2 = playgame(playerscards[1], playerscards[2], true)
println("P2: ", score(p2))
