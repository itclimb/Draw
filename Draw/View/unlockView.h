//
//  unlockView.h
//  Draw
//
//  Created by itclimb on 25/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class unlockView;

typedef BOOL(^unlockBlock)(unlockView *,NSString *);

@interface unlockView : UIView

@property (nonatomic, copy)unlockBlock unlockBlock;

@end
