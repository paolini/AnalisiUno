def wallis(err):
    prod = 2.0
    k = 1
    N = 1/err
    while k < N:
        prod *= ((2*k)**2)/((2*k-1.0)*(2*k+1.0))
        k += 1
    return prod

print("pi: {:.7}".format(wallis(0.5E-7)))
