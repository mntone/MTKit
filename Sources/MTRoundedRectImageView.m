#import "MTRoundedRectImageView.h"
#import "CGPath+Utils.h"

@implementation MTRoundedRectImageView {
	CGFloat _cornerRadius;
	CAShapeLayer *_maskLayer;
}

- (void)updateMask {
	CGRect currentBounds = self.bounds;
	if (_cornerRadius < 0.01 || CGRectIsNull(currentBounds)) {
		self.layer.mask = nil;
		return;
	}
	
	CAShapeLayer *maskLayer = _maskLayer;
	if (!maskLayer) {
		maskLayer = [[CAShapeLayer alloc] init];
		_maskLayer = maskLayer;
	}
	
	CGPathRef newPath = mt_CGPathCreateWithRoundedRect(currentBounds, _cornerRadius, nil);
	maskLayer.path = newPath;
	self.layer.mask = maskLayer;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	if (_cornerRadius < 0.01) {
		return [super pointInside:point withEvent:event];
	}
	
	if (!_maskLayer) {
		return FALSE;
	}
	
	return CGPathContainsPoint(_maskLayer.path, nil, point, FALSE);
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
