//
//  PresenterOption.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterOption.h"

@implementation PresenterOption

+ (PresenterOption *)defaultOption {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _presentationType = PresenterPresentationTypeCenter;
        _transitionStyle = PresenterTransitionStyleCrossDissolve;
        _dismissTransitionStyle = PresenterTransitionStyleCrossDissolve;
        _backgroundColor = [UIColor blackColor];
        _backgroundColorOpacity = 0.6f;
        _blurBackground = false;
        _backgroundBlurStyle = UIBlurEffectStyleDark;
        _backgroundView = nil;
        _dismissOnTap = true;
    }
    return self;
}

@end
