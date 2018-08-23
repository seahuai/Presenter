//
//  TableViewController.m
//  Example
//
//  Created by 张思槐 on 2018/8/20.
//  Copyright © 2018年 张思槐. All rights reserved.
//

#import "TableViewController.h"
#import <Presenter/Presenter.h>

#import "ExampleOneViewController.h"
#import "ExampleTwoViewController.h"
#import "ExampleInputViewController.h"

@interface TableViewController () {
    NSArray *_examples;
    PresenterManager *_presenterMgr;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Example";
    _examples = @[
                  @"Example one",
                  @"Example two",
                  @"Input Example"
                  ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _examples.count;
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
        case 2:
            [self showInputViewController];
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
    option.presentationPosition = PresenterPresentationPositionCenter;
    option.presentedViewSize = CGSizeMake(300, 200);
    option.backgroundColor = [UIColor yellowColor];
    option.backgroundColorOpacity = 0.2;
    _presenterMgr = [[PresenterManager alloc] initWithPresenterOption:option];
    [_presenterMgr presentViewController:vc inViewController:self];
}

// 支持键盘监听
// 支持横竖屏适配
- (void)showInputViewController {
    ExampleInputViewController *vc = [[ExampleInputViewController alloc] init];
    [vc show];
}

@end
