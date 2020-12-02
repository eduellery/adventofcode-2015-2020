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

print("P1:", max(reindeers.values()))
