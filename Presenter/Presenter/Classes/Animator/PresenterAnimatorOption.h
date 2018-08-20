//
//  PresenterAnimatorOption.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresenterAnimatorOption: NSObject

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) NSTimeInterval delay;

@property (nonatomic, assign) NSTimeInterval damping;

@property (nonatomic, assign) NSTimeInterval velocity;

@property (nonatomic, assign) UIViewAnimationOptions animationOptions;

@end
