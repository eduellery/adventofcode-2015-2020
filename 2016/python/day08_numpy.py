import re, numpy as np

values = open('day08.in').read().splitlines()

grid = np.zeros((6, 50), dtype=bool)

for value in values:
    block = re.split(r'[ =]', value)
    if block[0] == 'rect':
        w, h = map(int, block[1].split('x'))
        grid[:h, :w] = 1
    elif block[0] == 'rotate':
        if block[1] == 'row':
            x, shift = int(block[3]), int(block[5])
            grid[x] = np.roll(grid[x], shift)
        else:
            y, shift = int(block[3]), int(block[5])
            grid[:,y] = np.roll(grid[:,y], shift)

p1 = np.sum(grid)

print('P1:', p1)

p2 = '\n'+('\n'.join(''.join('@' if v else ' '  for v in row) for row in grid))

print('P2:', p2)
