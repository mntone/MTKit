#include <math.h>
#include "CGPath+Utils.h"
#include "MTCornerRadii.h"

CGPathRef mt_CGPathCreateWithCapsuleInRect(CGRect rect, const CGAffineTransform * __nullable transform) {
	CGFloat currentWidth = CGRectGetWidth(rect);
	CGFloat currentHeight = CGRectGetHeight(rect);
	
	CGMutablePathRef path = CGPathCreateMutable();
	if (currentWidth > currentHeight) {
		CGFloat radius = floor(0.5 * currentHeight);
		CGPathMoveToPoint(path, transform, radius, 0.0);
		CGPathAddArc(path, transform, currentWidth - radius, radius, radius, -M_PI_2, M_PI_2, FALSE);
		CGPathAddArc(path, transform, radius, radius, radius, M_PI_2, -M_PI_2, FALSE);
	} else {
		CGFloat radius = floor(0.5 * currentWidth);
		CGPathMoveToPoint(path, transform, 0.0, radius);
		CGPathAddArc(path, transform, radius, radius, radius, M_PI, 0.0, FALSE);
		CGPathAddArc(path, transform, radius, currentHeight - radius, radius, 0.0, M_PI, FALSE);
	}
	return CGPathCreateCopy(path);
}

CGPathRef mt_CGPathCreateWithCircleInRect(CGRect rect, const CGAffineTransform * __nullable transform) {
	CGFloat currentWidth = CGRectGetWidth(rect);
	CGFloat currentHeight = CGRectGetHeight(rect);
	
	CGRect newRect;
	if (currentWidth > currentHeight) {
		CGFloat offsetX = floor(0.5 * (currentWidth - currentHeight));
		newRect = CGRectMake(offsetX, 0.0, currentHeight, currentHeight);
	} else {
		CGFloat offsetY = floor(0.5 * (currentHeight - currentWidth));
		newRect = CGRectMake(0.0, offsetY, currentWidth, currentWidth);
	}
	
	CGPathRef path = CGPathCreateWithEllipseInRect(newRect, transform);
	return path;
}

CGPathRef mt_CGPathCreateWithRoundedRect(CGRect rect, CGFloat cornerRadius, const CGAffineTransform * __nullable transform) {
	CGFloat dCornerRadius = 2.0 * cornerRadius;
	CGFloat currentWidth = CGRectGetWidth(rect);
	CGFloat wCornerRadius = currentWidth >= dCornerRadius
		? cornerRadius
		: floor(0.5 * currentWidth);
	CGFloat currentHeight = CGRectGetHeight(rect);
	CGFloat hCornerRadius = currentHeight >= dCornerRadius
		? cornerRadius
		: floor(0.5 * currentHeight);
	return CGPathCreateWithRoundedRect(rect, wCornerRadius, hCornerRadius, transform);
}

static inline CGFloat calcCornerRadius(CGFloat baseCornerRadius, CGFloat length, CGFloat sumCornerRadius) {
	return length >= sumCornerRadius
		? baseCornerRadius
		: floor(length * baseCornerRadius / sumCornerRadius);
}

