//
//  ExampleInputViewController.m
//  Example
//
//  Created by 张思槐 on 2018/8/23.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "ExampleInputViewController.h"

@interface ExampleInputViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_models;
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ExampleInputViewController

- (PresenterOption *)presenterOptionForLandscapeMode:(BOOL)isLandscape {
    PresenterOption *option = [self presenterOption];
    if (isLandscape) {
        option.presentationPosition = PresenterPresentationPositionRight;
        option.transitionStyle = PresenterTransitionStyleHorizontalRight;
        option.corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
        option.cornerRadius = 20;
    }else {
        option.presentationPosition = PresenterPresentationPositionBottom;
        option.transitionStyle = PresenterTransitionStyleVertical;
        option.corners = UIRectCornerTopRight | UIRectCornerTopLeft;
        option.cornerRadius = 20;
    }
    return option;
}

- (CGSize)presentedViewSizeForContainerSize:(CGSize)containerSize {
    if (containerSize.height > containerSize.width) {
        return CGSizeMake(containerSize.width, containerSize.height * 0.5);
    }else {
        return CGSizeMake(containerSize.width * 0.5, containerSize.height);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _models = @[
                @"完成",
                @"收起键盘",
                @"翻转屏幕",
                ];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.textField.frame = CGRectMake(10, 20, self.view.bounds.size.width, 40);
    CGFloat tableViewY = CGRectGetMaxY(self.textField.frame);
    self.tableView.frame = CGRectMake(0, tableViewY, self.view.bounds.size.width, self.view.bounds.size.height - tableViewY);
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = _models[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.row == 0) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else if (indexPath.row == 1) {
        [self.textField resignFirstResponder];
    }else if (indexPath.row == 2) {
        [self changeInterfaceOrientation];
    }
}

- (void)changeInterfaceOrientation {
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        
        UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];
        UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
        if (current == UIInterfaceOrientationLandscapeRight) {
            orientation = UIInterfaceOrientationPortrait;
        }else {
            orientation = UIInterfaceOrientationLandscapeRight;
        }
        NSNumber *orientationTargetNum = [NSNumber numberWithInt:orientation];
        [[UIDevice currentDevice] setValue:orientationTargetNum forKey:@"orientation"];
        [UIApplication sharedApplication].statusBarOrientation = orientation;
        
    }
}

#pragma mark Getter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"input hear";
    }
    return _textField;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}



@end
