//
//  UIImage+JJImage.h
//  Draw
//
//  Created by itclimb on 24/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JJImage)
//添加水印
- (void)addWaterMark:(NSString *)text;
//裁剪图片
+ (UIImage *)clipedImage:(UIImage *)image;

@end
