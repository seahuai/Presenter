//
//  PresenterViewController.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "PresenterViewController.h"

@interface PresenterViewController ()

@end

@implementation PresenterViewController

- (PresenterOption *)presenterOption {
    return [PresenterOption defaultOption];
}

// need override
- (CGSize)presentedViewSizeForContainerSize:(CGSize)containerSize {
    // just test data
    BOOL isLandscape = containerSize.width > containerSize.height;
    if (isLandscape) {
        return CGSizeMake(400, 200);
    }else {
        return CGSizeMake(300, 200);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
