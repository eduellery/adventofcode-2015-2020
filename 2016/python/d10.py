import re, collections

bot = collections.defaultdict(list)
output = collections.defaultdict(list)

values = open('d10.in').read().splitlines()

pipeline = {}

for value in values:
    if value.startswith('value'):
        n, b = map(int, re.findall(r'-?\d+', value))
        bot[b].append(n)
    elif value.startswith('bot'):
        who, n1, n2 = map(int, re.findall(r'-?\d+', value))
        t1, t2 = re.findall(r' (bot|output)', value)
        pipeline[who] = (t1, n1), (t2, n2)


while bot:
    for k, v in dict(bot).items():
        if len(v) == 2:
            v1, v2 = sorted(bot.pop(k))
            if v1 == 17 and v2 == 61:
                p1 = k
            (t1, n1), (t2, n2) = pipeline[k]
            eval(t1)[n1].append(v1)
            eval(t2)[n2].append(v2)


a, b, c = (output[k][0] for k in [0, 1, 2])
p2 = a * b * c

print('P1:', p1)
print('P2:', p2)
