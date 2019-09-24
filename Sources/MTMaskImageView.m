#import "MTMaskImageView.h"

@implementation MTMaskImageView {
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
	BOOL change = !CGRectEqualToRect(self.bounds, bounds);
	[super setBounds:bounds];
	
	if (change) {
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

- (void)layoutSubviews {
	if (_needsUpdateMask) {
		_needsUpdateMask = NO;
		[self updateMask];
	}
	
	[super layoutSubviews];
}

@end