CGPathRef mt_CGPathCreateWithComplexRoundedRect(CGRect rect, MTCornerRadii cornerRadii, const CGAffineTransform * __nullable transform) {
	CGFloat currentWidth = CGRectGetWidth(rect);
	CGFloat currentHeight = CGRectGetHeight(rect);
	
	CGMutablePathRef path = CGPathCreateMutable();
	
	// top-left
	bool isTopLeftEnabled = cornerRadii.topLeft >= 0.01;
	bool isTopRightEnabled = cornerRadii.topRight >= 0.01;
	if (isTopLeftEnabled) {
		CGFloat wCornerRadius;
		if (isTopRightEnabled) {
			wCornerRadius = calcCornerRadius(cornerRadii.topLeft, currentWidth, cornerRadii.topLeft + cornerRadii.topRight);
		} else {
			wCornerRadius = calcCornerRadius(cornerRadii.topLeft, currentWidth, cornerRadii.topLeft);
		}
		
		CGPathMoveToPoint(path, transform, wCornerRadius, 0.0);
	}
	
	// top-right
	bool isBottomRightEnabled = cornerRadii.bottomRight >= 0.01;
	if (isTopRightEnabled) {
		CGFloat wCornerRadius;
		if (isTopLeftEnabled) {
			wCornerRadius = calcCornerRadius(cornerRadii.topRight, currentWidth, cornerRadii.topRight + cornerRadii.topLeft);
		} else {
			wCornerRadius = calcCornerRadius(cornerRadii.topRight, currentWidth, cornerRadii.topRight);
		}
		
		CGFloat hCornerRadius;
		if (isBottomRightEnabled) {
			hCornerRadius = calcCornerRadius(cornerRadii.topRight, currentWidth, cornerRadii.topRight + cornerRadii.bottomRight);
		} else {
			hCornerRadius = calcCornerRadius(cornerRadii.topRight, currentWidth, cornerRadii.topRight);
		}
		
		CGPathAddLineToPoint(path, transform, currentWidth - wCornerRadius, 0.0);
		CGPathAddQuadCurveToPoint(path, transform, currentWidth, 0.0, currentWidth, hCornerRadius);
	} else {
		CGPathAddLineToPoint(path, transform, currentWidth, 0.0);
	}
	
	// bottom-right
	bool isBottomLeftEnabled = cornerRadii.bottomLeft >= 0.01;
	if (isBottomRightEnabled) {
		CGFloat wCornerRadius;
		if (isBottomLeftEnabled) {
			wCornerRadius = calcCornerRadius(cornerRadii.bottomRight, currentWidth, cornerRadii.bottomRight + cornerRadii.bottomLeft);
		} else {
			wCornerRadius = calcCornerRadius(cornerRadii.bottomRight, currentWidth, cornerRadii.bottomRight);
		}
		
		CGFloat hCornerRadius;
		if (isTopRightEnabled) {
			hCornerRadius = calcCornerRadius(cornerRadii.bottomRight, currentWidth, cornerRadii.bottomRight + cornerRadii.topRight);
		} else {
			hCornerRadius = calcCornerRadius(cornerRadii.bottomRight, currentWidth, cornerRadii.bottomRight);
		}
		
		CGPathAddLineToPoint(path, transform, currentWidth, currentHeight - hCornerRadius);
		CGPathAddQuadCurveToPoint(path, transform, currentWidth, currentHeight, currentWidth - wCornerRadius, currentHeight);
	} else {
		CGPathAddLineToPoint(path, transform, currentWidth, currentHeight);
	}
	
	// bottom-left
	if (isBottomLeftEnabled) {
		CGFloat wCornerRadius;
		if (isBottomRightEnabled) {
			wCornerRadius = calcCornerRadius(cornerRadii.bottomLeft, currentWidth, cornerRadii.bottomLeft + cornerRadii.bottomRight);
		} else {
			wCornerRadius = calcCornerRadius(cornerRadii.bottomLeft, currentWidth, cornerRadii.bottomLeft);
		}
		
		CGFloat hCornerRadius;
		if (isTopLeftEnabled) {
			hCornerRadius = calcCornerRadius(cornerRadii.bottomLeft, currentWidth, cornerRadii.bottomLeft + cornerRadii.topLeft);
		} else {
			hCornerRadius = calcCornerRadius(cornerRadii.bottomLeft, currentWidth, cornerRadii.bottomLeft);
		}
		
		CGPathAddLineToPoint(path, transform, wCornerRadius, currentHeight);
		CGPathAddQuadCurveToPoint(path, transform, 0.0, currentHeight, 0.0, currentHeight - hCornerRadius);
	} else {
		CGPathAddLineToPoint(path, transform, 0.0, currentHeight);
	}
	
	// top-left
	if (isTopLeftEnabled) {
		CGFloat wCornerRadius;
		if (isTopRightEnabled) {
			wCornerRadius = calcCornerRadius(cornerRadii.topLeft, currentWidth, cornerRadii.topLeft + cornerRadii.topRight);
		} else {
			wCornerRadius = calcCornerRadius(cornerRadii.topLeft, currentWidth, cornerRadii.topLeft);
		}
		
		CGFloat hCornerRadius;
		if (isBottomLeftEnabled) {
			hCornerRadius = calcCornerRadius(cornerRadii.topLeft, currentWidth, cornerRadii.topLeft + cornerRadii.bottomLeft);
		} else {
			hCornerRadius = calcCornerRadius(cornerRadii.topLeft, currentWidth, cornerRadii.topLeft);
		}
		
		CGPathAddLineToPoint(path, transform, 0.0, hCornerRadius);
		CGPathAddQuadCurveToPoint(path, transform, 0.0, 0.0, wCornerRadius, 0.0);
	}
	return CGPathCreateCopy(path);
}
