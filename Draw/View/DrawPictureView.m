//
//  DrawPictureView.m
//  Draw
//
//  Created by itclimb on 21/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "DrawPictureView.h"

@implementation DrawPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self drawImage];
    [self drawText];
}
//图片
- (void)drawImage{
    UIImage *testImage = [UIImage imageNamed:@"1"];
    [testImage drawAsPatternInRect:self.bounds];
}
//文字
- (void)drawText{
    NSString *testStr = @"撸起袖子加油干!";
    NSDictionary *dict = @{
                           NSFontAttributeName : [UIFont systemFontOfSize:25],
                           NSForegroundColorAttributeName : [UIColor redColor]
                           };
    [testStr drawAtPoint:CGPointMake(50, 50) withAttributes:dict];
}
@end
