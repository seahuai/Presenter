//
//  PresenterHorizontalAnimator.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterHorizontalAnimator.h"

@interface PresenterHorizontalAnimator () {
    BOOL _fromLeft;
}
@end

@implementation PresenterHorizontalAnimator

- (instancetype)initFromLeft:(BOOL)fromLeft {
    if (self = [super init]) {
        _fromLeft = fromLeft;
    }
    return self;
}

- (PresenterAnimatorOption *)option {
    PresenterAnimatorOption *option = [super option];
    option.duration = 0.5;
    return option;
}

- (CGRect)caculateInitialFrameWithContainerFrame:(CGRect)containerFrame finalFrame:(CGRect)finalFrame {
    CGRect initialFrame = finalFrame;
    if (_fromLeft) {
        initialFrame.origin.x = -finalFrame.size.width;
    }else {
        initialFrame.origin.x = containerFrame.size.width + finalFrame.size.width;
    }
    return initialFrame;
}


@end
