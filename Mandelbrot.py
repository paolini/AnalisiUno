# la libreria numerica numpy ci permette di fare velocemente
# operazioni su matrici di numeri complessi
import numpy as np

xres, yres = 6400, 4800
iterations = 40

# cx e' una suddivisione dell'intervallo [-2,1] in xres punti
cx = 3.0*np.arange(xres)/xres - 2.0
# cy e' una suddivisione dell'intervallo [-1,1] in yres punti
cy = (2.0*np.arange(yres)/yres - 1.0) * 3.0 * yres / 2.0 / xres
# c e' una matrice yres x xres contenente i numeri complessi
# con parte reale cx e parte immaginaria cy.
c = cx[np.newaxis,:] + 1j * cy[:,np.newaxis]

# z e' una matrice di numeri complessi, inizialmente nulli, su cui
# faremo l'iterazione con ognuno dei dati iniziali
# presi dalla matrice c
z = np.zeros((yres, xres), dtype=np.complex)
for n in range(iterations):
  print("{}% completed".format(n*100//iterations))
  z = z*z + c

# consideriamo l'insieme dei punti che dopo iterations iterazioni
# non sono usciti dal disco di raggio 2.
mandelbrot = np.logical_not(np.abs(z) < 2.0)

# utilizziamo la libreria scipy che ci permette di
# trasformare facilmente una matrice in una immagine
from scipy.misc import imsave
imsave('mandelbrot.png', mandelbrot)
