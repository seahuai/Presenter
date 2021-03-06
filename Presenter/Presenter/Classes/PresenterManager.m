//
//  Presenter.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterManager.h"
#import "PresentationController.h"
#import "PresenterAnimator.h"
#import "UIViewController+Top.h"

@interface PresenterManager () <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIViewController *presentedViewController;

//@property (nonatomic, weak) UIViewController *presentingViewController;

@end

@implementation PresenterManager

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

- (void)presentViewController:(UIViewController*)presentedViewController {
    [self presentViewController:presentedViewController inViewController:nil];
}

- (void)presentViewController:(UIViewController*)presentedViewController
             inViewController:(UIViewController*)presentingViewController {
    presentedViewController.transitioningDelegate = self;
    presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    BOOL animated = !(self.option.transitionStyle == PresenterTransitionStyleWithoutAnimation);
    if (presentingViewController) {
        [presentingViewController presentViewController:presentedViewController animated:animated completion:nil];
    }else {
        [[UIViewController topViewController] presentViewController:presentedViewController animated:animated completion:nil];
    }
}

- (void)dismiss {
    BOOL animated = !(self.option.dismissTransitionStyle == PresenterTransitionStyleWithoutAnimation);
    if (_presentedViewController) {
        [_presentedViewController dismissViewControllerAnimated:animated completion:nil];
    }
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
