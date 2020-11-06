import re, collections, string

values = open('d04.in').read()

def caesar_cipher(shift):
    az = string.ascii_lowercase
    nshift = shift % len(az)
    return str.maketrans(az, az[nshift:] + az[:nshift])

p1 = 0
p2 = None

for encoded, sid, checksum in re.findall(r'([a-z-]+)(\d+)\[(\w+)\]', values):
    sid = int(sid)
    letters = ''.join(c for c in encoded if c in string.ascii_lowercase)
    most = [(-n,c) for c,n in collections.Counter(letters).most_common()]
    result = ''.join(c for n,c in sorted(most))
    if result.startswith(checksum):
        p1 += sid
        decoded = encoded.translate(caesar_cipher(sid))
        if 'north' in decoded:
            p2 = sid

print('P1:', p1)
print('P2:', p2)
