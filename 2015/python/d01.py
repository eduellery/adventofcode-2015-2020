chars = list(open('d01.in').read())

count = 0
index = 0
basementIndex = 0

for c in chars:
    index +=1
    if c == '(':
        count += 1
    elif c == ')':
        count -= 1
    if basementIndex == 0 and count == -1:
        basementIndex = index

print('P1:', count)
print('P2:', basementIndex)
