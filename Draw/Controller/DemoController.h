//
//  DemoController.h
//  Draw
//
//  Created by itclimb on 19/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kDemoFuncHu,
    kDemoFuncHu1,
    kDemoFuncZhu,
    kDemoFuncLine,
    kDemoFuncPicture
} kDemoFunc;

@interface DemoController : UIViewController

@property(nonatomic, assign) kDemoFunc type;

@end
