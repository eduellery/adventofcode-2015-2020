chars = list(open('day01.in').read())

count = 0
index = 0
basementIndex = 0

for c in chars:
    index +=1
    if c is '(':
        count += 1
    elif c is ')':
        count -= 1
    if basementIndex is 0 and count is -1:
        basementIndex = index

print('P1:', count)
print('P2:', basementIndex)
