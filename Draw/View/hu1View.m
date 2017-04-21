//
//  hu1View.m
//  Draw
//
//  Created by itclimb on 20/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "hu1View.h"
#import "Masonry.h"

@interface hu1View ()

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UISlider *slider;

@property(nonatomic, assign) CGFloat progress;

@end

@implementation hu1View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //label
        self.backgroundColor = [UIColor yellowColor];
        self.label = [[UILabel alloc] init];
        self.label.textAlignment  = NSTextAlignmentCenter;
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        //滑动条
        self.slider = [[UISlider alloc] init];
        [self addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(40);
        }];
        [self.slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)sliderAction:(UISlider *)sender{
    self.progress = sender.value;
    self.label.hidden = !self.progress;
    self.label.text = [NSString stringWithFormat:@"%.2f%%",self.progress * 100];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect{
    //1.获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    NSLog(@"%f",self.progress);
    //2.路径
    CGFloat view_width = 300;
    CGPoint center = CGPointMake(view_width/2, view_width/2);
    CGFloat radius = view_width/2;
    CGFloat startA = - M_PI_2;
    CGFloat endA = self.progress * M_PI * 2 + startA;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [path addLineToPoint:center];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius - 30 startAngle:endA endAngle:startA clockwise:NO];
    [path2 addLineToPoint:center];
    
    //3.添加路径
    CGContextAddPath(ref, path.CGPath);
    CGContextAddPath(ref, path2.CGPath);
    
    //4.渲染
    CGContextDrawPath(ref, kCGPathFill);
}

@end
