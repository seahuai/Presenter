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
        [self registerKeyboardNotification];
    }
    return self;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                              presentedViewSize:(CGSize)presentedViewSize
                               presentationPosition:(PresenterPresentationPosition)presentationPosition
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
    option.presentationPosition = presentationPosition;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 判断有没有遮挡
    CGRect intersectionRect = CGRectIntersection(self.presentedView.frame, keyboardEndFrame);
    if (!CGRectEqualToRect(intersectionRect, CGRectZero)) {
        CGRect frame = self.presentedView.frame;
        frame.origin.y -= intersectionRect.size.height;
        [UIView animateWithDuration:duration animations:^{
            self.presentedView.frame = frame;
        } completion:nil];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.presentedView.frame = [self presentedViewFrame];
    } completion:nil];
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
    [self.presentedView endEditing:true];
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
//    if ([self.presentedViewController conformsToProtocol:@protocol(PresenterViewController)]) {
//        id<PresenterViewController> vc = (id<PresenterViewController>)self.presentedViewController;
//        _presentedViewSize = [vc presentedViewSizeForContainerSize:size];
//    }
}

- (CGPoint)presentedViewOrigin {
    CGPoint origin = CGPointZero;
    CGSize containerSize = self.containerView.frame.size;
    
    if ([self.presentedViewController conformsToProtocol:@protocol(PresenterViewController)]) {
        id<PresenterViewController> vc = (id<PresenterViewController>)self.presentedViewController;
        _presentedViewSize = [vc presentedViewSizeForContainerSize:containerSize];
    }
    
    if (self.option.presentationPosition == PresenterPresentationPositionCenter) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5,
                             (containerSize.height - _presentedViewSize.height) * 0.5);
        
    }else if (self.option.presentationPosition == PresenterPresentationPositionBottom) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5,
                             containerSize.height - _presentedViewSize.height);
        
    }else if (self.option.presentationPosition == PresenterPresentationPositionTop) {
        
        origin = CGPointMake((containerSize.width - _presentedViewSize.width) * 0.5, 0);
        
    }else if (self.option.presentationPosition == PresenterPresentationPositionLeft) {
        
        origin = CGPointMake(0, (containerSize.height - _presentedViewSize.height) * 0.5);
        
        
    }else if (self.option.presentationPosition == PresenterPresentationPositionRight) {
        
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
