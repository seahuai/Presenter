//
//  Presenter.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "Presenter.h"
#import "PresentationController.h"
#import "PresenterAnimator.h"

@interface Presenter () <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIViewController *presentedViewController;

//@property (nonatomic, weak) UIViewController *presentingViewController;

@end

@implementation Presenter

- (instancetype)init {
    if (self = [super init]) {
        _presentationType = PresenterPresentationTypeCenter;
        _transitionStyle = PresenterTransitionStyleCrossDissolve;
        _dismissTransitionStyle = PresenterTransitionStyleCrossDissolve;
        _backgroundColor = [UIColor blackColor];
        _backgroundColorOpacity = 0.4f;
        _blurBackground = false;
        _backgroundBlurStyle = UIBlurEffectStyleLight;
        _backgroundView = nil;
        _dismissOnTap = true;
    }
    return self;
}

- (void)presentViewController:(UIViewController*)presentedViewController
             inViewController:(UIViewController*)presentingViewController {
    presentedViewController.transitioningDelegate = self;
    presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    BOOL animated = !(self.transitionStyle == PresenterTransitionStyleWithoutAnimated);
    if (presentingViewController) {
        [presentingViewController presentViewController:presentedViewController animated:animated completion:nil];
    }
    // presented on topViewController;
}

- (void)dismiss {
    
}

#pragma mark UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting presentedViewSize:self.presentedViewSize presentationType:self.presentationType transitionStyle:self.transitionStyle dismissTransiotionStyle:self.dismissTransitionStyle backgroundColor:self.backgroundColor backgroundOpacity:self.backgroundColorOpacity blurBackground:self.blurBackground backgroundBlurStyle:self.backgroundBlurStyle backgroundView:self.backgroundView dismissOnTap:self.dismissOnTap];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PresenterAnimator presenterAnimatorForTransitionStyle:self.transitionStyle];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PresenterAnimator presenterAnimatorForTransitionStyle:self.dismissTransitionStyle];
}



@end
