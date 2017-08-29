//
//  ZHDisplayTransition.m
//
//  Created by Zason_Hao
//
//  E-mail:zason_hao@aliyun.com

#import "ZHDisplayTransition.h"

@implementation ZHDisplayTransition
+ (ZHDisplayTransition *)sharedInstanced{
    static ZHDisplayTransition *transition;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transition = [[ZHDisplayTransition alloc] init];
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
        case ZHTransitionStylePresent:
            [self zhTransitionWithStylePresent:transitionContext];
            break;
        case ZHTransitionStylePresentSpring:
            [self zhTransitionWithStylePresentSpring:transitionContext];
            break;
        case ZHTransitionStylePush:
            [self zhTransitionWithStylePush:transitionContext];
            break;
        case ZHTransitionStylePushSpring:
            [self zhTransitionWithStylePushSpring:transitionContext];
            break;
        case ZHTransitionStylePointSpread:
            [self zhTransitionWithStylePointSpread:transitionContext];
            break;
        case ZHTransitionStylePage:
            [self zhTransitionWithStylePage:transitionContext];
            break;
        default:
            break;
    }
    
}

- (void)zhTransitionNoAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalFrame;
    [transitionContext completeTransition:YES];
    if ([ZHDisplayTransition sharedInstanced].completion) {
        [ZHDisplayTransition sharedInstanced].completion();
    }
}

- (void)zhTransitionWithStylePresent:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if ([ZHDisplayTransition sharedInstanced].completion) {
            [ZHDisplayTransition sharedInstanced].completion();
        }
    }];
    
}

- (void)zhTransitionWithStylePresentSpring:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if ([ZHDisplayTransition sharedInstanced].completion) {
            [ZHDisplayTransition sharedInstanced].completion();
        }
    }];
    
}

- (void)zhTransitionWithStylePush:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, screenBounds.size.width, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:0.2 animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if ([ZHDisplayTransition sharedInstanced].completion) {
            [ZHDisplayTransition sharedInstanced].completion();
        }
    }];
    
}

- (void)zhTransitionWithStylePushSpring:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, screenBounds.size.width, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if ([ZHDisplayTransition sharedInstanced].completion) {
            [ZHDisplayTransition sharedInstanced].completion();
        }
    }];
    
}

- (void)zhTransitionWithStylePointSpread:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //画两个圆路径
    CGRect pointBounds = CGRectMake(self.spreadPoint.x, self.spreadPoint.y, 1, 1);
    //最初的中心点
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:pointBounds];
    CGFloat x = MAX(pointBounds.origin.x, containerView.frame.size.width - pointBounds.origin.x);
    CGFloat y = MAX(pointBounds.origin.y, containerView.frame.size.height - pointBounds.origin.y);
    //最终圆的半径,勾股定理
    CGFloat radius = sqrtf/*开平方*/(pow(x, 2)/*指数，这里是2次方*/ + pow(y, 2));
    //最终的圆
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)zhTransitionWithStylePage:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //对tempView做动画，避免bug;
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    fromVC.view.hidden = YES;
    [containerView insertSubview:toVC.view atIndex:0];
    //    [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
    CGPoint point = CGPointMake(0, 0.5);
    tempView.frame = CGRectOffset(tempView.frame, (point.x - tempView.layer.anchorPoint.x) * tempView.frame.size.width, (point.y - tempView.layer.anchorPoint.y) * tempView.frame.size.height);
    tempView.layer.anchorPoint = point;
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.001;
    containerView.layer.sublayerTransform = transfrom3d;
    
    /*
     //增加阴影，为了效果好看
     CAGradientLayer *fromGradient = [CAGradientLayer layer];
     fromGradient.frame = fromVC.view.bounds;
     fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
     (id)[UIColor blackColor].CGColor];
     fromGradient.startPoint = CGPointMake(0.0, 0.5);
     fromGradient.endPoint = CGPointMake(0.8, 0.5);
     UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
     fromShadow.backgroundColor = [UIColor clearColor];
     [fromShadow.layer insertSublayer:fromGradient atIndex:1];
     fromShadow.alpha = 0.0;
     [tempView addSubview:fromShadow];
     CAGradientLayer *toGradient = [CAGradientLayer layer];
     toGradient.frame = fromVC.view.bounds;
     toGradient.colors = @[(id)[UIColor blackColor].CGColor,
     (id)[UIColor blackColor].CGColor];
     toGradient.startPoint = CGPointMake(0.0, 0.5);
     toGradient.endPoint = CGPointMake(0.8, 0.5);
     UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
     toShadow.backgroundColor = [UIColor clearColor];
     [toShadow.layer insertSublayer:toGradient atIndex:1];
     toShadow.alpha = 1.0;
     [toVC.view addSubview:toShadow];
     */
    //[self transitionDuration:transitionContext]
    [UIView animateWithDuration:0.5 animations:^{
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        //        fromShadow.alpha = 1.0;
        //        toShadow.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
        if ([ZHDisplayTransition sharedInstanced].completion) {
            [ZHDisplayTransition sharedInstanced].completion();
        }
    }];
}



#pragma mark - CAAnimationDelegate
//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (self.style) {
        case ZHTransitionStylePointSpread:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            if ([ZHDisplayTransition sharedInstanced].completion) {
                [ZHDisplayTransition sharedInstanced].completion();
            }
        }
            break;
        case ZHTransitionStylePointShrink:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
            if ([ZHDisplayTransition sharedInstanced].completion) {
                [ZHDisplayTransition sharedInstanced].completion();
            }
        }
            break;
        default:
            break;
    }
}

@end
