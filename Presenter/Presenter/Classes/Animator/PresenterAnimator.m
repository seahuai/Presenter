//
//  PresenterAnimator.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterAnimator.h"
#import "PresenterCrossDissolveAnimator.h"
#import "PresenterFlipHorizontalAnimator.h"
#import "PresenterVerticalAnimator.h"
#import "PresenterHorizontalAnimator.h"

@interface PresenterAnimator () <UIViewControllerAnimatedTransitioning>

@end

@implementation PresenterAnimator

+ (id<UIViewControllerAnimatedTransitioning>)presenterAnimatorForTransitionStyle:(PresenterTransitionStyle)transitionStyle {
    switch (transitionStyle) {
        case PresenterTransitionStyleCrossDissolve:
            
            return [PresenterCrossDissolveAnimator new];
            
        case PresenterTransitionStyleFlipHorizontal:
            
            return [PresenterFlipHorizontalAnimator new];
            
        case PresenterTransitionStyleVertical:
            
            return [[PresenterVerticalAnimator alloc] initFromTop:false];
            
        case PresenterTransitionStyleVerticalFromTop:
            
            return [[PresenterVerticalAnimator alloc] initFromTop:true];
            
        case PresenterTransitionStyleHorizontalFromRight:
            
            return [[PresenterHorizontalAnimator alloc] initFromLeft:false];
            
        case PresenterTransitionStyleHorizontalFromLeft:
            
            return [[PresenterHorizontalAnimator alloc] initFromLeft:true];
            

            
        default:
            return nil;
    }
}

//need override
- (PresenterAnimatorOption *)option {
    if (!_option) {
        _option = [PresenterAnimatorOption new];
    }
    return _option;
}


- (CGRect)caculateInitialFrameWithContainerFrame:(CGRect)containerFrame finalFrame:(CGRect)finalFrame {
    CGRect initialFrame = finalFrame;
    initialFrame.origin.y = containerFrame.size.height + finalFrame.size.height;
    return initialFrame;
}

- (void)beforeAnimationWithContext:(PresenterTransitionContext *)context {
    CGRect finalFrameForVC = context.finalFrame;
    CGRect initialFrameForVC = [self caculateInitialFrameWithContainerFrame:context.containerView.frame finalFrame:context.finalFrame];
    CGRect initialFrame = context.isPresenting ? initialFrameForVC : finalFrameForVC;
    context.animatingView.frame = initialFrame;
}

- (void)performAnimationWithContext:(PresenterTransitionContext *)context {
    CGRect finalFrameForVC = context.finalFrame;
    CGRect initialFrameForVC = [self caculateInitialFrameWithContainerFrame:context.containerView.frame finalFrame:context.finalFrame];
    CGRect finalFrame = context.isPresenting ? finalFrameForVC : initialFrameForVC;
    context.animatingView.frame = finalFrame;
}

- (void)afterAnimationWithContext:(PresenterTransitionContext *)context {
    
}

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.option.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    UIViewController *animatingViewController = isPresenting ? toViewController : fromViewController;
    UIView *animatingView = isPresenting ? toView : fromView;
    CGRect initialFrame = [transitionContext initialFrameForViewController:animatingViewController];
    CGRect finalFrame = [transitionContext finalFrameForViewController:animatingViewController];
    
    PresenterTransitionContext *context = [PresenterTransitionContext new];
    context.containerView = containerView;
    context.isPresenting = isPresenting;
    context.initialFrame = initialFrame;
    context.finalFrame = finalFrame;
    context.fromViewController = fromViewController;
    context.toViewController = toViewController;
    context.fromView = fromView;
    context.toView = toView;
    context.animatingViewController = animatingViewController;
    context.animatingView = animatingView;
    
    if (isPresenting) {
        [containerView addSubview:toView];
    }
    
    [self beforeAnimationWithContext:context];
    [UIView animateWithDuration:self.option.duration
                          delay:self.option.delay
         usingSpringWithDamping:self.option.damping
          initialSpringVelocity:self.option.velocity
                        options:self.option.animationOptions
                     animations:^{
                         [self performAnimationWithContext:context];
                     } completion:^(BOOL finished) {
                         [self afterAnimationWithContext:context];
                         [transitionContext completeTransition:!(transitionContext.transitionWasCancelled)];
                     }];
    
}



@end
