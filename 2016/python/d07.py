import re

values = open('d07.in').read().splitlines()

p1 = 0;

for value in values:
    hypernet = False
    for inside in re.findall(r'\[(.*?)\]', value): # text inside brackets
        if re.search(r'(?!(\w)\1\1\1)(\w)(\w)\3\2', inside): # pair of chars followed by reversal
            hypernet = True
    if not hypernet:
        for outside in re.findall(r'(.*?)(?:\[.*?\]|$)', value): # text outside brackets
            if re.search(r'(?!(\w)\1\1\1)(\w)(\w)\3\2', outside): # pair of chars followed by reversal
                p1 += 1
                break

p2 = 0

for value in values:
    for outside in re.findall(r'(.*?)(?:\[.*?\]|$)', value): # text outside brackets
        stop = False
        for a, b in re.findall(r'(?=(?=(.)(?!\1)(.)\1))', outside): # overlapping 'aba'
            for inside in re.findall(r'\[(.*?)\]', value): # text inside brackets
                if re.search(b+a+b, inside): # bab from my aba :)
                    p2 += 1
                    stop = True
            if stop:
                break
        if stop:
            break

print('P1:', p1)
print('P2:', p2)
