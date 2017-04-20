//
//  DemoController.m
//  Draw
//
//  Created by itclimb on 19/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "DemoController.h"
#import "Masonry.h"
#import "huView.h"
#import "hu1View.h"
#import "zhuView.h"

@interface DemoController ()

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *baseView;
    switch (self.type) {
        case kDemoFuncHu:
            baseView = [huView sharedhuView];
            break;
        case kDemoFuncHu1:
            baseView = [[hu1View alloc] init];
            break;
        case kDemoFuncZhu:
            baseView = [zhuView sharedzhuView];
            break;
        default:
            break;
    }
    
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.height.mas_equalTo(300);
    }];
    baseView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
