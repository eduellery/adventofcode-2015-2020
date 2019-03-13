values = open('day12.in').read().splitlines()

instructions = []

for value in values:
    instructions.append(value.split(' '))

def read(registers, value):
    try:
        return int(value)
    except:
        return registers[value]

def get_register(instructions, register, a = 0, b = 0, c = 0, d = 0):
    ip = 0
    
    registers = {
        'a': a,
        'b': b,
        'c': c,
        'd': d
    }

    while True:
        if ip >= len(instructions):
            break
        ins = instructions[ip]
        if ins[0] == 'cpy':
            registers[ins[2]] = read(registers, ins[1])
        elif ins[0] == 'inc':
            registers[ins[1]] += 1
        elif ins[0] == 'dec':
            registers[ins[1]] -= 1    
        elif ins[0] == 'jnz':
            if read(registers, ins[1]) != 0:                
                ip += read(registers, ins[2])
                ip -= 1
        ip += 1
    
    return registers[register]

print('P1:', get_register(instructions, 'a'))
print('P2:', get_register(instructions, 'a', c = 1))

