#import "MTCapsuleProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTCapsuleProcessingImageView

- (CGPathRef)updateMask {
	CGPathRef maskPath = mt_CGPathCreateWithCapsuleInRect(self.bounds, nil);
	return maskPath;
}

@end
