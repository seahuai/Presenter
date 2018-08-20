//
//  ExampleOneViewController.m
//  Example
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "ExampleOneViewController.h"

@interface ExampleOneViewController ()

@end

@implementation ExampleOneViewController

- (PresenterOption *)presenterOption {
    // 父类提供了默认实现
    PresenterOption *option = [super presenterOption];
    // 视图的位置
    option.presentationType = PresenterPresentationTypeBottom;
    // transition动画样式， 从底部弹出
    option.transitionStyle = PresenterTransitionStyleVertical;
    
    // dismiss transiton动画样式， 默认与transionStyle一致
    // option.dismissTransitionStyle = PresenterTransitionStyleHorizontalFromLeft;
    
    // 更多属性见 PresenterOption
    
    return option;
}

- (CGSize)presentedViewSizeForContainerSize:(CGSize)containerSize {
    // 弹出半屏弹窗
    return CGSizeMake(containerSize.width, containerSize.height * 0.5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

@end
