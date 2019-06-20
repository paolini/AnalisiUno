from decimal import Decimal, getcontext

def compute_pi(digits):
    sum = Decimal(0)
    k = 0
    factor = Decimal(1)/2
    while 3*(2*k+1)*4**k < 4*10**digits:
        sum += factor / (2*k+1)
        factor *= Decimal(2*k+1) / (2*k+2) / 4
        k += 1
    return sum * 6

getcontext().prec = 1100  # numero di cifre da utilizzare nei calcoli
print("pi: {:.1001}".format(compute_pi(1100)))
