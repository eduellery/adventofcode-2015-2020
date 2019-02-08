import re

lines = open('day07.in').read().split('\n')

calc = dict()

for line in lines:
    instruction = re.findall(r'(.*)\s->\s(\w*)', line)
    for ops, register in instruction:
        calc[register] = ops.strip().split(' ')

def calculate(register):
    try:
        return int(register)
    except ValueError:
        pass

    if register not in results:
        ops = calc[register]
        if len(ops) == 1:
            res = calculate(ops[0])
        else:
            op = ops[-2]
            if op == 'AND':
              res = calculate(ops[0]) & calculate(ops[2])
            elif op == 'OR':
              res = calculate(ops[0]) | calculate(ops[2])
            elif op == 'NOT':
              res = ~calculate(ops[1]) & 0xffff
            elif op == 'RSHIFT':
              res = calculate(ops[0]) >> calculate(ops[2])
            elif op == 'LSHIFT':
              res = calculate(ops[0]) << calculate(ops[2])
        results[register] = res
    return results[register]

results = dict()
original = calculate('a')
print('P1:', original)

results = dict()
results['b'] = original
modified = calculate('a')
print('P2:', modified)
