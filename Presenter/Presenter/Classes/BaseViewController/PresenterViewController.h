//
//  PresenterViewController.h
//  Presenter
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterOption.h"

@protocol PresenterViewController

- (PresenterOption *)presenterOption;

- (CGSize)presentedViewSizeForContainerSize:(CGSize)containerSize;

@optional

// 如果实现了该方法，就不会去调用-presentationOption方法
- (PresenterOption *)presenterOptionForLandscapeMode:(BOOL)isLandscape;

@end


@interface PresenterViewController : UIViewController <PresenterViewController>

@end
