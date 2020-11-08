import intcode

values = list(map(int,(open('d02.in').read().split(','))))

opcodes, _ = intcode.IntCode().compute(values.copy(), 12, 2)
P1 = opcodes[0]

for noun in range(100):
    for verb in range(100):
        r, _ = intcode.IntCode().compute(values.copy(), noun, verb)
        if r[0] == 19690720:
            P2 = 100 * noun + verb
            break

print('P1:', P1)
print('P2:', P2)
