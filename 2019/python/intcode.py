class IntCode:

    def compute(self, opcodes, noun=None, verb=None):
        # Legacy
        if noun:
            opcodes[1] = int(noun)
        if verb:
            opcodes[2] = int(verb)
        i = 0
        last = -1
        while True:
            digits = [int(x) for x in str(opcodes[i])]
            opcode = (0 if len(digits) == 1 else digits[-2]) * 10 + digits[-1]
            digits = digits[:-2]
            if opcode == 1:
                while len(digits) < 3:
                    digits = [0] + digits
                opcode, i1, i2, i3 = opcodes[i:i+4]
                opcodes[i3] = (i1 if digits[2] == 1 else opcodes[i1]) + (i2 if digits[1] == 1 else opcodes[i2])
                i += 4
            elif opcode == 2:
                while len(digits) < 3:
                    digits = [0] + digits
                opcode, i1, i2, i3 = opcodes[i:i+4]
                opcodes[i3] = (i1 if digits[2] == 1 else opcodes[i1]) * (i2 if digits[1] == 1 else opcodes[i2])
                i += 4
            elif opcode == 3:
                i1 = opcodes[i+1]
                opcodes[i1] = 1
                i += 2
            elif opcode == 4:
                i1 = opcodes[i+1]
                last = opcodes[i1]
                print("OUT: ", last)
                i += 2
            else:
                assert opcode == 99
                break
        return (opcodes, last)

