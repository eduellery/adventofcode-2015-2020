import hashlib

for i in range(10000000):
    m = hashlib.md5(('iwrupvqb'+str(i)).encode('utf-8'))
    if m.hexdigest().startswith('00000'):
        print('P1:', i)
        break

for j in range(10000000):
    m = hashlib.md5(('iwrupvqb'+str(j)).encode('utf-8'))
    if m.hexdigest().startswith('000000'):
        print('P2:', j)
        break
