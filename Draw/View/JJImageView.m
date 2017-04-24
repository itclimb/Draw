//
//  JJImageView.m
//  Draw
//
//  Created by itclimb on 24/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JJImageView.h"

@implementation JJImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect{
    
    if (self.clipCorner) {
        [self cutCornersInCircle:rect];
    }
    [self.image drawInRect:rect];
}

//绘线,切图
- (void)cutCornersInCircle:(CGRect)rect{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:rect.size.width/2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CGContextAddPath(ref, path.CGPath);
    CGContextClip(ref);
}

@end
