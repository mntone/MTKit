#import <UIKit/UIView.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MTProcessingImageViewProcessingContentMode) {
    MTProcessingImageViewProcessingContentModeScaleToFill,
    MTProcessingImageViewProcessingContentModeScaleAspectFit,
    MTProcessingImageViewProcessingContentModeScaleAspectFill,
};

IB_DESIGNABLE
@interface MTProcessingImageView : UIView

@property (nullable, nonatomic, strong) UIImage *image;
@property (nonatomic) MTProcessingImageViewProcessingContentMode processingContentMode;

- (void)setNeedsProcessingImage;
- (void)processImageBefore:(CGContextRef)context withRect:(CGRect)rect;
- (void)processImageAfter:(CGContextRef)context withRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
