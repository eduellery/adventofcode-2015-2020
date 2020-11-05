import re
import itertools

lines = filter(None, open('d09.in').read().split('\n'))

distances = {}
cities = set()

for line in lines:
    travel = re.findall(r'(.*)\sto\s(.*)\s=\s(.*)', line)
    for orig, dest, dist in travel:
        distances[orig, dest] = dist
        distances[dest, orig] = dist
        cities.add(orig)
        cities.add(dest)

minimum = 1000000000
maximum = 0

for path in itertools.permutations(cities):
    current = 0
    for i in range(1, len(path)):
        current += int(distances[path[i-1], path[i]])
    if current < minimum:
        minimum = current
    if current > maximum:
        maximum = current

print('P1:', minimum)
print('P2:', maximum)
