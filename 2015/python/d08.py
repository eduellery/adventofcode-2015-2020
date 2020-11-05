import re

lines = open('d08.in').read().split()

count = 0
decod = 0
encod = 0

for line in lines:
    count += len(line)
    decoded = bytes(line, "utf-8").decode("unicode_escape")
    encoded = re.escape(line)
    decod += len(decoded) - 2 # Subtract ""
    encod += len(encoded) + 2 # Add ""

print('P1:', count - decod)
print('P2:', encod - count)
