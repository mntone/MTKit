#import "MTEllipseView.h"

@implementation MTEllipseView {
	CAShapeLayer *_maskLayer;
}

- (void)updateMask {
	CGRect currentBounds = self.bounds;
	if (CGRectIsNull(currentBounds)) {
		return;
	}
	
	CAShapeLayer *maskLayer = _maskLayer;
	if (!maskLayer) {
		maskLayer = [[CAShapeLayer alloc] init];
		_maskLayer = maskLayer;
		self.layer.mask = maskLayer;
	}
	
	CGPathRef newPath = CGPathCreateWithEllipseInRect(currentBounds, nil);
	maskLayer.path = newPath;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	if (!_maskLayer) {
		return FALSE;
	}
	
	return CGPathContainsPoint(_maskLayer.path, nil, point, FALSE);
}

@end
