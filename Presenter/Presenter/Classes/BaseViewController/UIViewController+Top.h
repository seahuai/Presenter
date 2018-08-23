//
//  UIViewController+Top.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/23.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Top)

- (UIViewController *)topViewController;

+ (UIViewController *)topViewController;

+ (UIViewController *)topViewControllerOfViewController:(UIViewController *)viewController;

@end
