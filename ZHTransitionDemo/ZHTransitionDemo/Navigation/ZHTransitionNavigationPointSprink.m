//
//  ZHTransitionNavigationPointSprink.m
//  ZHTransition
//
//  Created by Zason_Hao on 2017/8/29.
//  Copyright © 2017年 Zason_Hao. All rights reserved.
//

#import "ZHTransitionNavigationPointSprink.h"

#import "UIViewController+ZHTransition.h"
#import "UINavigationController+ZHTransition.h"

@interface ZHTransitionNavigationPointSprink ()

@end

@implementation ZHTransitionNavigationPointSprink

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.clipsToBounds = YES;
    image.image = [UIImage imageNamed:@"fengjing04.jpeg"];
    [self.view addSubview:image];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    label.center = CGPointMake(self.view.center.x, 150);
    label.numberOfLines = 0;
    label.text = @"Touch Anywhere You Want To Disappear";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    CGPoint endPoint = [[touches anyObject] locationInView:self.view];
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1) {
        [self.navigationController pointSprinkViewControllerWithNavigationAnimation:YES point:endPoint completion:^{
            NSLog(@"transiton complete !");
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
