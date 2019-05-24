import sys
from math import *

def affine_koch(t, s, iter):
    """
    t, s are affine (triangular) coordinates
    @return positive if inside, negative if outside
    """
    if t+s > 1: return 1.
    if t<=0 or s<=0: return -1.
    if 3*(t+s) < 2: return -.5
    if iter <= 0: return 0.
    if 3*s >= 2: return affine_koch(3*t, 3*s-2, iter-1)
    if 3*t >= 2: return affine_koch(3*t-2, 3*s, iter-1)
    if 3*t <= 1: return affine_koch(3*t-2+3*s, 2-3*s, iter-1)
    return affine_koch(2-3*t,3*s-2+3*t, iter-1)

RAD_3 = sqrt(3)

def koch(x, y, iter):
  return affine_koch(1 - x - y/RAD_3, x - y/RAD_3, iter)

def pbm_image(out, xres, yres):
  iter = 1 + log(max(xres, yres))/log(3)
  out.write("P1\n")
  out.write("# koch PBM by Emanuele Paolini\n")
  out.write("{} {}\n".format(xres, yres))
  for y in range(yres):
    for x in range(xres):
        k = koch(x*1./xres, (yres-1-y)*1./xres, iter)
        out.write('0' if k<=0 else '1')
    out.write("\n")

xres = 6400
yres = 2000
filename = "koch.pbm"

if len(sys.argv) >= 2:
    filename = sys.argv[1]

if len(sys.argv) == 4:
    xres, yres = map(int,argv[2:])

print("Writing to file: {}\n".format(filename))
with open(filename, "w") as out:
    pbm_image(out, xres, yres);
