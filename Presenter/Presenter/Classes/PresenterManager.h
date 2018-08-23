//
//  Presenter.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterOption.h"

@interface PresenterManager : NSObject

@property (nonatomic, strong) PresenterOption *option;

- (instancetype)initWithPresenterOption:(PresenterOption *)option;

- (void)presentViewController:(UIViewController*)presentedViewController
             inViewController:(UIViewController*)presentingViewController;

- (void)presentViewController:(UIViewController*)presentedViewController;

- (void)dismiss;

@end
