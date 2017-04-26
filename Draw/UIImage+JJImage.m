//
//  UIImage+JJImage.m
//  Draw
//
//  Created by itclimb on 24/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "UIImage+JJImage.h"

@implementation UIImage (JJImage)

+ (UIImage *)clipedImage:(UIImage *)image andText:(NSString *)text{
    //开启图片的图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    //获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(image.size.width/2, image.size.height/2) radius:image.size.width/2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CGContextAddPath(ref, path.CGPath);
    //裁剪
    CGContextClip(ref);
    [image drawAtPoint:CGPointZero];
    
    //添加水印
    NSDictionary *dict = @{
                           NSFontAttributeName : [UIFont systemFontOfSize:20],
                           NSForegroundColorAttributeName : [UIColor redColor]
                           };
    [text drawAtPoint:CGPointMake(30, 30) withAttributes:dict];
    
    //获取裁剪后的Image
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return clipImage;
}


@end
