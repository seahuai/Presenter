//
//  ViewController.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "ViewController.h"
#import "PresenterManager.h"

@interface ViewController () {
    PresenterManager *_presenterMgr;
    UITextField *_textField;
    UIButton *_dismissButton;
}

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _presenterMgr = [PresenterManager new];
    ViewController *vc = [ViewController new];
    vc.view.backgroundColor = [UIColor darkGrayColor];
    _presenterMgr.option.presentedViewSize = CGSizeMake(200, 400);
    [_presenterMgr presentViewController:vc inViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textField];
    
    _dismissButton = [[UIButton alloc] init];
    [_dismissButton setTitle:@"关闭键盘" forState:UIControlStateNormal];
    [_dismissButton setTintColor:[UIColor redColor]];
    [_dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dismissButton];
    
}

- (void)dismiss {
    [_textField resignFirstResponder];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat w = 160;
    CGFloat h = 44;
    CGFloat x = (self.view.bounds.size.width - w) * 0.5;
    CGFloat y = (self.view.bounds.size.height - h) * 0.5;
    _textField.frame = CGRectMake(x, y, w, h);
    
    _dismissButton.frame = CGRectMake(x, CGRectGetMaxY(_textField.frame) + 20, 100, 30);
}

@end
