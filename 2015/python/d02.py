lines = open('d02.in').read().split()

area = 0
ribbon = 0
for line in lines:
    x, y, z = sorted(map(int, line.split('x')))
    area += 2 * (x * y + x * z + y * z) + x * y
    ribbon += x + x + y + y + x * y * z

print('P1:', area)
print('P2:', ribbon)
