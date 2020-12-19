from itertools import combinations

def count_combinations(sizes, target):
    dp = [1] + [0] * (target)
    for cur in sizes:
        for next in range(target, cur-1, -1):
            dp[next] += dp[next - cur]
    return dp[target]


def count_minimal_combinations(sizes, target):
    ans = 0
    for k in range(1, len(sizes) + 1):
        for c in combinations(sizes, k):
            if sum(c) == target:
                ans+=1
        if ans:
            break
    return ans

input = open('d17.in').read()
lines = [int(x) for x in filter(None, input.split('\n'))]

print('P1:', count_combinations(lines, 150))
print('P2:', count_minimal_combinations(lines, 150))
