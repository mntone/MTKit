#import "MTMaskProcessingImageView.h"
#import "MTProcessingImageView+Private.h"
#import "CGPath+Utils.h"

#define CHECK_RELEASE \
	if (_maskPath) { \
		CGPathRelease(_maskPath); \
		_maskPath = nil; \
	}

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

- (void)dealloc {
	CHECK_RELEASE;
}

- (void)setBounds:(CGRect)bounds {
	BOOL change = !CGRectEqualToRect(self.bounds, bounds);
	[super setBounds:bounds];
	
	if (change) {
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

- (void)processImageBefore:(CGContextRef)context withRect:(CGRect)rect {
	if (_needsUpdateMask) {
		_needsUpdateMask = NO;
		
		CHECK_RELEASE;
		
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
