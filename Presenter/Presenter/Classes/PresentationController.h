//
//  PresentationController.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterOption.h"

@interface PresentationController : UIPresentationController

@property (nonatomic, strong, readonly) PresenterOption *option;


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                                presenterOption:(PresenterOption *)presenterOption;

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
                                   dismissOnTap:(BOOL)dismissOnTap;

@end
