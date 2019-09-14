#import "MTMaskProcessingImageView.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface MTRoundedRectProcessingImageView : MTMaskProcessingImageView

@property(nonatomic, readwrite, setter=setCornerRadius:) IBInspectable CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
