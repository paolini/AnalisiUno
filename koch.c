// compilazione:
// gcc koch.c -lm -o koch

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

double affine_koch(double t, double s, int iter) {
    // t, s are affine (triangular) coordinates
    // @return positive if inside, negative if outside
    if (t+s > 1) return 1.;
    if (t<=0 || s<=0) return -1.;
    if (3*(t+s) < 2) return -.5;
    if (iter <= 0) return 0.;
    if (3*s >= 2) return affine_koch(3*t, 3*s-2, iter-1);
    if (3*t >= 2) return affine_koch(3*t-2, 3*s, iter-1);
    if (3*t <= 1) return affine_koch(3*t-2+3*s, 2-3*s, iter-1);
    return affine_koch(2-3*t,3*s-2+3*t, iter-1);
}

const double RAD_3 = sqrt(3);

double koch(double x, double y, int iter) {
  return affine_koch(1 - x - y/RAD_3, x - y/RAD_3, iter);
}

void pbm_image(FILE *out, int xres, int yres) {
  int iter = 1+log(fmax(xres, yres))/log(3);
  fprintf(out, "P1\n");
  fprintf(out, "# koch PBM by Emanuele Paolini\n");
  fprintf(out, "%d %d\n", xres, yres);
  for (int y=yres-1; y>=0; --y) {
    for (int x=0; x<xres; x++) {
        double k = koch(x*1./xres, y*1./xres, iter);
        fputc(k<=0 ? '0' : '1', out);
    }
    fprintf(out, "\n");
  }
}

int main(int argc, char *argv[]) {
    int xres = 6400;
    int yres = 2000;
    const char *filename = "koch.pbm";

    if (argc >= 2) filename = argv[1];

    if (argc == 4) {
        xres = atoi(argv[2]);
        yres = atoi(argv[3]);
    }

    printf("Writing to file: %s\n", filename);
    FILE *out = fopen(filename,"w");
    if (!out) {
      perror("koch");
      exit(1);
    }
    pbm_image(out, xres, yres);
    fclose(out);
}
