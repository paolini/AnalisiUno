def bisection(f, a, b, digits=10):
    fa = f(a)
    fb = f(b)
    assert fb*fa <= 0
    while 2 * 10**digits * (b-a) > 1:
        c = (a+b)/2
        fc = f(c)
        if fc*fa < 0:
            b = c
            fb = fc
        else:
            a = c
            fa = fc
    return (a+b)/2

# la libreria decimal ci permette di effettuare calcoli su numeri
# con sviluppo decimale arbitrariamente lungo
from decimal import Decimal, getcontext
getcontext().prec = 110  # numero di cifre da utilizzare nei calcoli

# l'operatore lambda permette di definire una
# funzione senza dovergli dare un nome

x = bisection(lambda x: x*x-2, Decimal(0), Decimal(2), digits=100)
print("solution to x^2 = 2 {:.101}".format(x))

x = bisection(lambda x: x*x-3, Decimal(0), Decimal(2), digits=100)
print("solution to x^2 = 3: {:.101}".format(x))

x = bisection(lambda x: x*x-x-1, Decimal(0), Decimal(2), digits=100)
print("solution to x^2 = x+1: {:.101}".format(x))

x = bisection(lambda x: x*x*x*x*x - x - 1,
    Decimal(0), Decimal(2), digits=100)
print("solution to x^5 - x = 1: {:.100}".format(x))
