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

- (instancetype)initWithPresenterOption:(PresenterOption *)option {
    if (self = [super init]) {
        _option = option;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _option = [PresenterOption defaultOption];
    }
    return self;
}

- (void)presentViewController:(UIViewController*)presentedViewController
             inViewController:(UIViewController*)presentingViewController {
    presentedViewController.transitioningDelegate = self;
    presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    BOOL animated = !(self.option.transitionStyle == PresenterTransitionStyleWithoutAnimation);
    if (presentingViewController) {
        [presentingViewController presentViewController:presentedViewController animated:animated completion:nil];
    }
    // presented on topViewController;
}

- (void)dismiss {
    BOOL animated = !(self.option.dismissTransitionStyle == PresenterTransitionStyleWithoutAnimation);
    if (_presentedViewController) {
        [_presentedViewController dismissViewControllerAnimated:animated completion:nil];
    }
    // call topViewController dismiss method
}

#pragma mark UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[PresentationController alloc] initWithPresentedViewController:presented
                                                  presentingViewController:presenting
                                                           presenterOption:self.option];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PresenterAnimator presenterAnimatorForTransitionStyle:self.option.transitionStyle];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PresenterAnimator presenterAnimatorForTransitionStyle:self.option.dismissTransitionStyle];
}



@end
