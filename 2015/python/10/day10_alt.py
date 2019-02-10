import re
re_d = re.compile(r'((\d)\2*)')

def replace(match_obj):
    s = match_obj.group(1)
    return str(len(s)) + s[0]

s = '1321131112'
for i in range(40):
    s = re_d.sub(replace,s)

print('P1:',len(s))

for i in range(10):
    s = re_d.sub(replace,s)

print('P2:',len(s))
