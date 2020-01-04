import intcode

values = list(map(int,(open('02/day02.in').read().split(','))))

P1 = intcode.IntCode().compute(values.copy(), 12, 2)

for noun in range(100):
    for verb in range(100):
        r = intcode.IntCode().compute(values.copy(), noun, verb)
        if r == 19690720:
            P2 = 100 * noun + verb
            break

print('P1:', P1)
print('P2:', P2)
