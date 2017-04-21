//
//  LineView.m
//  Draw
//
//  Created by itclimb on 21/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    //1.获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //2.设置路径
    CGContextMoveToPoint(ref, 50, 50);
    CGContextAddLineToPoint(ref, 200, 200);
    //3.渲染
    CGContextStrokePath(ref);
}

@end
