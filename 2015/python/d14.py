import re
import itertools
import collections

input = open('d14.in').read()
lines = filter(None, input.split('\n'))

reindeers = {}
history = {}
total_duration = 2503
regex = r'(\w+) .* (\d+) .* (\d+) .* (\d+) \w+\.'

for line in lines:
    reindeer, speed, duration, rest = re.findall(regex, line)[0]
    cycle = int(duration) + int(rest)
    amount = 0
    distance = 0
    while amount < total_duration:
        if amount % cycle < int(duration):
            distance += int(speed)
        amount += 1
    reindeers[reindeer] = distance
    steps = itertools.cycle([int(speed)]*int(duration) + [0]*int(rest))
    history[reindeer] = list(itertools.accumulate(next(steps) for _ in range(total_duration)))

scored = [i for a in zip(*history.values()) for i, v in enumerate(a) if v==max(a)]

print("P1:", max(reindeers.values()))
print("P2:", max(collections.Counter(scored).values()))
