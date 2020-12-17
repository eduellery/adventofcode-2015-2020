import re

input = open('d15.in').read()
lines = filter(None, input.split('\n'))

regex = r'^(\w+): capacity ([-\d]+), durability ([-\d]+), flavor ([-\d]+), texture ([-\d]+), calories ([-\d]+)$'

ingredients = []
capacities = []
durabilities = []
flavors = []
textures = []
calorieses = []

for i, line in enumerate(lines):
    ingredient, capacity, durability, flavor, texture, calories = re.findall(regex, line)[0]
    ingredients.append(ingredient)
    capacities.append(int(capacity))
    durabilities.append(int(durability))
    flavors.append(int(flavor))
    textures.append(int(texture))
    calorieses.append(int(calories))

score = 0
p1 = 0
p2 = 0

for i in range(0,100):
    for j in range(0,100-i):
        for k in range(0,100-i-j):
            l = 100-i-j-k
            capacity = capacities[0]*i+capacities[1]*j+capacities[2]*k+capacities[3]*l
            durability = durabilities[0]*i+durabilities[1]*j+durabilities[2]*k+durabilities[3]*l
            flavor = flavors[0]*i+flavors[1]*j+flavors[2]*k+flavors[3]*l
            texture = textures[0]*i+textures[1]*j+textures[2]*k+textures[3]*l
            calories = calorieses[0]*i+calorieses[1]*j+calorieses[2]*k+calorieses[3]*l
            if capacity <= 0 or durability <= 0 or flavor <= 0 or texture <= 0:
                score = 0
                continue
            score = capacity*durability*flavor*texture
            if score > p1:
                p1 = score
            if score > p2 and calories == 500:
                p2 = score

print("P1:", p1)
print("P2:", p2)