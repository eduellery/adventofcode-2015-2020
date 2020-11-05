import re
import itertools

lines = filter(None, open('day13.in').read().split('\n'))

match = {}
people = set()

for line in lines:
    a, signal, number, b = re.findall(r'(\w+) \w+ (\w+) (\d+) .* (\w+)\.', line)[0]
    match[a + b] = int(number) * (1 if signal == 'gain' else -1)
    people.add(a)

def cost(p):
    size = len(p)
    gain = 0
    for i in range(size):
        gain += match[p[i] + p[i-1]]
        gain += match[p[i] + p[(i+1) % size]]
    return gain

print('P1:',max([cost(p) for p in itertools.permutations(people)]))

for person in people:
    match[person + 'me'] = 0
    match['me' + person] = 0

people.add('me')

print('P2:',max([cost(p) for p in itertools.permutations(people)]))
