#ifndef CGPATH_UTILS_H_
#define CGPATH_UTILS_H_

#include <CoreGraphics/CoreGraphics.h>

CF_ASSUME_NONNULL_BEGIN

extern CGPathRef mt_CGPathCreateWithCapsuleInRect(CGRect rect, const CGAffineTransform * __nullable transform);
extern CGPathRef mt_CGPathCreateWithCircleInRect(CGRect rect, const CGAffineTransform * __nullable transform);
extern CGPathRef mt_CGPathCreateWithRoundedRect(CGRect rect, CGFloat cornerRadius, const CGAffineTransform * __nullable transform);

#ifdef MTCORNERRADDI_H
extern CGPathRef mt_CGPathCreateWithComplexRoundedRect(CGRect rect, MTCornerRadii cornerRadii, const CGAffineTransform * __nullable transform);
#endif

CF_ASSUME_NONNULL_END

#endif /* CGPATH_UTILS_H_ */
