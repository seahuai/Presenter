//
//  PresenterViewController+Show.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterViewController+Show.h"
#import "PresenterManager.h"
#import "UIViewController+Top.h"
#import <objc/runtime.h>

@implementation PresenterViewController (Show)

- (PresenterManager *)innerPresenterManager {
    PresenterManager *_presenterMgr = objc_getAssociatedObject(self, @selector(innerPresenterManager));
    if (!_presenterMgr) {
        _presenterMgr = [[PresenterManager alloc] initWithPresenterOption:self.presenterOption];
        objc_setAssociatedObject(self, @selector(innerPresenterManager), _presenterMgr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _presenterMgr;
}

- (void)showInViewController:(UIViewController *)viewController {
    if (viewController) {
        [self.innerPresenterManager presentViewController:self inViewController:viewController];
    }else {
        [self.innerPresenterManager presentViewController:self inViewController:[UIViewController topViewController]];
    }
}

- (void)show {
    [self showInViewController:nil];
}

- (void)hide {
    [self.innerPresenterManager dismiss];
}

@end
