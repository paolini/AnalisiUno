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
# solution to x^2 = 2: x=1.41421356237309504880168872420969807856967
#                        1875376948073176679737990732478462107038850
#                        3875343276415727
# solution to x^2 = 3: x=1.73205080756887729352744634150587236694280
#                        5253810380628055806979451933016908800037081
#                        1461867572485757
# solution to x^2 = x+1: x=1.618033988749894848204586834365638117720
#                          30917980576286213544862270526046281890244
#                          97072072041893911375
# solution to x^5 - x = 1: x=1.1673039782614186842560458998548421807
#                            205603715254890391400824492756519034295
#                            27053180685205049728673
