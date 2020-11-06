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
