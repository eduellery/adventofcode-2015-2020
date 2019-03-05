values = open('day09.in').read().strip()

def len_decompress(val, rec):
    if '(' not in val:
        return len(val)
    ret = 0
    while '(' in val:
        ret += val.find('(')
        val = val[val.find('('):]
        pre, pos = map(int, val[1:val.find(')')].split('x'))
        val = val[val.find(')') + 1:]
        if rec:
            ret += len_decompress(val[:pre], rec) * pos 
        else:
            ret += len(val[:pre]) * pos
        val = val[pre:]
    ret += len(val)
    return ret

print('P1:', len_decompress(values, False))
print('P2:', len_decompress(values, True))    
