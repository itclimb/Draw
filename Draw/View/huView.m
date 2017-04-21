//
//  huView.m
//  Draw
//
//  Created by itclimb on 18/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "huView.h"
#import "Masonry.h"

@implementation huView
JJSingletonM(huView)
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    NSArray *array = @[@16, @20, @30, @20, @14];
    //获取图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGFloat edgeLen = rect.size.width;
    CGPoint center = CGPointMake(edgeLen/2, edgeLen/2);
    CGFloat radius = edgeLen/2;
    CGFloat startA = 0;
    for (NSNumber *num in array) {
        CGFloat percent = num.floatValue/100;
        CGFloat endA = percent * M_PI * 2 + startA;
        //创建路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:center];
        //将路径加到图形上下文
        CGContextAddPath(ref, path.CGPath);
        
        [[UIColor colorWithRed:arc4random_uniform(256)/256.0 green:arc4random_uniform(256)/256.0 blue:arc4random_uniform(256)/256.0 alpha:1.0] setFill];
        //渲染
        /**
         kCGPathFill,
         kCGPathEOFill,
         kCGPathStroke,
         kCGPathFillStroke,
         kCGPathEOFillStroke
         */
        CGContextDrawPath(ref, kCGPathEOFillStroke);
        startA = endA;
    }
}

@end
