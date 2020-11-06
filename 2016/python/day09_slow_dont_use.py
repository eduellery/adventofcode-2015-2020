values = open('day09.in').read().strip()

# If we ever need the string. Since we don't, no use for it
# Too slow, don't run it
def decompress(val, rec):
    if '(' not in val:
        return val
    ret = ''
    while '(' in val:
        ret += val[:val.find('(')]
        val = val[val.find('('):]
        pre, pos = map(int, val[1:val.find(')')].split('x'))
        val = val[val.find(')') + 1:]
        if rec:
            temp = decompress(val[:pre], rec) 
            for _ in range(pos):
                ret += temp
        else:
            for _ in range(pos):
                ret += val[:pre]
        val = val[pre:]
    ret += val
    return ret

print('P1:', len(decompress(values, False)))
print('P2:', len(decompress(values, True)))    
