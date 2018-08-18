//
//  PresentationController.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Presenter.h"

@interface PresentationController : UIPresentationController

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
                                   dismissOnTap:(BOOL)dismissOnTap;
// chain
/*
 - (PresentationController* (^)(PresenterPresentationType))presentationType;
 - (PresentationController* (^)(PresenterTransitionStyle))transitionStyle;
 - (PresentationController* (^)(PresenterTransitionStyle))dismissTransitionStyle;
 - (PresentationController* (^)(UIColor*))backgroundColor;
 - (PresentationController* (^)(CGFloat))backgroundOpacity;
 - (PresentationController* (^)(UIBlurEffectStyle))backgroundBlurStyle;
 - (PresentationController* (^)(UIView *))backgroundView;
 - (PresentationController* (^)(BOOL))dismissOnTap;

 */
@end
