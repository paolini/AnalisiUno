from collections import defaultdict
from operator import itemgetter
from sys import argv
from PIL import Image

filename, inside, nx, ny = argv[1:]

nx = int(nx)
ny = int(ny)
inside = {'inside': True, 'outside': False}[inside]

print '%', inside

im = Image.open(filename) # Can be many different formats.
pix = im.load()
print '%', pix[0,0], pix[1,1], pix[2,2]
width, height = im.size  # Get the width and hight of the image for iterating over
# print pix[10,10]

scale = 10.0 / height

dx = width // nx
dy = height // ny

h = defaultdict(int)

for j in range(height):
    for i in range(width):
        h[pix[i,j]] += 1

# print sorted(h.items(), key = itemgetter(1), reverse=True)[:10]

# print nx,ny

def mypix(i,j):
    return pix[max(0,min(i,width-1)), max(0,min(j,height-1))]

path = []

squares = [[None] * nx] * ny
for j in range(ny):
    first = None
    last = None
    for i in range(nx):
        pixels = [mypix(i*dx+ii,height-1-(j*dy+jj)) for jj in range(-1,dy+1) for ii in range(-1,dx+1)]
        good_pixels = [x < 128 for x in pixels]
        # print '%', j,i, sum(good_pixels)
        if inside:
            good = sum(good_pixels) == len(pixels)
        else:
            good = sum(good_pixels) > 0
        if (good):
            if first is None:
                first = i
            last = i+1
    if first is not None:
        if not path:
            path = [(i,j) for i in range(first,last+1)]
        else:
            if first <= path[0][0]:
                path = [(i,j) for i in range(first, path[0][0]+1)] + path
            else:
                path = [(i,j) for i in range(first, path[0][0]-1,-1)] + path
            if (last <= path[-1][0]):
                path = path + [(i,j) for i in range(path[-1][0],last-1,-1)]
            else:
                path = path + [(i,j) for i in range(path[-1][0],last+1,1)]
    else:
        if path:
            path = path + [(i,j) for i in range(path[-1][0],path[0][0]-1,-1)]
            path = path + [path[0]]
            if inside:
                color = 'blue'
            else:
                color = 'red'
            print("\\draw[draw={}] ".format(color))
            print '--'.join(['({:.3},{:.3})'.format(i*dx*scale,j*dy*scale) for (i,j) in path])
            print(";")
            print("\\begin{scope}[on background layer]")
            print("\\draw[draw=none,fill={}!10] ".format(color))
            print '--'.join(['({:.3},{:.3})'.format(i*dx*scale,j*dy*scale) for (i,j) in path])
            print(";")
            print("\\end{scope}")
            path = []
    # print("%",j,first,last,path)
