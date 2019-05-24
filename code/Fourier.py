from sympy import *
from sympy.plotting import plot
# se usi jupyter: %matplotlib inline

def e(k):
    """
    k-esimo elemento della base hilbertiana
    """
    k = Integer(k)
    if k == 0:
        return lambda x: 1/sqrt(2*pi)
    elif k % 2 == 0:
        return lambda x: cos(k/2 * x)/sqrt(pi)
    else:
        return lambda x: sin((k+1)/2 * x)/sqrt(pi)

def f(g):
    """
    integra g contro la funzione che vale -1
    in (-pi,0) e 1 in (0,pi)
    """
    x = symbols("x")
    return integrate(g(x), (x, 0, pi)) - integrate(g(x), (x, -pi, 0))

def fourier(f, n):
    """
    calcola l'n-esimo polinomio trigonometrico approssimante f
    """
    return lambda x: sum([f(e(k)) * e(k)(x) for k in range(n+1)])


"""
Calcola e disegna lo sviluppo di Fourier
"""
x = symbols('x')
n = 61
print("polinomio trigonometrico di ordine {}".format(n))
pol = fourier(f,n)(x)
print(pol)
fig = plot(pol, (x, -pi, pi))
fig.savefig("fourier.png", dpi=600)
