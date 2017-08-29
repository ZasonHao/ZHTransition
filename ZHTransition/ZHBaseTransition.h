//
//  ZHBaseTransition.h
//
//  Created by Zason_Hao
//
//  E-mail:zason_hao@aliyun.com

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZHTransitionStyle){
    //display
    ZHTransitionStylePresent            = 101,
    ZHTransitionStylePresentSpring,                    //弹簧效果
    ZHTransitionStylePush,
    ZHTransitionStylePushSpring,                       //弹簧效果
    ZHTransitionStylePointSpread,                      //点扩散
    ZHTransitionStylePage,                             //翻页
    
    
    //disappear
    ZHTransitionStyleDismiss            = 201,
    ZHTransitionStylePop,
    ZHTransitionStylePointShrink,                      //向某一点缩小
    ZHTransitionStylePageBack,                         //往回翻页
};

@interface ZHBaseTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (nonatomic,weak) void(^completion)();

@property (nonatomic,assign) BOOL animation;

@property (nonatomic,assign) ZHTransitionStyle style;   //转场动画类型

@property (nonatomic,assign) BOOL isNavigation;         //导航

@property (nonatomic,assign) CGPoint spreadPoint;       //圆形放大的初始点

@end
