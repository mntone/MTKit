#ifndef CGFLOAT_UTILS_H_
#define CGFLOAT_UTILS_H_

#include <CoreGraphics/CGBase.h>

static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return ceil(cgfloat);
#else
	return ceilf(cgfloat);
#endif
}

static inline CGFLOAT_TYPE CGFloat_floor(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return floor(cgfloat);
#else
	return floorf(cgfloat);
#endif
}

static inline CGFLOAT_TYPE CGFloat_round(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return round(cgfloat);
#else
	return roundf(cgfloat);
#endif
}

static inline CGFLOAT_TYPE CGFloat_sqrt(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
	return sqrt(cgfloat);
#else
	return sqrtf(cgfloat);
#endif
}

#endif /* CGFLOAT_UTILS_H_ */
