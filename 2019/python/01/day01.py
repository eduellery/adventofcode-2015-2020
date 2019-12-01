mass_list = list(open('day01.in').read().split())

base_fuel = 0
total_fuel = 0

def calculate_fuel(mass):
    return int(int(mass) / 3 - 2)

for mass in mass_list:
    fuel = calculate_fuel(mass)
    base_fuel += fuel
    while (fuel >= 0):
        total_fuel += fuel
        fuel = calculate_fuel(fuel)

print('P1:', base_fuel)
print('P2:', total_fuel)
