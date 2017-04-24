//
//  JJImageView.h
//  Draw
//
//  Created by itclimb on 24/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJImageView : UIView
//图片
@property(nonatomic, strong) UIImage *image;
//是否切成圆角
@property(nonatomic, assign) BOOL clipCorner;
@end
