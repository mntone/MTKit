#import "MTComplexRoundedRectView.h"
#import "CGPath+Utils.h"

#define CHECK_RELEASE \
	CGPathRef oldPath = _maskLayer.path; \
	if (oldPath) { \
		_maskLayer.path = nil; \
		CGPathRelease(oldPath); \
	}

@implementation MTComplexRoundedRectView {
	MTCornerRadii _cornerRadii;
	CAShapeLayer *_maskLayer;
}

- (void)dealloc {
	CHECK_RELEASE;
}

- (void)updateMask {
	CGRect currentBounds = self.bounds;
	if (MTCornerRadiiIsNull(_cornerRadii) || CGRectIsNull(currentBounds)) {
		self.layer.mask = nil;
		return;
	}
	
	CAShapeLayer *maskLayer = _maskLayer;
	if (!maskLayer) {
		maskLayer = [[CAShapeLayer alloc] init];
		_maskLayer = maskLayer;
	}
	
	CHECK_RELEASE;

	CGPathRef newPath = mt_CGPathCreateWithComplexRoundedRect(currentBounds, self.cornerRadii, nil);
	maskLayer.path = newPath;
	self.layer.mask = maskLayer;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	if (MTCornerRadiiIsNull(_cornerRadii)) {
		return [super pointInside:point withEvent:event];
	}
	
	if (!_maskLayer) {
		return FALSE;
	}
	
	return CGPathContainsPoint(_maskLayer.path, nil, point, FALSE);
}

#pragma mark - Property Support

- (MTCornerRadii)cornerRadii {
	return _cornerRadii;
}

- (void)setCornerRadii:(MTCornerRadii)cornerRadii {
	_cornerRadii = cornerRadii;
	[self setNeedsUpdateMask];
}

- (CGFloat)topLeftCornerRadius {
	return _cornerRadii.topLeft;
}

- (void)setTopLeftCornerRadius:(CGFloat)topLeftCornerRadius {
	_cornerRadii.topLeft = topLeftCornerRadius;
	[self setNeedsUpdateMask];
}

- (CGFloat)topRightCornerRadius {
	return _cornerRadii.topRight;
}

- (void)setTopRightCornerRadius:(CGFloat)topRightCornerRadius {
	_cornerRadii.topRight = topRightCornerRadius;
	[self setNeedsUpdateMask];
}

- (CGFloat)bottomLeftCornerRadius {
	return _cornerRadii.bottomLeft;
}

- (void)setBottomLeftCornerRadius:(CGFloat)bottomLeftCornerRadius {
	_cornerRadii.bottomLeft = bottomLeftCornerRadius;
	[self setNeedsUpdateMask];
}

- (CGFloat)bottomRightCornerRadius {
	return _cornerRadii.bottomRight;
}

- (void)setBottomRightCornerRadius:(CGFloat)bottomRightCornerRadius {
	_cornerRadii.bottomRight = bottomRightCornerRadius;
	[self setNeedsUpdateMask];
}

@end
