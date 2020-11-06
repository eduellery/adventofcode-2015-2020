values = open('d08.in').read().splitlines()

h, w = 6, 50
grid = [[0] * w for _ in range(h)]

for value in values:
    if value.startswith('rect'):
        x, y = map(int, value.split('rect ')[1].split('x'))
        for a in range(y):
            for b in range(x):
                grid[a][b] = 1
    elif value.startswith('rotate column'):
        x, vshift = map(int, value.split('rotate column x=')[1].split(' by '))
        column = [row[x] for row in grid]
        for a in range(h):
            grid[a][x] = column[a - vshift]
    elif value.startswith('rotate row'):
        y, hshift = map(int, value.split('rotate row y=')[1].split(' by '))
        grid[y] = grid[y][-hshift:] + grid[y][:-hshift]
        
p1 = sum(sum(line) for line in grid)

print('P1:', p1)

p2 = '\n'+('\n'.join(''.join('#' if v else ' '  for v in row) for row in grid))

print('P2:', p2)
