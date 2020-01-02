P1 = set()
P2 = set()
for number in range(138241,674035):
    string = str(number)
    if (list(string) == sorted(string)):
        for digit in string:
            count = string.count(digit)
            if count == 2:
                P2.add(string)
                P1.add(string)
                break
            elif count > 2:
                P1.add(string)

print('P1:', len(P1))
print('P2:', len(P2))
