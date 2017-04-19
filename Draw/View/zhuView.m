//
//  zhuView.m
//  Draw
//
//  Created by itclimb on 19/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "zhuView.h"

@implementation zhuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect {
    NSArray *datas = @[@300, @150.65, @55.3, @507.7, @95.8, @700, @650.65];
    NSInteger len = datas.count;
    CGFloat gap = 20;
    CGFloat rectPathW = (rect.size.width - (len-1)*gap)/len;
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [datas enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat percent = obj.floatValue/1000;
        CGFloat rectPathH = rect.size.height * percent;
        CGFloat rectPathX = idx * (gap + rectPathW);
        CGFloat rectPathY = rect.size.height - rectPathH;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(rectPathX, rectPathY, rectPathW, rectPathH)];
        CGContextAddPath(ref, path.CGPath);
        
        [[UIColor colorWithRed:arc4random_uniform(256)/256.0 green:arc4random_uniform(256)/256.0 blue:arc4random_uniform(256)/256.0 alpha:1.0] setFill];
        CGContextDrawPath(ref, kCGPathFillStroke);
        
    }];
}


@end
