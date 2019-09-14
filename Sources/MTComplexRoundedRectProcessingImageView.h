#import "MTCornerRadii.h"
#import "MTMaskProcessingImageView.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface MTComplexRoundedRectProcessingImageView : MTMaskProcessingImageView

@property(nonatomic, readwrite) IBInspectable MTCornerRadii cornerRadii;

#if TARGET_INTERFACE_BUILDER
@property(nonatomic, readwrite, setter=setTopLeftCornerRadius:) IBInspectable CGFloat topLeftCornerRadius;
@property(nonatomic, readwrite, setter=setTopRightCornerRadius:) IBInspectable CGFloat topRightCornerRadius;
@property(nonatomic, readwrite, setter=setBottomLeftCornerRadius:) IBInspectable CGFloat bottomLeftCornerRadius;
@property(nonatomic, readwrite, setter=setBottomRightCornerRadius:) IBInspectable CGFloat bottomRightCornerRadius;
#endif

@end

NS_ASSUME_NONNULL_END
