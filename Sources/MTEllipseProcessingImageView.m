#import "MTEllipseProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTEllipseProcessingImageView

- (CGPathRef)updateMask {
	CGPathRef maskPath = CGPathCreateWithEllipseInRect(self.bounds, nil);
	return maskPath;
}

@end
