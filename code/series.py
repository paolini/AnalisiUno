"""
Compute the sum of the series: 1/k^2 up to
a given error
"""

err = 0.5E-6 # error below the sixth decimal place
S = 0.0
k = 1
while k < 1/err:
  S += 1.0/k**2
  k += 1
print("somma della serie 1/k^2: {:.7}".format(S))
