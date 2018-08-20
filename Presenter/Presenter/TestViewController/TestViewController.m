//
//  TestViewController.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UITextField *textField;


@end

@implementation TestViewController

- (PresenterOption *)presenterOption {
    PresenterOption *option = [super presenterOption];
    option.presentationType = PresenterPresentationTypeBottom;
    option.transitionStyle = PresenterTransitionStyleVertical;
    return option;
}

- (CGSize)presentedViewSizeForContainerSize:(CGSize)containerSize {
    return CGSizeMake(containerSize.width, containerSize.height * 0.5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
    }
    return _messageLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
    }
    return _textField;
}

- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [UIButton new];
        [_okButton addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}


- (void)ok {
    
}

@end
