import intcode

values = list(map(int,(open('02/day02.in').read().split(','))))

P1 = intcode.IntCode().compute(12, 2, values.copy())

for noun in range(100):
    for verb in range(100):
        r = intcode.IntCode().compute(noun, verb, values.copy())
        if r == 19690720:
            P2 = 100 * noun + verb
            break

print('P1:', P1)
print('P2:', P2)
