#import "MTMaskable.h"
#import "MTProcessingImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTMaskProcessingImageView : MTProcessingImageView <MTMaskable>

@property (nullable) CGPathRef maskPath;

@end

NS_ASSUME_NONNULL_END
