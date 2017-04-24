//
//  UIImage+JJImage.m
//  Draw
//
//  Created by itclimb on 24/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "UIImage+JJImage.h"

@implementation UIImage (JJImage)

- (UIImage *)clipedImage:(UIImage *)image{
    //开启图片的图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.size.width/2, self.size.height/2) radius:self.size.width/2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CGContextAddPath(ref, path.CGPath);
    CGContextClip(ref);
    [image drawAtPoint:CGPointZero];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return clipImage;
}

@end
