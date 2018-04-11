//
//  ViewController.m
//  SWCustomPresentaion
//
//  Created by zhoushaowen on 2018/4/9.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"
#import "SWCustomPresentation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)presentAction:(UIButton *)sender {
    PresentViewController *vc = [PresentViewController new];
    [self sw_presentCustomModalPresentationWithViewController:vc containerViewWillLayoutSubViewsBlock:nil animatedTransitioningModel:nil completion:nil];
}

- (IBAction)presentAction2:(UIButton *)sender {
    PresentViewController *vc = [PresentViewController new];
    [self sw_presentCustomModalPresentationWithViewController:vc containerViewWillLayoutSubViewsBlock:^(SWPresentationController *presentationController) {
        presentationController.singleTapGesture.enabled = NO;
        CGRect rect = presentationController.presentedView.frame;
        rect.size.width = 300;
        rect.size.height = 400;
        rect.origin.x = (presentationController.containerView.bounds.size.width - rect.size.width)/2.0f;
        rect.origin.y = (presentationController.containerView.bounds.size.height - rect.size.height)/2.0f;
        presentationController.presentedView.frame = rect;
        presentationController.presentedView.layer.cornerRadius = 10;
    } animatedTransitioningModel:[SWAnimtedTransitioningModel new] completion:nil];
}





@end
