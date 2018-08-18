//
//  PresenterAnimator.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Presenter.h"
#import "PresenterTransitionContext.h"
#import "PresenterAnimatorOption.h"

@interface PresenterAnimator : NSObject

@property (nonatomic, strong) PresenterAnimatorOption *option;

// factory
+ (id<UIViewControllerAnimatedTransitioning>)presenterAnimatorForTransitionStyle:(PresenterTransitionStyle)transitionStyle;

- (CGRect)caculateInitialFrameWithContainerFrame:(CGRect)containerFrame finalFrame:(CGRect)finalFrame;

- (void)beforeAnimationWithContext:(PresenterTransitionContext *)context;

- (void)afterAnimationWithContext:(PresenterTransitionContext *)context;

- (void)performAnimationWithContext:(PresenterTransitionContext *)context;

@end
