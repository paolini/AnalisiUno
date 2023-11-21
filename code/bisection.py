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
print("solution to x^2 = 2: x={:.101}".format(x))

x = bisection(lambda x: x*x-3, Decimal(0), Decimal(2), digits=100)
print("solution to x^2 = 3: x={:.101}".format(x))

x = bisection(lambda x: x*x-x-1, Decimal(0), Decimal(2), digits=100)
print("solution to x^2 = x+1: x={:.101}".format(x))

x = bisection(lambda x: x*x*x*x*x - x - 1,
    Decimal(0), Decimal(2), digits=100)
print("solution to x^5 - x = 1: x={:.100}".format(x))

# expected output:
#
# solution to x^2 = 2: x=1.4142135623730950488016887242096980785696718753769480731766797379907324784621070388503875343276415727
# solution to x^2 = 3: x=1.7320508075688772935274463415058723669428052538103806280558069794519330169088000370811461867572485757
# solution to x^2 = x+1: x=1.6180339887498948482045868343656381177203091798057628621354486227052604628189024497072072041893911375
# solution to x^5 - x = 1: x=1.167303978261418684256045899854842180720560371525489039140082449275651903429527053180685205049728673
