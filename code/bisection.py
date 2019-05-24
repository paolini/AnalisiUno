def bisection(f, a, b, err=0.5E-7):
    fa = f(a)
    fb = f(b)
    assert fb*fa <= 0
    while b-a > err:
        c = (a+b)/2
        fc = f(c)
        if fc*fa < 0:
            b = c
            fb = fc
        else:
            a = c
            fa = fc
    return (a+b)/2

def x2_minus_2(x):
    return x*x - 2.0

def x5_minus_x_minus_1(x):
    return x*x*x*x*x - x - 1.0

x = bisection(x2_minus_2, 0.0, 2.0)
print("solution to x^2 = 2: {:.7}".format(x))

x = bisection(x5_minus_x_minus_1, 0.0, 2.0)
print("solution to x^5 - x = 1: {:.7}".format(x))
