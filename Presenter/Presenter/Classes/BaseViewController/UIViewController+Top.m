//
//  UIViewController+Top.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/23.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "UIViewController+Top.h"

@implementation UIViewController (Top)

- (UIViewController *)topViewController {
    return [UIViewController topViewControllerOfViewController:self];
}

+ (UIViewController *)topViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self topViewControllerOfViewController:rootViewController];
}

+ (UIViewController *)topViewControllerOfViewController:(UIViewController *)rootViewController {
    if (rootViewController.presentedViewController && ![rootViewController.presentedViewController isKindOfClass:[UIAlertController class]]) {
        return [rootViewController.presentedViewController topViewController];
    }
    
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        if (navigationController.viewControllers.count >= 1) {
            return [[navigationController.viewControllers lastObject] topViewController];
        }else {
            return navigationController;
        }
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.selectedViewController topViewController];
    }
    
    return rootViewController;
}

@end
