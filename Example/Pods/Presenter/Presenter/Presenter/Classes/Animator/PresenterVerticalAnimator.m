//
//  PresenterVerticalAnimator.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterVerticalAnimator.h"

@interface PresenterVerticalAnimator () {
    BOOL _fromTop;
}
@end

@implementation PresenterVerticalAnimator

- (instancetype)initFromTop:(BOOL)fromTop {
    if (self = [super init]) {
        _fromTop = fromTop;
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
    if (_fromTop) {
        initialFrame.origin.y = -finalFrame.size.height;
    }else {
        initialFrame.origin.y = containerFrame.size.height + finalFrame.size.height;
    }
    return initialFrame;
}



@end
