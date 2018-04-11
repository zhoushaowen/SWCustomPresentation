//
//  UIViewController+SWCustomPresentation.m
//  SWCustomPresentaion
//
//  Created by zhoushaowen on 2018/4/9.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "UIViewController+SWCustomPresentation.h"
#import <objc/runtime.h>

@interface SWPresentationController ()

@property (nonatomic,strong) void(^willLayoutSubViewsBlock)(SWPresentationController *);

@end

@implementation SWPresentationController

@synthesize singleTapGesture = _singleTapGesture;

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    if(self.singleTapGesture.view == nil){
        [self.containerView addGestureRecognizer:self.singleTapGesture];
    }
    CGRect rect = self.presentedView.frame;
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    rect.size.width = self.containerView.bounds.size.width - 80;
    rect.size.height = self.containerView.bounds.size.height - 100;
    rect.origin.x = (self.containerView.bounds.size.width - rect.size.width)/2.0f;
    rect.origin.y = (self.containerView.bounds.size.height - rect.size.height)/2.0f;
    self.presentedView.frame = rect;
    if(self.willLayoutSubViewsBlock){
        self.willLayoutSubViewsBlock(self);
    }
}

- (UITapGestureRecognizer *)singleTapGesture {
    if(!_singleTapGesture){
        _singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        _singleTapGesture.delegate = self;
    }
    return _singleTapGesture;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(touch.view != gestureRecognizer.view) return NO;
    return YES;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end


static void *Key_sw_presentationController = &Key_sw_presentationController;
static void *Key_containerViewWillLayoutSubViewsBlock = &Key_containerViewWillLayoutSubViewsBlock;
static void *Key_containerViewDidLayoutSubViewsBlock = &Key_containerViewDidLayoutSubViewsBlock;
static void *Key_sw_animatedTransitioning = &Key_sw_animatedTransitioning;

@interface UIViewController ()

@property (nonatomic,strong) void(^containerViewWillLayoutSubViewsBlock)(SWPresentationController *);
@property (nonatomic,strong) id<SWAnimatedTransitioning> sw_animatedTransitioning;

@end

@implementation UIViewController (SWCustomPresentation)

- (void)sw_presentCustomModalPresentationWithViewController:(UIViewController *__nonnull)controller containerViewWillLayoutSubViewsBlock:(void(^__nullable)(SWPresentationController *__nonnull presentationController))willLayoutSubViewsBlock animatedTransitioningModel:(id<SWAnimatedTransitioning> __nullable)animatedTransitioning completion:(void(^__nullable)(void))completion {
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self;
    self.containerViewWillLayoutSubViewsBlock = willLayoutSubViewsBlock;
    self.sw_animatedTransitioning = animatedTransitioning;
    [self presentViewController:controller animated:YES completion:completion];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    SWPresentationController *presentationController = [[SWPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationController.willLayoutSubViewsBlock = self.containerViewWillLayoutSubViewsBlock;
    return presentationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if(self.sw_animatedTransitioning && [self.sw_animatedTransitioning respondsToSelector:@selector(sw_animateTransitionForPresent:)]) return self.sw_animatedTransitioning;
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if(self.sw_animatedTransitioning && [self.sw_animatedTransitioning respondsToSelector:@selector(sw_animateTransitionForDismiss:)]) return self.sw_animatedTransitioning;
    return nil;
}

#pragma mark - Getter&Setter
- (void)setContainerViewWillLayoutSubViewsBlock:(void (^)(SWPresentationController *))containerViewWillLayoutSubViewsBlock {
    objc_setAssociatedObject(self, Key_containerViewWillLayoutSubViewsBlock, containerViewWillLayoutSubViewsBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(SWPresentationController *))containerViewWillLayoutSubViewsBlock {
    return objc_getAssociatedObject(self, Key_containerViewWillLayoutSubViewsBlock);
}

- (void)setSw_animatedTransitioning:(id<SWAnimatedTransitioning>)sw_animatedTransitioning {
    objc_setAssociatedObject(self, Key_sw_animatedTransitioning, sw_animatedTransitioning, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<SWAnimatedTransitioning>)sw_animatedTransitioning {
    return objc_getAssociatedObject(self, Key_sw_animatedTransitioning);
}














@end
