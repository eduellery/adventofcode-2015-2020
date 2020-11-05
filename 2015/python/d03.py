values = open('d03.in').read().strip()

houses = {}
i, j = 0, 0
houses[i,j] = 'Visited'

for value in values:
    if value == '>':
        i += 1
    elif value == '<':
        i -= 1
    elif value == '^':
        j += 1
    elif value == 'v':
        j -= 1
    houses[i,j] = 'Visited'

print('P1:', len(houses))

houses = {}
i, j, x, y, count = 0, 0, 0, 0, 0
houses[i,j] = 'Visited'

for value in values:
    if value == '>':
        if count % 2:
            i += 1
        else:
            x += 1
    elif value == '<':
        if count % 2:
            i -= 1
        else:
            x -= 1
    elif value == '^':
        if count % 2:
            j += 1
        else:
            y += 1
    elif value == 'v':
        if count % 2:
            j -= 1
        else:
            y -= 1
    houses[i, j] = 'Visited'
    houses[x, y] = 'Visited'
    count += 1

print('P2:', len(houses))
