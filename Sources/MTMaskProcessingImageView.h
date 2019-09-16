#import "MTMaskable.h"
#import "MTProcessingImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTMaskProcessingImageView : MTProcessingImageView

@property (nullable, readonly) CGPathRef maskPath;

- (void)setNeedsUpdateMask;
- (CGPathRef __nullable)updateMask;

@end

NS_ASSUME_NONNULL_END
