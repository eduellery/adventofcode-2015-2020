lines = open('day02.in').read().split()

total = 0
for line in lines:
    x, y, z = sorted(map(int, line.split('x')))
    total += 2 * (x * y + x * z + y * z) + x * y

print('P1:', total)
