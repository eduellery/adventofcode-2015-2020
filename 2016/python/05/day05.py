import hashlib

i = 0
result1 = ''
result2 = [None] * 8
seed = 'ugkcyxxp'

while None in result2:
    digest = hashlib.md5((seed+str(i)).encode('utf-8')).hexdigest()
    if digest.startswith('00000'):
        value = digest[5]
        result1 += value
        location = int(value, 16)
        if 0 <= location <= 7 and result2[location] is None:
            result2[location] = digest[6]
    i += 1

print('P1:', result1[0:8])
print('P2:', ''.join(result2))
