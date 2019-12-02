values = list(map(int,(open('day02.in').read().split(','))))

def compute_p_zero(noun, verb, opcodes):
    opcodes[1] = noun
    opcodes[2] = verb
    i = 0
    while True:
        opcode = opcodes[i]
        i1, i2, i3 = [opcodes[x] for x in [i+1, i+2, i+3]]
        if opcode == 1:
            opcodes[i3] = opcodes[i1] + opcodes[i2]
        elif opcode == 2:
            opcodes[i3] = opcodes[i1] * opcodes[i2]
        else:
            assert opcode == 99
            break
        i += 4
    return opcodes[0]

P1 = compute_p_zero(12, 2, values.copy())

for noun in range(100):
    for verb in range(100):
        r = compute_p_zero(noun, verb, values.copy())
        if r == 19690720:
            P2 = str(noun) + str(verb)
            break

print('P1:', P1)
print('P2:', P2)
