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
    [self drawLineWithRef];
    [self drawLineWithBezier];
    [self drawLineWithRefAndBezier];
    [self drawRoundWithRefAndBezier];
    [self drawRoundedRectWithRefAndBezier];
}

//MARK: - 通过上下文绘制
- (void)drawLineWithRef{
    //1.获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //2.设置路径
    CGContextMoveToPoint(ref, 50, 50);
    CGContextAddLineToPoint(ref, 200, 200);
    [[UIColor redColor] setStroke];
    //3.渲染
    CGContextStrokePath(ref);
}
//MARK: - 通过Bezier绘制
- (void)drawLineWithBezier{
    //1.创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.设置路径
    [path moveToPoint:CGPointMake(50, 70)];
    [path addLineToPoint:CGPointMake(200, 200)];
    [[UIColor blackColor] setStroke];
    //3.绘制
    [path stroke];
}
//MARK: - 通过Ref和Bezier
- (void)drawLineWithRefAndBezier{
    //1.获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //2.创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 90)];
    [path addLineToPoint:CGPointMake(200, 200)];
    //3.添加路径
    CGContextAddPath(ref, path.CGPath);
    [[UIColor blueColor] setStroke];
    //4.绘制
    CGContextDrawPath(ref, kCGPathStroke);
}


//MARK: - 绘制椭圆
- (void)drawRoundWithRefAndBezier{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 150)];
    CGContextAddPath(ref, path.CGPath);
    CGContextDrawPath(ref, kCGPathStroke);
}
//MARK: - 圆角矩形
- (void)drawRoundedRectWithRefAndBezier{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 150, 150, 100) cornerRadius:20];
    CGContextSetLineWidth(ref, 10);
    CGContextAddPath(ref, path.CGPath);
    CGContextDrawPath(ref, kCGPathStroke);
}

@end
