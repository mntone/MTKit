#import "MTCircleProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTCircleProcessingImageView

- (CGPathRef)updateMask {
	CGPathRef maskPath = mt_CGPathCreateWithCircleInRect(self.bounds, nil);
	return maskPath;
}

@end
