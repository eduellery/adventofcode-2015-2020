import re

values = open('day11.in').read().splitlines()

p1 = [0, 0, 0, 0]
i = 0

for value in values:
    p1[i] = len(re.findall(r'(generator|microchip)', value))
    i += 1

p2 = p1[:]
p2[0] += 4

def count_moves(items):
    moves = 0
    while items[-1] != sum(items):
        base_floor = 0
        while items[base_floor] == 0:
            base_floor += 1
        moves += 2 * (items[base_floor] - 1) - 1
        items[base_floor + 1] += items[base_floor]
        items[base_floor] = 0
    return moves


print('P1:', count_moves(p1))
print('P2:', count_moves(p2))
