//
//  UINavigationController+ZHTransition.h
//  TEST
//
//  Created by Zason_Hao on 2017/8/23.
//  Copyright © 2017年 郝兆超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ZHTransition)<UINavigationControllerDelegate>

/**********************Display**********************/
//由下而上(类似present)
- (void)presentViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion;

//由下而上(类似present),并有弹簧效果
- (void)presentSpringViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ _Nullable)(void))completion;

//由右向左(类似push)
- (void)pushViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ __nullable)(void))completion;

//由右向左(类似push),并有弹簧效果
- (void)pushSpringViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void (^ __nullable)(void))completion;

//屏幕中心点向四周扩散
- (void)pointSpreadViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void(^_Nullable)(void))completion;

//任意一点向四周扩散
- (void)pointSpreadViewControllerWithNavigation:(UIViewController *_Nullable)viewController point:(CGPoint)point animation:(BOOL)animation completion:(void(^_Nullable)(void))completion;

//从右向左翻页
- (void)pageViewControllerWithNavigation:(UIViewController *_Nullable)viewController animation:(BOOL)animation completion:(void(^_Nullable)(void))completion;



/**********************Disappear**********************/
//由上而下(类似dismiss)
- (void)dismissViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;
//由左向右(类似pop)
- (void)popViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;
//向中心点圆形缩小
- (void)pointSprinkViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;
//向任意一点圆形缩小
- (void)pointSprinkViewControllerWithNavigationAnimation:(BOOL)animation point:(CGPoint)point completion:(void (^ __nullable)(void))completion;
//往回翻页
- (void)pageBackViewControllerWithNavigationAnimation:(BOOL)animation completion:(void (^ __nullable)(void))completion;

@end
