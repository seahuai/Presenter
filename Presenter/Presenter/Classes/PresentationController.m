//
//  PresentationController.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresentationController.h"
#import "PresenterViewController.h"

@interface PresentationController () {
    UIView *_backgroundView;
    UIVisualEffectView *_visualEffectView;
    CGSize _presentedViewSize;
}

@property (nonatomic, strong) PresenterOption *option;

@end

@implementation PresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                                presenterOption:(PresenterOption *)option {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _option = option;
        _presentedViewSize = self.option.presentedViewSize;
        _backgroundView = option.backgroundView;
        if (!_backgroundView) {
            [self setupBackgrounWithColor:option.backgroundColor
                                  opacity:option.backgroundColorOpacity
                           blurBackground:option.blurBackground
                                blurStyle:option.backgroundBlurStyle
                             dismissOnTap:option.dismissOnTap];
        }
    }
    return self;
}

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
    
    PresenterOption *option = [PresenterOption defaultOption];
    option.presentationType = presentationType;
    option.transitionStyle = transitionStyle;
    option.dismissTransitionStyle = dismissTransitionStyle;
    option.backgroundColor = backgroundColor;
    option.backgroundColorOpacity = backgroundOpacity;
    option.blurBackground = isBlurBackground;
    option.backgroundBlurStyle = backgroundBlurStyle;
    option.backgroundView = backgroundView;
    option.dismissOnTap = dismissOnTap;
    return [self initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController presenterOption:option];
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
    
    if (self.option.transitionStyle == PresenterTransitionStyleWithoutAnimation) {
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
    if (self.option.transitionStyle == PresenterTransitionStyleWithoutAnimation) {
        _backgroundView.alpha = 0;
    }else {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self->_backgroundView.alpha = 0;
        } completion:nil];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    BOOL isLandscape = size.width > size.height;
    if ([self.presentedViewController conformsToProtocol:@protocol(PresenterViewController)]) {
        
    }
}

- (CGPoint)presentedViewOrigin {
    CGPoint origin = CGPointZero;
    CGSize containerSize = self.containerView.frame.size;
    
    if (self.option.presentationType == PresenterPresentationTypeCenter) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5,
                             (containerSize.height - _presentedViewSize.height) * 0.5);
        
    }else if (self.option.presentationType == PresenterPresentationTypeBottom) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5,
                             containerSize.height - _presentedViewSize.height);
        
    }else if (self.option.presentationType == PresenterPresentationTypeTop) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5, 0);
        
    }else if (self.option.presentationType == PresenterPresentationTypeLeft) {
        
        origin = CGPointMake(0, (containerSize.height - _presentedViewSize.height) * 0.5);
        
        
    }else if (self.option.presentationType == PresenterPresentationTypeRight) {
        
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
    BOOL dismissAnimated = !(self.option.transitionStyle == PresenterTransitionStyleWithoutAnimation);
    [self.presentedViewController dismissViewControllerAnimated:dismissAnimated completion:nil];
}


@end
