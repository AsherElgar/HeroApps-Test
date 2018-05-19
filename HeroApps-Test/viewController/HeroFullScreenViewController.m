//
//  HeroFullScreenViewController.m
//  HeroApps-Test
//
//  Created by Asher Elgar on 18/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import "HeroFullScreenViewController.h"
#import <CoreData/CoreData.h>


@interface HeroFullScreenViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *heroImage;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end

@implementation HeroFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.heroImage.image = self.image;
    
    self.btnClose.hidden = YES;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    [[self heroImage] addGestureRecognizer:pinch];
    [[self heroImage] setUserInteractionEnabled:YES];
    
}

    - (void)pinch:(UIPinchGestureRecognizer *)gesture {
        
        if (gesture.state == UIGestureRecognizerStateEnded
            || gesture.state == UIGestureRecognizerStateChanged) {
            NSLog(@"gesture.scale = %f", gesture.scale);

            CGFloat currentScale = self.view.frame.size.width / self.view.bounds.size.width;
            CGFloat newScale = currentScale * gesture.scale;
            
            if (newScale > 0.6 && newScale < 2.5){
                   CGAffineTransform transform1 = CGAffineTransformMakeScale(newScale, newScale);
                [[gesture view] setTransform:transform1];
            }
           
        }
        
    }
- (IBAction)closeImage:(UIButton *)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.btnClose.hidden = NO;
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
