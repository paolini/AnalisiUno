# la libreria decimal ci permette di effettuare calcoli su numeri
# con sviluppo decimale arbitrariamente lungo
from decimal import Decimal, getcontext
def compute_e(digits):
    sum = Decimal(0)
    k = 0
    k_factorial = 1
    while k_factorial * k < 10**digits:
        sum += Decimal(1)/Decimal(k_factorial)
        k += 1
        k_factorial *= k
    return sum

getcontext().prec = 1100  # numero di cifre da utilizzare nei calcoli
print("e: {:.1001}".format(compute_e(1100)))
