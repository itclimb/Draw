//
//  DemoController.m
//  Draw
//
//  Created by itclimb on 19/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "DemoController.h"
#import "Masonry.h"
#import "TestView.h"
#import "huView.h"
#import "hu1View.h"
#import "zhuView.h"
#import "LineView.h"
#import "DrawPictureView.h"
#import "JJImageView.h"
#import "UIImage+JJImage.h"
#import "ScreenShotView.h"
#import "unlockView.h"
#import "ClockView.h"

@interface DemoController ()

@property(nonatomic, strong) unlockView *unlockView;

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *baseView;
    switch (self.type) {
        case kDemoFuncTest:
            baseView = [[TestView alloc] init];
            break;
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
            break;
        case kDemoFuncScreenShot:
            baseView = [[ScreenShotView alloc] init];
            break;
        case kDemoFuncUnlock:
            self.unlockView = [[unlockView alloc] init];
            baseView = self.unlockView;
            break;
        case kDemoFuncClock:
            baseView = [[ClockView alloc] init];
            break;
        default:
            break;
    }
    
    if (self.type == kDemoFuncImageView) { //自定义图片框
        JJImageView *imgView = [[JJImageView alloc] init];
        //对图片框进行裁剪
        imgView.clipCorner = YES;
        imgView.image = [UIImage imageNamed:@"me"];
        imgView.frame = CGRectMake(0, 0, 100, 100);
        [baseView addSubview:imgView];
        
        JJImageView *imgView1 = [[JJImageView alloc] init];
        imgView1.frame = CGRectMake(100, 0, 100, 100);
        UIImage *image1 = [UIImage imageNamed:@"me"];
        //对图片进行裁剪
        UIImage *clipImage = [UIImage clipedImage:image1 andText:@"Hello"];
        imgView1.image = clipImage;
        [baseView addSubview:imgView1];
    }
    if (self.type == kDemoFuncUnlock) {  //解锁
        //用指定小图片铺满当前的屏幕
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
        self.unlockView.unlockBlock = ^(unlockView *unlockView, NSString *password){
            if ([password isEqualToString:@"4578"]) {
                return YES;
            }else{
                return NO;
            }
        };
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
