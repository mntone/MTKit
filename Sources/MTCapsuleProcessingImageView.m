#import "MTCapsuleProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTCapsuleProcessingImageView

- (void)updateMask {
	CGPathRef maskPath = mt_CGPathCreateWithCapsuleInRect(self.bounds, nil);
	[self setMaskPath:maskPath];
}

@end
