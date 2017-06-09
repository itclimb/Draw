//
//  ViewController.m
//  Draw
//
//  Created by itclimb on 14/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "ViewController.h"
#import "DemoController.h"
#import "huView.h"

@interface ViewController ()

@property(nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _datas = @[
               @{
                   @"text":@"测试"
                   },
               @{
                   @"text":@"弧形"
                   },
               @{
                   @"text":@"进度条"
                   },
               @{
                   @"text":@"柱状形"
                   },
               @{
                   @"text":@"直线"
                   },
               @{
                   @"text":@"图片和文字绘制"
                   },
               @{
                   @"text":@"自定义图片框"
                   },
               @{
                   @"text":@"截屏"
                   },
               @{
                   @"text":@"解锁"
                   },
               @{
                   @"text":@"时钟"
                   }
               ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = _datas[indexPath.row][@"text"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoController *vc = [[DemoController alloc] init];
    vc.type = (int)indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
