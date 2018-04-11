# SWCustomPresentation
封装modal转场动画

导入方式:

##pod 'SWCustomPresentation'## 

截图 

![](https://github.com/zhoushaowen/SWCustomPresentation/blob/master/screenshot/1.gif?raw=true)

使用方式:

`- (void)sw_presentCustomModalPresentationWithViewController:(UIViewController *)controller containerViewWillLayoutSubViewsBlock:(void(^__nullable)(SWPresentationController *presentationController))willLayoutSubViewsBlock animatedTransitioningModel:(id<SWAnimatedTransitioning> __nullable)animatedTransitioning completion:(void(^__nullable)(void))completion;
`