def bisection(f, a, b, digits=7):
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
getcontext().prec = 1100  # numero di cifre da utilizzare nei calcoli

def x2_minus_2(x):
    return x*x - 2

x = bisection(x2_minus_2, Decimal(0), Decimal(2), digits=1100)
print("solution to x^2 = 2: {:.1001}".format(x))

def x5_minus_x_minus_1(x):
    return x*x*x*x*x - x - 1

x = bisection(x5_minus_x_minus_1, Decimal(0), Decimal(2), digits=110)
print("solution to x^5 - x = 1: {:.100}".format(x))
