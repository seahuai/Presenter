//
//  Presenter.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterOption.h"

@interface Presenter : NSObject

@property (nonatomic, strong) PresenterOption *option;

- (instancetype)initWithPresenterOption:(PresenterOption *)option;

// 暂时对外暴露
- (void)presentViewController:(UIViewController*)presentedViewController
             inViewController:(UIViewController*)presentingViewController;

@end
