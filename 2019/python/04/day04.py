P1 = []
for number in range(138241,674035):
    string = str(number)
    if (list(string) == sorted(string)):
        for digit in string:
            count = string.count(digit)
            if count >= 2:
                P1.append(string)
                break

print('P1:', len(P1))
