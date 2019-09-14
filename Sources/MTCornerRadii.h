#ifndef MTCORNERRADDI_H
#define MTCORNERRADDI_H

#include <CoreGraphics/CGBase.h>

struct MTCornerRadii {
	CGFloat topLeft, topRight, bottomLeft, bottomRight;
};
typedef struct MTCornerRadii MTCornerRadii;

extern bool MTCornerRadiiIsNull(MTCornerRadii cornerRadii);

#endif /* MTCORNERRADDI_H */
