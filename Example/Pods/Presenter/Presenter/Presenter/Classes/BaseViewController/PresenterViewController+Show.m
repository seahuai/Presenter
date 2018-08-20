//
//  PresenterViewController+Show.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterViewController+Show.h"
#import "Presenter.h"
#import <objc/runtime.h>

@implementation PresenterViewController (Show)

- (Presenter *)innerPresenter {
    Presenter *_presenter = objc_getAssociatedObject(self, @selector(innerPresenter));
    if (!_presenter) {
        _presenter = [[Presenter alloc] initWithPresenterOption:self.presenterOption];
        objc_setAssociatedObject(self, @selector(innerPresenter), _presenter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _presenter;
}

- (void)showInViewController:(UIViewController *)viewController {
    [self.innerPresenter presentViewController:self inViewController:viewController];
}

@end
