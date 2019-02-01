chars = list(open('day01.in').read())

count = 0

for c in chars:
    if c is '(':
        count += 1
    elif c is ')':
        count -= 1

print('P1:', count)
