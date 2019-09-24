#import "MTCapsuleView.h"
#import "CGPath+Utils.h"

#define CHECK_RELEASE \
	CGPathRef oldPath = _maskLayer.path; \
	if (oldPath) { \
		_maskLayer.path = nil; \
		CGPathRelease(oldPath); \
	}

@implementation MTCapsuleView {
	CAShapeLayer *_maskLayer;
}

- (void)dealloc {
	CHECK_RELEASE;
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
	
	CHECK_RELEASE;
	
	CGPathRef newPath = mt_CGPathCreateWithCapsuleInRect(currentBounds, nil);
	maskLayer.path = newPath;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	if (!_maskLayer) {
		return FALSE;
	}
	
	return CGPathContainsPoint(_maskLayer.path, nil, point, FALSE);
}

@end
