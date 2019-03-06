values = open('day09.in').read().strip()

i, p1 = 0, 0
size = len(values)

while i < size:
    if values[i] is '(':
        amount, rest = values[i+1:].split('x', 1)
        times = rest.split(')', 1)[0]
        i += 3 + len(times) + len(amount) + int(amount)
        p1 += int(times) * int(amount)
    else:
        p1 += 1
        i += 1

print('P1:', p1)

count = [1] * size
i, p2 = 0, 0

while i < size:
    if values[i] is '(':
        amount, rest = values[i+1:].split('x', 1)
        times = rest.split(')', 1)[0]
        i += 3 + len(times) + len(amount)
        for k in range(i, i + int(amount)):
            count[k] *= int(times)
    else:
        p2 += count[i]
        i += 1

print('P2:', p2)
