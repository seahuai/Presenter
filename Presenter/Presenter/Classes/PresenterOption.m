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
        _presentationPosition = PresenterPresentationPositionCenter;
        _transitionStyle = PresenterTransitionStyleCrossDissolve;
        _dismissTransitionStyle = PresenterTransitionStyleCrossDissolve;
        _backgroundColor = [UIColor blackColor];
        _backgroundColorOpacity = 0.6f;
        _blurBackground = false;
        _backgroundBlurStyle = UIBlurEffectStyleDark;
        _backgroundView = nil;
        _dismissOnTap = true;
        _cornerRadius = 0;
        _corners = UIRectCornerAllCorners;
    }
    return self;
}

- (void)setTransitionStyle:(PresenterTransitionStyle)transitionStyle {
    _transitionStyle = transitionStyle;
    _dismissTransitionStyle = transitionStyle;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius > 0) {
        _cornerRadius = cornerRadius;
    }
}

- (void)config:(PresenterOption *)newOption {
    if (!newOption) {
        return;
    }
    self.presentationPosition = newOption.presentationPosition;
    self.transitionStyle = newOption.transitionStyle;
    self.dismissTransitionStyle = newOption.dismissTransitionStyle;
    self.backgroundColor = newOption.backgroundColor;
    self.backgroundColorOpacity = newOption.backgroundColorOpacity;
    self.blurBackground = newOption.blurBackground;
    self.backgroundBlurStyle = UIBlurEffectStyleDark;
    self.backgroundView = newOption.backgroundView;
    self.dismissOnTap = newOption.dismissOnTap;
    self.cornerRadius = newOption.cornerRadius;
    self.corners = newOption.corners;
}

@end
