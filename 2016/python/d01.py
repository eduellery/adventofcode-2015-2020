values = open('d01.in').read().replace('\n', '').split(', ')

position = 0 + 0j
direction = 0 + 1j

seen = {position}
found = None

def man_distance(a, b):
    return int(abs(a) + abs(b))

for value in values:
    if value[0] =='R':
        direction *= -1j
    else:
        direction *= 1j
    
    distance = int(value[1:])
    
    for i in range(distance):
        position += direction
        if not found and position in seen:
            found = position
        seen.add(position)

print('P1:', man_distance(position.real, position.imag))
print('P2:', man_distance(found.real, found.imag) if found is not None else None)
