//
//  ZHTransitionPresentViewController.m
//  ZHTransition
//
//  Created by Zason_Hao on 2017/8/29.
//  Copyright © 2017年 Zason_Hao. All rights reserved.
//

#import "ZHTransitionPresentViewController.h"
#import "ZHDisplayTransition.h"

#import "UIViewController+ZHTransition.h"
#import "UINavigationController+ZHTransition.h"

@interface ZHTransitionPresentViewController ()

@end

@implementation ZHTransitionPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
    image.image = [UIImage imageNamed:@"fengjing01"];
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
            [self dismissViewControllerWithPresentModalAnimation:YES completion:^{
                
            }];
            break;
        case ZHTransitionStylePush:
        case ZHTransitionStylePushSpring:
            [self popViewControllerWithPresentModalAnimation:YES completion:^{
                
            }];
            break;
        case ZHTransitionStylePointSpread:
            [self pointSprinkViewControllerWithPresentModalAnimation:YES completion:^{
                
            }];
            break;
        case ZHTransitionStylePage:
            [self pageBackViewControllerWithPresentModalAnimation:YES completion:^{
                
            }];
            break;
        default:
            break;
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
