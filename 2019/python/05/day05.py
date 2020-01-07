import intcode

values = list(map(int,(open('05/day05.in').read().split(','))))

_, P1 = intcode.IntCode().compute(values.copy())
_, P2 = intcode.IntCode().compute(values.copy(), system_id = 5)

print('P1:', P1)
print('P2:', P2)
