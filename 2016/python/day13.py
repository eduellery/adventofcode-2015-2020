puzzle_input = 1352

frontier = [(1, 1, 0)]
seen = {}

def get_sum(pair):
    num = pair[0] * pair[0] + 3 * pair[0] + 2 * pair[0] * pair[1] + pair[1] + pair[1] * pair[1] + puzzle_input
    return bin(num).count('1')

def get_wall(pair):
    inside = pair[0] >= 0 and pair[1] >= 0
    return get_sum(pair) % 2 == 0 and inside

def get_next(pair):
    coord = [(0, 1), (0, -1), (1, 0), (-1, 0)]
    path = []
    for x in coord:
        if get_wall((x[0] + pair[0], x[1] + pair[1])):
            path.append((x[0] + pair[0], x[1] + pair[1], pair[2] + 1))
    return path

while len(frontier) > 0:
    new = frontier.pop()
    seen[(new[0], new[1])] = new[2]
    frontier += [x for x in get_next(new) if not (x[0], x[1]) in seen or seen[(x[0], x[1])] > x[2]]

print('P1:', seen[31, 39])
print('P2:', len([seen[x] for x in seen.keys() if seen[x] <= 50]))

#def is_open(x, y):
#    bin_sum = bin(x*x + 3*x + 2*x*y + y + y*y + puzzle_input)
#    return bin_sum.count('1')

#print('  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9')
#for y in range(40):
#    print(str(y % 10), '', end='')
#    for x in range(40):
#        v = '. ' if is_open(x, y) % 2 == 0 else '# '
#        print(v, end='')
#    print()
