from copy import deepcopy

dd = [(x, y) for x in range(-1,2) for y in range(-1,2) if (x != 0 or y != 0)]

def count_neighbors(grid, r, c, size):
    count = 0
    for (x,y) in dd:
        if not ((0 <= x+r < size) and (0 <= y+c < size)):
            continue
        if grid[(r+x,c+y)] == '#':
            count+=1
    return count

def count_total(grid):
    count = 0
    for v in grid.values():
        if v == '#':
            count+=1
    return count

def next(grid, part2, size):
    new_grid = {}
    for (r,c) in grid.keys():
        n = count_neighbors(grid, r, c, size)
        if grid[(r,c)] == '#' and (n == 2 or n == 3):
            new_grid[(r,c)] = '#'
        elif grid[(r,c)] == '.' and n == 3:
            new_grid[(r,c)] = '#'
        else:
            new_grid[(r,c)] = '.'
    if part2:
        new_grid[(0,0)] = '#'
        new_grid[(0,size-1)] = '#'
        new_grid[(size-1,0)] = '#'
        new_grid[(size-1,size-1)] = '#'
    return new_grid

def cycle(grid, size, part2, steps = 100):
    while steps > 0:
        grid = next(grid, part2, size)
        steps-=1
    return grid

input = open('d18.in').read()
lines = input.split('\n')
original = {}
size = len(lines)
for row, line in enumerate(lines):
    for column, char in enumerate(line):
        original[(row,column)] = char

grid = cycle(deepcopy(original), size, False, 100)
print('P1:',count_total(grid))

original[(0,0)] = '#'
original[(0,size-1)] = '#'
original[(size-1,0)] = '#'
original[(size-1,size-1)] = '#'
grid = cycle(original, size, True, 100)
print('P2:',count_total(grid))
