from math import *
deg = pi / 180 # deg = 1 grado (in radianti)
min = deg / 60 # min = 1 minuto (in radianti)

d = 9 # calcoliamo la tavola dei 9 gradi

daM = 10**7 # i numeri sono moltiplicati per 10 milioni
for m in range(31): # m = minuti da 0 a 30
    x = d*deg + m*min
    print("{:2} {:7} {:7} {:7} {:7} {:7} {:2}".format(
        m,
        round(sin(x)*daM),
        round(-log(sin(x))*daM),
        round(-(log(sin(x))-log(cos(x)))*daM),
        round(-log(cos(x))*daM),
        round(cos(x)*daM),
        60-m
    ))
