//
//  TableViewController.m
//  Example
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "TableViewController.h"
#import <Presenter/SHPresenter.h>

#import "ExampleOneViewController.h"
#import "ExampleTwoViewController.h"

@interface TableViewController () {
    NSArray *_examples;
    Presenter *_presenter;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Example";
    _examples = @[@"Example one",
                  @"Example two" ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExampleCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExampleCell"];
    }
    cell.textLabel.text = _examples[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    switch (indexPath.row) {
        case 0:
            [self showViewController];
            break;
        case 1:
            [self presentViewController];
            break;
        default:
            break;
    }
}

// 推荐：可以对横竖屏进行配置，调用更方便
// 继承PresenterViewController
// 使用协议方进行配置
// 调用 -show 方法
- (void)showViewController {
    ExampleOneViewController *vc = [[ExampleOneViewController alloc] init];
    [vc showInViewController:self];
}

// 使用PresenterOption配置
// 使用Presenter的 -present 方法弹出
// presenter 需要被强引用
- (void)presentViewController {
    ExampleTwoViewController *vc = [[ExampleTwoViewController alloc] init];
    PresenterOption *option = [PresenterOption new];
    option.presentationType = PresenterPresentationTypeCenter;
    option.presentedViewSize = CGSizeMake(300, 200);
    option.backgroundColor = [UIColor yellowColor];
    option.backgroundColorOpacity = 0.2;
    _presenter = [[Presenter alloc] initWithPresenterOption:option];
    [_presenter presentViewController:vc inViewController:self];
}

@end
