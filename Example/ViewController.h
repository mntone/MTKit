#import <MTKit/MTKit.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet MTCapsuleProcessingImageView *capsuleProcessingImageView;
@property (strong, nonatomic) IBOutlet MTCircleProcessingImageView *circleProcessingImageView;
@property (strong, nonatomic) IBOutlet MTEllipseProcessingImageView *ellipseProcessingImageView;
@property (strong, nonatomic) IBOutlet MTRoundedRectProcessingImageView *roundedRectProcessingImageView;
@property (strong, nonatomic) IBOutlet MTComplexRoundedRectProcessingImageView *complexRoundedRectProcessingImageView;

- (IBAction)viewDidTap:(UITapGestureRecognizer *)recognizer;

@end
