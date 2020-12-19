def check(types, value, part2=False):
    value = int(value)
    if part2:
        if types == 'cats' or types == 'trees':
            return props[types] < value
        elif types == 'pomeranians' or types == 'goldfish':
            return props[types] > value
    return props[types] == value

props = {}
props['children'] = 3
props['cats'] = 7
props['samoyeds'] = 2
props['pomeranians'] = 3
props['akitas'] = 0
props['vizslas'] = 0
props['goldfish'] = 5
props['trees'] = 3
props['cars'] = 2
props['perfumes'] = 1

input = open('d16.in').read()
lines = filter(None, input.split('\n'))

P1, P2 = 0, 0

for line in lines:
    line = line.replace(':','').strip('\n').split(' ')
    if (check(line[2], line[3].strip(',')) and check(line[4], line[5].strip(',')) and check(line[6], line[7])):
        P1 = line[1]
    if (check(line[2], line[3].strip(','), True) and check(line[4], line[5].strip(','), True) and check(line[6], line[7], True)):
        P2 = line[1]

print("P1:", P1)
print("P2:", P2)