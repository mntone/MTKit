#import "MTRoundedRectProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTRoundedRectProcessingImageView {
	CGFloat _cornerRadius;
}

- (void)updateMask {
	if (_cornerRadius >= 0.01) {
		CGPathRef maskPath = mt_CGPathCreateWithRoundedRect(self.bounds, _cornerRadius, nil);
		[self setMaskPath:maskPath];
	} else {
		[self setMaskPath:nil];
	}
}

#pragma mark - Property Support

- (CGFloat)cornerRadius {
	return _cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	CGFloat fixedCornerRadius = MAX(cornerRadius, 0.0);
	if (_cornerRadius == fixedCornerRadius) {
		return;
	}
	
	_cornerRadius = fixedCornerRadius;
	[self setNeedsUpdateMask];
}

@end
