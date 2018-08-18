//
//  PresenterTransitionContext.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresenterTransitionContext : NSObject

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, assign) CGRect initialFrame;

@property (nonatomic, assign) CGRect finalFrame;

@property (nonatomic, assign) BOOL isPresenting;

@property (nonatomic, strong) UIViewController *fromViewController;

@property (nonatomic, strong) UIViewController *toViewController;

@property (nonatomic, strong) UIView *fromView;

@property (nonatomic, strong) UIView *toView;

@property (nonatomic, strong) UIViewController *animatingViewController;

@property (nonatomic, strong) UIView *animatingView;

@end
