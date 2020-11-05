from json import loads

json = open('d12.in').read()

def find(i, filter_red = False):
    if type(i) == int:
        return i
    if type(i) == list:
        return sum([find(i, filter_red) for i in i])
    if type(i) != dict:
        return 0
    if filter_red:
        if ('red' in i.values()):
            return 0
    return find(list(i.values()), filter_red)

print('P1:',find(loads(json)))
print('P2:',find(loads(json), True))
