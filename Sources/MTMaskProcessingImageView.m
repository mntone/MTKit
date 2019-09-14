#import "MTMaskProcessingImageView.h"
#import "CGPath+Utils.h"

@implementation MTMaskProcessingImageView {
	CGPathRef _maskPath;
	
	BOOL _needsUpdateMask : 1;
}

- (void)commonInit {
	_needsUpdateMask = YES;
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
	[super setBounds:bounds];
	
	if (!CGRectEqualToRect(self.bounds, bounds)) {
		[self setNeedsUpdateMask];
	}
}

- (void)setNeedsUpdateMask {
	if (!_needsUpdateMask) {
		_needsUpdateMask = YES;
	}
}

- (void)updateMask {
}

- (void)updateImage:(CGContextRef)context withRect:(CGRect)rect {
	if (_needsUpdateMask) {
		_needsUpdateMask = NO;
		[self updateMask];
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

- (void)setMaskPath:(CGPathRef)maskPath {
	_maskPath = maskPath;
	[self setNeedsUpdateMask];
	[self setNeedsProcessingImage];
}

@end
