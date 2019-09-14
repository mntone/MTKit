#import "ViewController.h"

static inline UIImage *imageFromColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	if (!context) {
		return nil;
	}
	
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@implementation ViewController {
	CGFloat hue;
}

- (IBAction)viewDidTap:(UITapGestureRecognizer *)recognizer {
	UIView *view = recognizer.view;
	if (!view) {
		return;
	}
	
	view.backgroundColor = [[UIColor alloc] initWithHue:hue saturation:0.8 brightness:1.0 alpha:1.0];
	hue += 20.0 / 360.0;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.capsuleProcessingImageView setImage:imageFromColor(UIColor.redColor)];
	[self.circleProcessingImageView setImage:imageFromColor(UIColor.yellowColor)];
	[self.ellipseProcessingImageView setImage:imageFromColor(UIColor.greenColor)];
	[self.roundedRectProcessingImageView setImage:imageFromColor(UIColor.blueColor)];
	[self.complexRoundedRectProcessingImageView setImage:imageFromColor(UIColor.purpleColor)];
}

@end
