#import <CoreGraphics/CoreGraphics.h>

#import "MTMaskView.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface MTRoundedRectView : MTMaskView

@property(nonatomic, readwrite, setter=setCornerRadius:) IBInspectable CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
