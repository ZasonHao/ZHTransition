//
//  UINavigationController+ZHTransition.m
//
//  Created by Zason_Hao
//
//  E-mail:zason_hao@aliyun.com

#import "UINavigationController+ZHTransition.h"
#import "ZHDisappearTransition.h"
#import "ZHDisplayTransition.h"

@implementation UINavigationController (ZHTransition)

#pragma mark - Display

- (void)presentViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePresent;
    [self pushViewController:viewController animation:animation completion:completion];
}

- (void)presentSpringViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePresentSpring;
    [self pushViewController:viewController animation:animation completion:completion];
}

- (void)pushViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePush;
    [self pushViewController:viewController animation:animation completion:completion];
}

//由右向左(类似push),并有弹簧效果
- (void)pushSpringViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePushSpring;
    [self pushViewController:viewController animation:animation completion:completion];
}

- (void)pointSpreadViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void(^_Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePointSpread;
    [ZHDisplayTransition sharedInstanced].spreadPoint = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
    [self pushViewController:viewController animation:animation completion:completion];
}

- (void)pointSpreadViewControllerWithNavigation:(UIViewController *_Nullable)viewController point:(CGPoint)point animation:(BOOL)animation completion:(void(^_Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePointSpread;
    [ZHDisplayTransition sharedInstanced].spreadPoint = point;
    [self pushViewController:viewController animation:animation completion:completion];
}

- (void)pageViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void(^_Nullable)(void))completion{
    [ZHDisplayTransition sharedInstanced].style = ZHTransitionStylePage;
    [self pushViewController:viewController animation:animation completion:completion];
}


- (void)pushViewController:(UIViewController *)viewController animation:(BOOL)animation completion:(void(^)(void))completion{
    [ZHDisplayTransition sharedInstanced].animation = animation;
    [ZHDisplayTransition sharedInstanced].completion = completion;
    self.delegate = self;
    [self pushViewController:viewController animated:animation];
    
}



#pragma mark - Disappear

- (void)dismissViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStyleDismiss;
    [self disappearViewControllerAnimation:animation completion:completion];
}

- (void)popViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePop;
    [self disappearViewControllerAnimation:animation completion:completion];
}

- (void)pointSprinkViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePointShrink;
    [ZHDisappearTransition sharedInstanced].spreadPoint = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
    [self disappearViewControllerAnimation:animation completion:completion];
}

- (void)pointSprinkViewControllerWithNavigationAnimation:(BOOL)animation point:(CGPoint)point completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePointShrink;
    [ZHDisappearTransition sharedInstanced].spreadPoint = point;
    [self disappearViewControllerAnimation:animation completion:completion];
}
- (void)pageBackViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].style = ZHTransitionStylePageBack;
    [self disappearViewControllerAnimation:animation completion:completion];
}

- (void)disappearViewControllerAnimation:(BOOL)animation completion:(void (^ _Nullable)(void))completion{
    [ZHDisappearTransition sharedInstanced].animation = animation;
    [ZHDisappearTransition sharedInstanced].isNavigation = YES;
    [ZHDisappearTransition sharedInstanced].completion = completion;
    self.delegate = self;
    [self popViewControllerAnimated:YES];
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    return operation == UINavigationControllerOperationPush ? [ZHDisplayTransition sharedInstanced] : [ZHDisappearTransition sharedInstanced];
}

@end
