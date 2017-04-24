//
//  ScreenShotView.m
//  Draw
//
//  Created by itclimb on 24/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "ScreenShotView.h"
#import "Masonry.h"

@implementation ScreenShotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"截屏" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blueColor]];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.mas_equalTo(self);
            make.height.mas_equalTo(30);
        }];
        [button addTarget:self action:@selector(screenShot:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//截图
- (void)screenShot:(UIButton *)button{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //开启图片图形上下文
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
        //将layer呈现在指定的上下文
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        //获取截图
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndPDFContext();
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    });
}

@end
