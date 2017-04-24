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
#import "LineView.h"
#import "DrawPictureView.h"
#import "JJImageView.h"
#import "UIImage+JJImage.h"

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
        case kDemoFuncLine:
            baseView = [[LineView alloc] init];
            break;
        case kDemoFuncPicture:
            baseView = [[DrawPictureView alloc] init];
            break;
        case kDemoFuncImageView:
            baseView = [[UIView alloc] init];
        default:
            break;
    }
    
    if (self.type == kDemoFuncImageView) {
        JJImageView *imgView = [[JJImageView alloc] init];
        //对图片框进行裁剪
        imgView.clipCorner = YES;
        imgView.image = [UIImage imageNamed:@"me"];
        imgView.frame = CGRectMake(0, 0, 100, 100);
        [baseView addSubview:imgView];
        
        JJImageView *imgView1 = [[JJImageView alloc] init];
        imgView1.frame = CGRectMake(100, 0, 100, 100);
        UIImage *clipImage = [UIImage imageNamed:@"me"];
        //对图片进行裁剪
        clipImage = [clipImage clipedImage:clipImage];
        imgView1.image = clipImage;
        [baseView addSubview:imgView1];
    }
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.height.mas_equalTo(300);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
