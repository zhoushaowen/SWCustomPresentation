//
//  SWAnimtedTransitioningModel.m
//  SWCustomPresentaion
//
//  Created by zhoushaowen on 2018/4/9.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWAnimtedTransitioningModel.h"

@implementation SWAnimtedTransitioningModel

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if([self respondsToSelector:@selector(sw_transitionDuration:)]){
        return [self sw_transitionDuration:transitionContext];
    }
    return 0.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    if(toView){//present
        if([self respondsToSelector:@selector(sw_animateTransitionForPresent:)]){
            [self sw_animateTransitionForPresent:transitionContext];
        }
    }else if (fromView){//dismiss
        if([self respondsToSelector:@selector(sw_animateTransitionForDismiss:)]){
            [self sw_animateTransitionForDismiss:transitionContext];
        }
    }
}

- (void)sw_animateTransitionForPresent:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    toView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    toView.alpha = 0;
    toView.userInteractionEnabled = NO;
    [UIView animateWithDuration:[self sw_transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        toView.alpha = 1.0;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        toView.userInteractionEnabled = YES;
    }];
}

- (void)sw_animateTransitionForDismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:[self sw_transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        containerView.backgroundColor = [UIColor clearColor];
        fromView.alpha = 0;
        fromView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)sw_transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}



@end
