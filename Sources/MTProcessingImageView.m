#import <UIKit/UIImage.h>
#import <UIKit/UIScreen.h>
#import "MTProcessingImageView+Private.h"

#define CHECK_RELEASE \
	if (_processedImage) { \
		CGImageRelease(_processedImage); \
		_processedImage = nil; \
	}

#define UPDATE_SCALE \
	self.contentScaleFactor = UIScreen.mainScreen.scale;

static inline CGRect getAspectFitRect(CGRect viewRect, CGRect imageRect) {
	CGFloat viewWidth = CGRectGetWidth(viewRect);
	CGFloat viewHeight = CGRectGetHeight(viewRect);
	
	CGFloat imageWidth = CGRectGetWidth(imageRect);
	CGFloat imageHeight = CGRectGetHeight(imageRect);
	
	CGFloat hScaleFactor = viewWidth / imageWidth;
	CGFloat vScaleFactor = viewHeight / imageHeight;
	CGRect renderRect;
	if (hScaleFactor > vScaleFactor) {
		CGFloat renderWidth = vScaleFactor * imageWidth;
		CGFloat offsetX = 0.5 * (viewWidth - renderWidth);
		renderRect = CGRectMake(offsetX, 0.0, renderWidth, viewHeight);
	} else {
		CGFloat renderHeight = hScaleFactor * imageHeight;
		CGFloat offsetY = 0.5 * (viewHeight - renderHeight);
		renderRect = CGRectMake(0.0, offsetY, viewWidth, renderHeight);
	}
	return renderRect;
}

static inline CGRect getAspectFillRect(CGRect viewRect, CGRect imageRect) {
	CGFloat viewWidth = CGRectGetWidth(viewRect);
	CGFloat viewHeight = CGRectGetHeight(viewRect);
	
	CGFloat imageWidth = CGRectGetWidth(imageRect);
	CGFloat imageHeight = CGRectGetHeight(imageRect);
	
	CGFloat hScaleFactor = viewWidth / imageWidth;
	CGFloat vScaleFactor = viewHeight / imageHeight;
	CGRect renderRect;
	if (hScaleFactor < vScaleFactor) {
		CGFloat renderWidth = vScaleFactor * imageWidth;
		CGFloat offsetX = 0.5 * (viewWidth - renderWidth);
		renderRect = CGRectMake(offsetX, 0.0, renderWidth, viewHeight);
	} else {
		CGFloat renderHeight = hScaleFactor * imageHeight;
		CGFloat offsetY = 0.5 * (viewHeight - renderHeight);
		renderRect = CGRectMake(0.0, offsetY, viewWidth, renderHeight);
	}
	return renderRect;
}

@implementation MTProcessingImageView {
	UIImage *_image;
	CGImageRef _processedImage;
	
	MTProcessingImageViewProcessingContentMode _processingContentMode;
	BOOL _needProcessing : 1;
}

- (void)commonInit {
	self.contentMode = UIViewContentModeLeft | UIViewContentModeTop;
	UPDATE_SCALE;
	
	_needProcessing = YES;
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
	[super setBounds:bounds];
	
	if (!CGRectEqualToRect(self.bounds, bounds)) {
		[self setNeedsProcessingImage];
	}
}

- (void)didMoveToSuperview {
	[self processImageIfNeeded];
	[super didMoveToSuperview];
}

- (void)processImageIfNeeded {
	if (_needProcessing && self.superview && _image) {
		_needProcessing = NO;
		[self updateImagePrivate];
	}
}

- (void)setNeedsProcessingImage {
	if (!_needProcessing) {
		_needProcessing = YES;
	}
	
	[self processImageIfNeeded];
}

- (void)updateImage:(CGContextRef)context withRect:(CGRect)rect {
}

- (void)updateImagePrivate {
	CHECK_RELEASE;
	UPDATE_SCALE;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if (!colorSpace) {
		return;
	}
	
	CGRect currentBounds = self.bounds;
	CGFloat scale = UIScreen.mainScreen.scale;
	CGFloat currentWidth = CGRectGetWidth(currentBounds);
	CGFloat currentHeight = CGRectGetHeight(currentBounds);
	CGContextRef context = CGBitmapContextCreate(NULL,
												 (size_t)(scale * currentWidth),
												 (size_t)(scale * currentHeight),
												 8,
												 0,
												 colorSpace,
												 kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedFirst);
	CGColorSpaceRelease(colorSpace);
	if (!context) {
		return;
	}
	
	CGImageRef cgImage = _image.CGImage;
	if (cgImage) {
		CGContextScaleCTM(context, scale, scale);
		[self updateImage:context withRect:currentBounds];
		
		switch (_processingContentMode) {
		case MTProcessingImageViewProcessingContentModeScaleAspectFit: {
			CGFloat imageWidth = CGImageGetWidth(cgImage);
			CGFloat imageHeight = CGImageGetHeight(cgImage);
			CGRect imageRect = CGRectMake(0.0, 0.0, imageWidth, imageHeight);
			CGRect renderRect = getAspectFitRect(currentBounds, imageRect);
			CGContextDrawImage(context, renderRect, cgImage);
			break;
		}
				
		case MTProcessingImageViewProcessingContentModeScaleAspectFill: {
			CGFloat imageWidth = CGImageGetWidth(cgImage);
			CGFloat imageHeight = CGImageGetHeight(cgImage);
			CGRect imageRect = CGRectMake(0.0, 0.0, imageWidth, imageHeight);
			CGRect renderRect = getAspectFillRect(currentBounds, imageRect);
			CGContextDrawImage(context, renderRect, cgImage);
			break;
		}
				
		case MTProcessingImageViewProcessingContentModeScaleToFill:
		default:
			CGContextDrawImage(context, currentBounds, cgImage);
			break;
		}

		CGImageRef processedImage = CGBitmapContextCreateImage(context);
		if (processedImage) {
			self.layer.contents = (__bridge id)processedImage;
			
			goto finally;
		}
	}
	
	self.layer.contents = nil;
	
finally:
	CGContextRelease(context);
}

#pragma mark - Property Support

- (UIImage *)image {
	return _image;
}

- (void)setImage:(UIImage *)image {
	_image = image;
	[self setNeedsProcessingImage];
}

- (MTProcessingImageViewProcessingContentMode)processingContentMode {
	return _processingContentMode;
}

- (void)setProcessingContentMode:(MTProcessingImageViewProcessingContentMode)processingContentMode {
	_processingContentMode = processingContentMode;
	[self setNeedsProcessingImage];
}

@end
