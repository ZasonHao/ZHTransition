//
//  ZHBaseTransition.m
//  TEST
//
//  Created by Zason_Hao on 2017/8/23.
//  Copyright © 2017年 郝兆超. All rights reserved.
//

#import "ZHBaseTransition.h"

@implementation ZHBaseTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.0f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    NSLog(@"UIViewControllerContextTransitioning");
}

@end
