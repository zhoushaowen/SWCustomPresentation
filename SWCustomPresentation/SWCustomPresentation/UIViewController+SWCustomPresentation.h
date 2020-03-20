//
//  UIViewController+SWCustomPresentation.h
//  SWCustomPresentaion
//
//  Created by zhoushaowen on 2018/4/9.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWAnimatedTransitioning <NSObject>

@optional

/**
 执行present动画的协议,如果不想自定义动画而采用默认的present动画,不实现这个协议即可
 */
- (void)sw_animateTransitionForPresent:(id<UIViewControllerContextTransitioning>)transitionContext;
/**
 执行dismiss动画的协议,如果不想自定义动画而采用默认的dismiss动画,不实现这个协议即可
 */
- (void)sw_animateTransitionForDismiss:(id<UIViewControllerContextTransitioning>)transitionContext;
@required

/**
 动画时长协议
 */
- (NSTimeInterval)sw_transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

@class SWPresentationController;

@protocol SWPresentationControllerDelegate <NSObject>

@optional

///this method will be invoke after 'sw_presentationController_presentationTransitionWillBegin'  you can change the containerView frame with this method.
- (CGRect)sw_presentationController_frameOfPresentedViewInContainerView:(SWPresentationController *)presentationController;
///you can change the containerView frame with this method.
- (void)sw_presentationController_containerViewWillLayoutSubviews:(SWPresentationController *)presentationController;
///you can change the containerView frame with this method.
- (void)sw_presentationController_containerViewDidLayoutSubviews:(SWPresentationController *)presentationController;

///this method will be invoke first,do not add subView to presentedView with autolayout,because the presentedView's superView is still nil.
- (void)sw_presentationController_presentationTransitionWillBegin:(SWPresentationController *)presentationController;
- (void)sw_presentationController:(SWPresentationController *)presentationController presentationTransitionDidEnd:(BOOL)completed;
- (void)sw_presentationController_dismissalTransitionWillBegin:(SWPresentationController *)presentationController;
- (void)sw_presentationController:(SWPresentationController *)presentationController dismissalTransitionDidEnd:(BOOL)completed;

@end

@interface SWPresentationController : UIPresentationController<UIGestureRecognizerDelegate>

/**
 转场控制器的容器视图上的单击手势,单击可以dismiss控制器,如果不需要禁止掉手势即可
 */
@property (nonatomic,readonly,strong) UITapGestureRecognizer *singleTapGesture;

@end

@interface UIViewController (SWCustomPresentation)<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

/**
模态出一个可以自定义转场动画的控制器

@param presentedController 即将弹出的控制器
@param delegate SWPresentationControllerDelegate
@param animatedTransitioning 负责转场动画的对象
@param completion 动画完成的回调
*/
- (void)sw_presentCustomModalPresentationWithPresentedController:(UIViewController *__nonnull)presentedController delegate:(id<SWPresentationControllerDelegate> __nonnull)delegate animatedTransitioningModel:(id<SWAnimatedTransitioning> __nullable)animatedTransitioning completion:(void(^__nullable)(void))completion;

/**
 模态出一个可以自定义转场动画的控制器

 @param controller 即将弹出的控制器
 @param willLayoutSubViewsBlock 容器视图即将布局子视图的回调
 @param animatedTransitioning 负责转场动画的对象
 @param completion 动画完成的回调
 */
- (void)sw_presentCustomModalPresentationWithViewController:(UIViewController *__nonnull)controller containerViewWillLayoutSubViewsBlock:(void(^__nullable)(SWPresentationController *__nonnull presentationController))willLayoutSubViewsBlock animatedTransitioningModel:(id<SWAnimatedTransitioning> __nullable)animatedTransitioning completion:(void(^__nullable)(void))completion __deprecated_msg("Use 'sw_presentCustomModalPresentationWithPresentedController:delegate:animatedTransitioningModel:completion:'");


@end
