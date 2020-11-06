from collections import Counter

values = open('d06.in').read().splitlines()

count = [Counter(x).most_common() for x in zip(*values)]

print('P1:',''.join(x[0][0] for x in count))
print('P2:',''.join(x[-1][0] for x in count))
