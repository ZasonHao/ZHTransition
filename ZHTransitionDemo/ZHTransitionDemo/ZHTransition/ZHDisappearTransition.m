//
//  ZHDisappearTransition.m
//
//  Created by Zason_Hao
//
//  E-mail:zason_hao@aliyun.com

#import "ZHDisappearTransition.h"

@implementation ZHDisappearTransition

+ (ZHDisappearTransition *)sharedInstanced{
    static ZHDisappearTransition *transition;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transition = [[ZHDisappearTransition alloc] init];
    });
    return transition;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    NSLog(@"UIViewControllerContextTransitioning");
    if (!self.animation) {
        [self zhTransitionNoAnimation:transitionContext];
        return;
    }
    switch (self.style) {
        case ZHTransitionStyleDismiss:
            [self zhTransitionWithStyleDismiss:transitionContext];
            break;
        case ZHTransitionStylePop:
            [self zhTransitionWithStylePop:transitionContext];
            
            break;
//        case ZHTransitionStyleDismiss:
//
//            break;
        case ZHTransitionStylePointShrink:
            [self zhTransitionWithStylePointSprink:transitionContext];
            break;
        case ZHTransitionStylePageBack:
            [self zhTransitionWithStylePageBack:transitionContext];
            break;
//        case ZHTransitionStyleDismiss:
//
//            break;
//
        default:
            break;
    }
    
}

#pragma mark - 具体各个disappear方式

- (void)zhTransitionNoAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [self needAddPreviouView:transitionContext];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    fromVC.view.frame = finalFrame;
    [transitionContext completeTransition:YES];
    if ([ZHDisappearTransition sharedInstanced].completion) {
        [ZHDisappearTransition sharedInstanced].completion();
    }
}

- (void)zhTransitionWithStyleDismiss:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [self needAddPreviouView:transitionContext];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if ([ZHDisappearTransition sharedInstanced].completion) {
            [ZHDisappearTransition sharedInstanced].completion();
        }
    }];
}

- (void)zhTransitionWithStylePop:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [self needAddPreviouView:transitionContext];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, screenBounds.size.width, 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if ([ZHDisappearTransition sharedInstanced].completion) {
            [ZHDisappearTransition sharedInstanced].completion();
        }
    }];
    
}

- (void)zhTransitionWithStylePointSprink:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [self needAddPreviouView:transitionContext];
    UIView *containerView = [transitionContext containerView];
    //画两个圆路径
    CGRect screenBounds = CGRectMake(self.spreadPoint.x, self.spreadPoint.y, 1, 1);
    //最初的中心点
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:screenBounds];
    CGFloat x = MAX(screenBounds.origin.x, containerView.frame.size.width - screenBounds.origin.x);
    CGFloat y = MAX(screenBounds.origin.y, containerView.frame.size.height - screenBounds.origin.y);
    //最终圆的半径,勾股定理
    CGFloat radius = sqrtf/*开平方*/(pow(x, 2)/*指数，这里是2次方*/ + pow(y, 2));
    //最终的圆
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = 0.4;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)zhTransitionWithStylePageBack:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self needAddPreviouView:transitionContext];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    [UIView animateWithDuration:0.5 animations:^{
        tempView.layer.transform = CATransform3DIdentity;
        fromVC.view.subviews.lastObject.alpha = 1.0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
            if ([ZHDisappearTransition sharedInstanced].completion) {
                [ZHDisappearTransition sharedInstanced].completion();
            }
        }
    }];
}


- (void)needAddPreviouView:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (!self.isNavigation) return;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
}
#pragma mark - CAAnimationDelegate
//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (self.style) {
        case ZHTransitionStylePointSpread:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            if ([ZHDisappearTransition sharedInstanced].completion) {
                [ZHDisappearTransition sharedInstanced].completion();
            }
        }
            break;
        case ZHTransitionStylePointShrink:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
            if ([ZHDisappearTransition sharedInstanced].completion) {
                [ZHDisappearTransition sharedInstanced].completion();
            }
        }
            break;
        default:
            break;
    }
}
@end
