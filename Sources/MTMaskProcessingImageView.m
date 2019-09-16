#import "MTMaskProcessingImageView.h"
#import "MTProcessingImageView+Private.h"
#import "CGPath+Utils.h"

@implementation MTMaskProcessingImageView {
	CGPathRef _maskPath;
	
	BOOL _needsUpdateMask : 1;
}

- (void)commonInit {
	_needsUpdateMask = YES;
	[super commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	if (self = [super initWithCoder:coder]) {
		[self commonInit];
	}
	return self;
}

- (void)setBounds:(CGRect)bounds {
	CGRect oldBounds = self.bounds;
	
	[super setBounds:bounds];
	
	if (!CGRectEqualToRect(oldBounds, bounds)) {
		[self setNeedsUpdateMask];
	}
}

- (void)setNeedsUpdateMask {
	if (!_needsUpdateMask) {
		_needsUpdateMask = YES;
		[self setNeedsProcessingImage];
	}
}

- (CGPathRef)updateMask {
	return nil;
}

- (void)updateImage:(CGContextRef)context withRect:(CGRect)rect {
	if (_needsUpdateMask) {
		_needsUpdateMask = NO;
		
		CGPathRef maskPath = [self updateMask];
		_maskPath = maskPath;
	}
	
	if (_maskPath) {
		CGContextAddPath(context, _maskPath);
		CGContextClip(context);
	}
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	if (!_maskPath) {
		return FALSE;
	}
	
	return CGPathContainsPoint(_maskPath, nil, point, FALSE);
}

#pragma mark - Property Support

- (CGPathRef)maskPath {
	return _maskPath;
}

@end
