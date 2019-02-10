original = str(1321131112).strip()

def replace(value, permutations):
    for i in range(permutations):
        result = ''
        current = 'deadbeef'
        count = 0
        for x in value:
            if x != current:
                if current != 'deadbeef':
                    result += str(count) + str(current)
                current = x
                count = 0
            count += 1
        result += str(count) + str(current)
        value = result
    return result

result_p1 = replace(original, 40)
print('P1:', len(result_p1))

result_p2 = replace(result_p1, 10)
print('P2:',len(result_p2))
