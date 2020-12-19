from collections import defaultdict

input = open('d17.in').read()
dimensions = [int(x) for x in filter(None, input.split('\n'))]

dist = defaultdict(int)
for mask in range(1, 1<<len(dimensions)):
    p = [d for i,d in enumerate(dimensions) if (mask & (1 << i)) > 0]
    if sum(p) == 150:
        dist[len(p)] += 1

print('P1:', sum(dist.values()))
print('P2:', dist[min(dist.keys())])