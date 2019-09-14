#import "MTCircleProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTCircleProcessingImageView

- (void)updateMask {
	CGPathRef maskPath = mt_CGPathCreateWithCircleInRect(self.bounds, nil);
	[self setMaskPath:maskPath];
}

@end
