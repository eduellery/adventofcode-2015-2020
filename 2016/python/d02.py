values = filter(None, open('d02.in').read().split('\n'))

result1 = ''
index1 = 5

result2 = ''
index2 = 11

commands = {'U': -5, 'D': 5, 'R': 1, 'L': -1}
translate = {3: 1, 7: 2, 8: 3, 9: 4, 11: 5, 12: 6, 13: 7, 14: 8, 15: 9, 17: 10, 18: 11, 19: 12, 23: 13}


def compute(value, char):
    if char is 'U' and value not in [1, 2, 3]:
        value -= 3
    elif char is 'D' and value not in [7, 8, 9]:
        value += 3
    elif char is 'L' and value not in [1, 4, 7]:
        value -= 1
    elif char is 'R' and value not in [3, 6, 9]:
        value += 1
    return value

for value in values:
    for char in value.strip():
        index1 = compute(index1, char)
        step = commands.get(char)
        if (translate.get(index2 + step)):
            index2 += step
    result1 += str(index1)
    result2 += str("%x".upper() % translate.get(index2))

print('P1:', result1)
print('P2:', result2)
