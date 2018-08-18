//
//  ViewController.m
//  Presenter
//
//  Created by 张思槐 on 2018/8/18.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "ViewController.h"
#import "Presenter.h"

@interface ViewController ()

@property (nonatomic, strong) Presenter *presenter;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController *viewController = [ViewController new];
    viewController.view.backgroundColor = [UIColor redColor];
    
    _presenter = [Presenter new];
    self.presenter.presentedViewSize = CGSizeMake(100, 200);
    self.presenter.backgroundColor = [UIColor lightGrayColor];
    self.presenter.presentationType = PresenterPresentationTypeBottom;
    [self.presenter presentViewController:viewController inViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
