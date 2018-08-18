//
//  PresenterCrossDissolveAnimator.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterCrossDissolveAnimator.h"

@implementation PresenterCrossDissolveAnimator

- (PresenterAnimatorOption *)option {
    PresenterAnimatorOption *option = [super option];
    option.duration = 0.4;
    return option;
}

- (void)beforeAnimationWithContext:(PresenterTransitionContext *)context {
    context.animatingView.alpha = context.isPresenting ? 0.0 : 1.0;
}

- (void)performAnimationWithContext:(PresenterTransitionContext *)context {
    context.animatingView.alpha = context.isPresenting ? 1.0 : 0.0;
}

- (void)afterAnimationWithContext:(PresenterTransitionContext *)context {
    context.animatingView.alpha = 1.0;
}

@end
