#import "MTEllipseProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTEllipseProcessingImageView

- (void)updateMask {
	CGPathRef maskPath = CGPathCreateWithEllipseInRect(self.bounds, nil);
	[self setMaskPath:maskPath];
}

@end
