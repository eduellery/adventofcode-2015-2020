class IntCode:

    def compute(self, noun, verb, opcodes):
        opcodes[1] = noun
        opcodes[2] = verb
        i = 0
        while True:
            opcode, i1, i2, i3 = opcodes[i:i+4]
            if opcode == 1:
                opcodes[i3] = opcodes[i1] + opcodes[i2]
            elif opcode == 2:
                opcodes[i3] = opcodes[i1] * opcodes[i2]
            else:
                assert opcode == 99
                break
            i += 4
        return opcodes[0]

