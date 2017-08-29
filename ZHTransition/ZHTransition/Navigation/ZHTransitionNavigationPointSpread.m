//
//  ZHTransitionNavigationPointSpread.m
//  ZHTransition
//
//  Created by Zason_Hao on 2017/8/29.
//  Copyright © 2017年 Zason_Hao. All rights reserved.
//

#import "ZHTransitionNavigationPointSpread.h"
#import "ZHTransitionNavigationPointSprink.h"

#import "UIViewController+ZHTransition.h"
#import "UINavigationController+ZHTransition.h"

@interface ZHTransitionNavigationPointSpread ()

@end

@implementation ZHTransitionNavigationPointSpread

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.clipsToBounds = YES;
    image.image = [UIImage imageNamed:@"fengjing03.jpeg"];
    [self.view addSubview:image];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    label.center = CGPointMake(self.view.center.x, 150);
    label.numberOfLines = 0;
    label.text = @"Touch Anywhere You Want To Show New ViewController";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    button.center = self.view.center;
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"Touch Me To Disappear" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)disappear{
    
    [self.navigationController pointSprinkViewControllerWithNavigationAnimation:YES completion:^{
        NSLog(@"transiton complete !");
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    CGPoint endPoint = [[touches anyObject] locationInView:self.view];
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1) {
        ZHTransitionNavigationPointSprink *vc = [[ZHTransitionNavigationPointSprink alloc] init];
        [self.navigationController pointSpreadViewControllerWithNavigation:vc point:endPoint animation:YES completion:^{
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
