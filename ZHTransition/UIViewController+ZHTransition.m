//
//  UIViewController+ZHTransition.m
//
//  Created by Zason_Hao
//
//  E-mail:zason_hao@aliyun.com

#import "UIViewController+ZHTransition.h"
#import "ZHDisappearTransition.h"
#import "ZHDisplayTransition.h"

@implementation UIViewController (ZHTransition)

#pragma mark - Display
//由下而上(类似present)
- (void)presentViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePresent;
    [self displayViewController:viewController animation:animation completion:completion];
}
//由下而上(类似present),并有弹簧效果
- (void)presentSpringViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePresentSpring;
    [self displayViewController:viewController animation:animation completion:completion];
}
//由右向左(类似push)
- (void)pushViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePush;
    [self displayViewController:viewController animation:animation completion:completion];
}
//由右向左(类似push),并有弹簧效果
- (void)pushSpringViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePushSpring;
    [self displayViewController:viewController animation:animation completion:completion];
}
//屏幕中心点向四周扩散
-(void)pointSpreadViewControllerWithPresentModal:(UIViewController *)viewController animation:(BOOL)animation completion:(void (^)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePointSpread;
    [ZHDisplayTransition sharedInstanced].spreadPoint = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
    [self displayViewController:viewController animation:animation completion:completion];
}
//任意一点向四周扩散
- (void)pointSpreadViewControllerWithPresentModal:(UIViewController *_Nullable)viewController point:(CGPoint)point animation:(BOOL)animation completion:(void(^_Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePointSpread;
    [ZHDisplayTransition sharedInstanced].spreadPoint = point;
    [self displayViewController:viewController animation:animation completion:completion];
}
//从右向左翻页
- (void)pageViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void(^_Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePage;
    [self displayViewController:viewController animation:animation completion:completion];
}



- (void)displayViewController:(UIViewController *)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].animation = animation;
    [ZHDisplayTransition sharedInstanced].completion = nil;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    [self presentViewController:viewController animated:animation completion:^{
        if (completion) { completion(); }
    }];
}

#pragma mark - Disappear
//由上而下(类似dismiss)
- (void)dismissViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStyleDismiss;
    [self disappearViewControllerAnimationnimation:animation completion:completion];
}
//由左向右(类似pop)
- (void)popViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePop;
    [self disappearViewControllerAnimationnimation:animation completion:completion];
}
//向中心点圆形缩小
- (void)pointSprinkViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePointShrink;
    [ZHDisappearTransition sharedInstanced].spreadPoint = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
    [self disappearViewControllerAnimationnimation:animation completion:completion];
}
//向任意一点圆形缩小
- (void)pointSprinkViewControllerWithPresentModalAnimation:(BOOL)animation point:(CGPoint)point completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePointShrink;
    [ZHDisappearTransition sharedInstanced].spreadPoint = point;
    [self disappearViewControllerAnimationnimation:animation completion:completion];
}
//往回翻页
- (void)pageBackViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePageBack;
    [self disappearViewControllerAnimationnimation:animation completion:completion];
}




- (void)disappearViewControllerAnimationnimation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].animation = animation;
    [ZHDisappearTransition sharedInstanced].isNavigation = NO;
    [ZHDisappearTransition sharedInstanced].completion = nil;
    self.transitioningDelegate = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (completion) { completion(); }
    }];
}



#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [ZHDisplayTransition sharedInstanced];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [ZHDisappearTransition sharedInstanced];
}

@end
