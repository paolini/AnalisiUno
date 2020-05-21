"""
Calcola la somma della serie 1/k^2 con un errore prefissato
"""

err = 0.5E-6 # errore al di sotto della sesta cifra decimale
S = 0.0
k = 1
while k < 1/err:
  S += 1.0/k**2
  k += 1
print("somma della serie 1/k^2: {:.7}".format(S))
