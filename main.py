

import dice
from time import sleep


def roll(amount:int, sides:int):
    return dice.roll(f'{amount}d{sides}')

for idx, result in enumerate(roll(5,6)):
    print(f'Lanzamiento {idx+1} ha obtenido el número: {result}')
    sleep(5)