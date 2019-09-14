#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTMaskable <NSObject>

- (void)setNeedsUpdateMask;
- (void)updateMask;

@end

NS_ASSUME_NONNULL_END
