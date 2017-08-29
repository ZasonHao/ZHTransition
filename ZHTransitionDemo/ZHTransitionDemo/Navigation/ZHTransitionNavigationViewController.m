//
//  ZHTransitionNavigationViewController.m
//  ZHTransition
//
//  Created by Zason_Hao on 2017/8/29.
//  Copyright © 2017年 Zason_Hao. All rights reserved.
//

#import "ZHTransitionNavigationViewController.h"
#import "ZHDisplayTransition.h"

#import "UIViewController+ZHTransition.h"
#import "UINavigationController+ZHTransition.h"

@interface ZHTransitionNavigationViewController ()

@end

@implementation ZHTransitionNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.clipsToBounds = YES;
    image.image = [UIImage imageNamed:@"fengjing02"];
    [self.view addSubview:image];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    button.center = self.view.center;
    [button setTitle:@"Touch Me To Disappear" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)disappear{
    
    ZHTransitionStyle style = [ZHDisplayTransition sharedInstanced].style;
    
    switch (style) {
        case ZHTransitionStylePresent:
        case ZHTransitionStylePresentSpring:
            [self.navigationController dismissViewControllerWithNavigationAnimation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            break;
        case ZHTransitionStylePush:
        case ZHTransitionStylePushSpring:
            [self.navigationController popViewControllerWithNavigationAnimation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            break;
        case ZHTransitionStylePointSpread:
            [self.navigationController pointSprinkViewControllerWithNavigationAnimation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            break;
        case ZHTransitionStylePage:
            [self.navigationController pageBackViewControllerWithNavigationAnimation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            break;
        default:
            break;
    }
}

@end
