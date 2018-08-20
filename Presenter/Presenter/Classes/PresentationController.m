//
//  PresentationController.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresentationController.h"

@interface PresentationController () {
    PresenterPresentationType _presentationType;
    PresenterTransitionStyle _transitionStyle;
    PresenterTransitionStyle _dismissTransitionStyle;
    UIView *_backgroundView;
    UIVisualEffectView *_visualEffectView;
    CGSize _presentedViewSize;
}

@end

@implementation PresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                              presentedViewSize:(CGSize)presentedViewSize
                               presentationType:(PresenterPresentationType)presentationType
                                transitionStyle:(PresenterTransitionStyle)transitionStyle
                        dismissTransiotionStyle:(PresenterTransitionStyle)dismissTransitionStyle
                                backgroundColor:(UIColor *)backgroundColor
                              backgroundOpacity:(CGFloat)backgroundOpacity
                                 blurBackground:(BOOL)isBlurBackground
                            backgroundBlurStyle:(UIBlurEffectStyle)backgroundBlurStyle
                                 backgroundView:(UIView *)backgroundView
                                   dismissOnTap:(BOOL)dismissOnTap
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _presentationType = presentationType;
        _transitionStyle = transitionStyle;
        _dismissTransitionStyle = dismissTransitionStyle;
        _backgroundView = backgroundView;
        _presentedViewSize = presentedViewSize;
        if (!backgroundView) {
            [self setupBackgrounWithColor:backgroundColor opacity:backgroundOpacity blurBackground:isBlurBackground blurStyle:backgroundBlurStyle dismissOnTap:dismissOnTap];
        }
        
    }
    return self;
}

#pragma mark BackgroundView

- (void)setupBackgrounWithColor:(UIColor *)bgColor
                        opacity:(CGFloat)bgOpacity
                 blurBackground:(BOOL)isBlurBackground
                      blurStyle:(UIBlurEffectStyle)blurStyle
                   dismissOnTap:(BOOL)dismissOnTap
{
    _backgroundView = [UIView new];
    if (isBlurBackground) {
        UIBlurEffect *visualEffect = [UIBlurEffect effectWithStyle:blurStyle];
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
        [_backgroundView addSubview:_visualEffectView];
    }else {
        _backgroundView.backgroundColor = [bgColor colorWithAlphaComponent:bgOpacity];
    }
    
    if (dismissOnTap) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped:)];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
    }
}


#pragma mark KeyboardNotification
- (void)registerKeyboardNotification {
    
}

- (void)handleKeyboardNotification:(NSNotification *)notification {
    
}

#pragma mark Presentation

- (void)containerViewDidLayoutSubviews {
    _backgroundView.frame = self.containerView.bounds;
    _visualEffectView.frame = self.containerView.bounds;
    self.presentedView.frame = [self presentedViewFrame];
    
}

- (void)presentationTransitionWillBegin {
    if (!self.containerView) {
        return;
    }
    _backgroundView.frame = self.containerView.bounds;
    [self.containerView addSubview:_backgroundView];
    [self.containerView addSubview:self.presentedView];
    _backgroundView.alpha = 0;
    
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (!coordinator) {
        _backgroundView.alpha = 1;
        return;
    }
    
    if (_transitionStyle == PresenterTransitionStyleWithoutAnimation) {
        _backgroundView.alpha = 1;
    }else {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self->_backgroundView.alpha = 1;
        } completion:nil];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [_backgroundView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (!coordinator) {
        _backgroundView.alpha = 0;
        return;
    }
    if (_dismissTransitionStyle == PresenterTransitionStyleWithoutAnimation) {
        _backgroundView.alpha = 0;
    }else {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self->_backgroundView.alpha = 0;
        } completion:nil];
    }
}

- (CGPoint)presentedViewOrigin {
    CGPoint origin = CGPointZero;
    CGSize containerSize = self.containerView.frame.size;
    
    if (_presentationType == PresenterPresentationTypeCenter) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5,
                             (containerSize.height - _presentedViewSize.height) * 0.5);
        
    }else if (_presentationType == PresenterPresentationTypeBottom) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5,
                             containerSize.height - _presentedViewSize.height);
        
    }else if (_presentationType == PresenterPresentationTypeTop) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5, 0);
        
    }else if (_presentationType == PresenterPresentationTypeLeft) {
        
        origin = CGPointMake(0, (containerSize.height - _presentedViewSize.height) * 0.5);
        
        
    }else if (_presentationType == PresenterPresentationTypeRight) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width),
                             (containerSize.height - _presentedViewSize.height) * 0.5);
    }
    return origin;
}

- (CGRect)presentedViewFrame {
    CGPoint origin  = [self presentedViewOrigin];
    return CGRectMake(origin.x, origin.y, _presentedViewSize.width, _presentedViewSize.height);
}

#pragma mark Action
- (void)backgroundViewTapped:(UITapGestureRecognizer *)gestureRecognize {
    BOOL dismissAnimated = !(_dismissTransitionStyle == PresenterTransitionStyleWithoutAnimation);
    [self.presentedViewController dismissViewControllerAnimated:dismissAnimated completion:nil];
}


@end
