#import "MTComplexRoundedRectProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTComplexRoundedRectProcessingImageView {
	MTCornerRadii _cornerRadii;
}
- (void)updateMask {
	if (!MTCornerRadiiIsNull(_cornerRadii)) {
		CGPathRef maskPath = mt_CGPathCreateWithComplexRoundedRect(self.bounds, _cornerRadii, nil);
		[self setMaskPath:maskPath];
	} else {
		[self setMaskPath:nil];
	}
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
