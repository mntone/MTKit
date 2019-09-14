#import <CoreGraphics/CoreGraphics.h>

#import "MTMaskImageView.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface MTRoundedRectImageView : MTMaskImageView

@property(nonatomic, readwrite, setter=setCornerRadius:) IBInspectable CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
