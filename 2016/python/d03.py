values = open('d03.in').read().splitlines()

def count_triangles(values):
    triangles = 0
    for value in values:
        sides = sorted(int(x) for x in value.split())
        if sides[0] + sides[1] > sides[2]:
            triangles += 1
    return triangles

print('P1:', count_triangles(values))

new_values = list()

i = 0
a = b = c = ''
new_values = list()

for value in values:
    i += 1
    x, y, z = value.split()
    a += x + ' '
    b += y + ' '
    c += z + ' '
    if i % 3 == 0:
        new_values.extend([a, b, c])
        a = b = c = '' 

print('P2:', count_triangles(new_values))
