//
//  PresenterOption.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PresenterPresentationPosition) {
    PresenterPresentationPositionCenter,
    PresenterPresentationPositionBottom,
    PresenterPresentationPositionTop,
    PresenterPresentationPositionLeft,
    PresenterPresentationPositionRight
};

typedef NS_ENUM(NSUInteger, PresenterTransitionStyle) {
    PresenterTransitionStyleWithoutAnimation,
    PresenterTransitionStyleCrossDissolve,
    PresenterTransitionStyleFlipHorizontal,
    PresenterTransitionStyleVertical,
    PresenterTransitionStyleVerticalTop,
    PresenterTransitionStyleHorizontalRight,
    PresenterTransitionStyleHorizontalLeft
};

@interface PresenterOption : NSObject

+ (PresenterOption *)defaultOption;

@property (nonatomic, assign) PresenterPresentationPosition presentationPosition;

@property (nonatomic, assign) PresenterTransitionStyle transitionStyle;

@property (nonatomic, assign) PresenterTransitionStyle dismissTransitionStyle;

@property (nonatomic, assign) CGSize presentedViewSize;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, assign) CGFloat backgroundColorOpacity;

@property (nonatomic, assign) BOOL blurBackground;

@property (nonatomic, assign) UIBlurEffectStyle backgroundBlurStyle;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, assign) BOOL dismissOnTap;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) UIRectCorner corners;

- (void)config:(PresenterOption *)newOption;

// chain
// - (PresenterOption* (^)(PresenterPresentationType))presentationType;
// - (PresenterOption* (^)(PresenterTransitionStyle))transitionStyle;
// - (PresenterOption* (^)(PresenterTransitionStyle))dismissTransitionStyle;
// - (PresenterOption* (^)(UIColor*))backgroundColor;
// - (PresenterOption* (^)(CGFloat))backgroundOpacity;
// - (PresenterOption* (^)(UIBlurEffectStyle))backgroundBlurStyle;
// - (PresenterOption* (^)(UIView *))backgroundView;
// - (PresenterOption* (^)(BOOL))dismissOnTap;


@end
