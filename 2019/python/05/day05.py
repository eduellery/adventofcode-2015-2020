import intcode

values = list(map(int,(open('05/day05.in').read().split(','))))

_, P1 = intcode.IntCode().compute(values.copy())

print('P1:', P1)
