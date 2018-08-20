//
//  PresenterAnimatorOption.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterAnimatorOption.h"

@implementation PresenterAnimatorOption

- (instancetype)init
{
    self = [super init];
    if (self) {
        _duration = 0;
        _delay = 0;
        _damping = 1;
        _velocity = 1;
        _animationOptions = UIViewAnimationOptionTransitionNone;
    }
    return self;
}

@end
