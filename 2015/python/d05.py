import re

lines = open('d05.in').read().split()

# Lazy thinking...

nice = 0

for line in lines:
    vowels = 0
    duplicates = 0
    forbidden = 0
    prev = None 
    for char in line.strip():
        if char in ['a', 'e', 'i', 'o', 'u']:
            vowels += 1
        if char is prev:
            duplicates += 1
        if prev == 'a' and char == 'b':
            forbidden +=1
        elif prev == 'c' and char == 'd':
            forbidden += 1
        elif prev == 'p' and char == 'q':
            forbidden += 1
        elif prev == 'x' and char == 'y':
            forbidden += 1
        prev = char
    if forbidden == 0 and duplicates > 0 and vowels >= 3:
        nice += 1

print('P1:', nice)

# Smart way...

verynice = 0

for line in lines:
    if re.findall(r'([a-z]{2}).*\1', line) and re.findall(r'([a-z]).\1', line):
        verynice += 1

print('P2:', verynice)
