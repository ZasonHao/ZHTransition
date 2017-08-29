//
//  ZHBaseTransition.m
//
//  Created by Zason_Hao
//
//  E-mail:zason_hao@aliyun.com

#import "ZHBaseTransition.h"

@implementation ZHBaseTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.0f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    NSLog(@"UIViewControllerContextTransitioning");
}

@end
