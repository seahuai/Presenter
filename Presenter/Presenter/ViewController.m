//
//  ViewController.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "ViewController.h"
#import "Presenter.h"
#import "PresenterViewController.h"
#import "PresenterViewController+Show.h"
#import "TestViewController.h"

@interface ViewController ()

@property (nonatomic, strong) Presenter *presenter;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ViewController *viewController = [ViewController new];
//    viewController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    _presenter = [Presenter new];
//    _presenter.option.presentedViewSize = CGSizeMake(100, 200);
//    [self.presenter presentViewController:viewController inViewController:self];
    TestViewController *testVC = [[TestViewController alloc] init];
    [testVC showInViewController:self];
//    testVC present
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
