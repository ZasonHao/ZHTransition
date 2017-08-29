//
//  UIViewController+ZHTransition.h
//
//  Created by Zason_Hao
//
//  E-mail:zason_hao@aliyun.com

#import <UIKit/UIKit.h>

@interface UIViewController (ZHTransition) <UIViewControllerTransitioningDelegate>

/**********************Display**********************/
//由下而上(类似present)
- (void)presentViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion;

//由下而上(类似present),并有弹簧效果
- (void)presentSpringViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion;

//由右向左(类似push)
- (void)pushViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ __nullable)(void))completion;

//由右向左(类似push),并有弹簧效果
- (void)pushSpringViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ __nullable)(void))completion;

//屏幕中心点向四周扩散
- (void)pointSpreadViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void(^_Nullable)(void))completion;

//任意一点向四周扩散
- (void)pointSpreadViewControllerWithPresentModal:(UIViewController *_Nullable)viewController point:(CGPoint)point animation:(BOOL)animation completion:(void(^_Nullable)(void))completion;

//从右向左翻页
- (void)pageViewControllerWithPresentModal:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void(^_Nullable)(void))completion;



/**********************Disappear**********************/

//由上而下(类似dismiss)
- (void)dismissViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;
//由左向右(类似pop)
- (void)popViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;
//向中心点圆形缩小
- (void)pointSprinkViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;
//向任意一点圆形缩小
- (void)pointSprinkViewControllerWithPresentModalAnimation:(BOOL)animation point:(CGPoint)point completion:(void (^ __nullable)(void))completion;
//往回翻页
- (void)pageBackViewControllerWithPresentModalAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;


@end
