valuesa, valuesb = list(open('d03.in').read().split())

dx = {'R': 1, 'L': -1, 'U': 0, 'D': 0}
dy = {'R': 0, 'L': 0, 'U': 1, 'D': -1}

def manhattan_dist(a, b):
    return int(abs(a) + abs(b)) 

def collect(path):
    x, y, length = 0, 0, 0
    points = {}
    for segment in path:
        direction = segment[0]
        distance = int(segment[1:])
        assert direction in dx.keys()
        for _ in range(distance):
            x += dx[direction]
            y += dy[direction]
            length += 1
            if (x, y) not in points:
                points[(x, y)] = length
    return points

patha, pathb = [collect(i.split(',')) for i in [valuesa, valuesb]]
intersections = set(patha.keys()) & set(pathb.keys())

P1 = min(manhattan_dist(x, y) for (x, y) in intersections)
P2 = min(patha[i] + pathb[i] for i in intersections)

print('P1:', P1)
print('P2:', P2)
