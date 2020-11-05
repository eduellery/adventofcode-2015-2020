import re

lines = open('day06.in').read().split('\n')

lights = {}
x, y = 0, 0
for x in range(1000):
    for y in range(1000):
        lights[x,y] = 'Off'

for line in lines:
    instructions = re.findall(r'(toggle|turn on|turn off)\s(\d*),(\d*)\sthrough\s(\d*),(\d*)', line)
    for action, x1, y1, x2, y2 in instructions:
        coords = [(x, y) for x in range(int(x1), int(x2)+1) for y in range(int(y1), int(y2)+1)]
        if action == 'turn on':
            for x, y in coords:
                lights[x,y] = 'On'
        elif action == 'turn off':
            for x, y in coords:
                lights[x,y] = 'Off'
        elif action == 'toggle':
            for x, y in coords:
                if lights[x,y] is 'On':
                    lights[x,y] = 'Off'
                else:
                    lights[x,y] = 'On'

on = 0
for x in range(1000):
    for y in range(1000):
        if lights[x,y] is 'On':
            on += 1

print('P1:', on)
           
lights = {}
x, y = 0, 0
for x in range(1000):
    for y in range(1000):
        lights[x,y] = 0

for line in lines:
    instructions = re.findall(r'(toggle|turn on|turn off)\s(\d*),(\d*)\sthrough\s(\d*),(\d*)', line)
    for action, x1, y1, x2, y2 in instructions:
        coords = [(x, y) for x in range(int(x1), int(x2)+1) for y in range(int(y1), int(y2)+1)]
        if action == 'turn on':
            for x, y in coords:
                lights[x,y] += 1
        elif action == 'turn off':
            for x, y in coords:
                if lights[x,y] > 0:
                    lights[x,y] -= 1
        elif action == 'toggle':
            for x, y in coords:
                lights[x,y] += 2

brightness = 0
for x in range(1000):
    for y in range(1000):
        brightness += lights[x,y]

print('P2:', brightness)
