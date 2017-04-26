//
//  ClockView.m
//  Draw
//
//  Created by itclimb on 26/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "ClockView.h"

@interface ClockView ()
//秒针
@property (nonatomic, strong)CALayer *secondLayer;
//分针
@property (nonatomic, strong)CALayer *minuteLayer;
//时针
@property (nonatomic, strong)CALayer *hourLayer;

@end

@implementation ClockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
        [self setupUI];
        [self setTimer];
    }
    return self;
}

- (void)setTimer{
    
    //1.第一种计时器(定时进行刷新)
    //    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stateRotate) userInfo:nil repeats:YES];
    
    //2.第二种计时器(默认每秒钟刷新60次)
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(stateRotate)];
    
    //可以通过下面改变刷新的频率(frameInterval应该是每一圈的周期)
    /**
     *  frameInterval默认值为1,表示每1秒钟刷新60次
     frameIntervar改为60时,表示每60秒钟刷新60次,即每秒钟刷新1次
     */
    //link.frameInterval = 60;

    //2.1 添加到运行循环
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - 进行旋转
- (void)stateRotate{
    
    //1.秒针旋转角度
    CGFloat angleSec = M_PI * 2 / 60 / 60;
    //2.分针旋转角度
    CGFloat angleMiu = angleSec / 60;
    //3.时针旋转角度
    CGFloat angleHor = angleMiu / 12;
    
    //秒针旋转
    self.secondLayer.transform = CATransform3DRotate(self.secondLayer.transform, angleSec, 0, 0, 1);
    //分针旋转
    self.minuteLayer.transform = CATransform3DRotate(self.minuteLayer.transform, angleMiu, 0, 0, 1);
    //时针旋转
    self.hourLayer.transform = CATransform3DRotate(self.hourLayer.transform, angleHor, 0, 0, 1);
}


- (void)setupUI{
    
    //搭建时钟背景图片
    CALayer *clock = [CALayer layer];
    //2.设置
    clock.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"].CGImage);
    clock.bounds = CGRectMake(0, 0, 150, 150);
    clock.position = CGPointMake(150, 150);
    //3.加载
    [self.layer addSublayer:clock];
    
    //秒针
    CALayer *secondL = [CALayer layer];
    //设置
    secondL.backgroundColor = [UIColor redColor].CGColor;
    secondL.bounds = CGRectMake(0, 0, 1, 75);
    secondL.position = CGPointMake(clock.bounds.size.width * 0.5, clock.bounds.size.height * 0.5);
    secondL.anchorPoint = CGPointMake(0.5, 0.8);
    //加载
    [clock addSublayer:secondL];
    self.secondLayer = secondL;
   
    //分针
    CALayer *minuteL = [CALayer layer];
    //设置
    minuteL.backgroundColor = [UIColor blackColor].CGColor;
    minuteL.bounds = CGRectMake(0, 0, 2, 70);
    minuteL.position = CGPointMake(clock.bounds.size.width * 0.5, clock.bounds.size.height * 0.5);
    minuteL.anchorPoint = CGPointMake(0.5, 0.8);
    //加载
    [clock addSublayer:minuteL];
    self.minuteLayer = minuteL;
   
    //时针
    CALayer *hourL = [CALayer layer];
    //设置
    hourL.backgroundColor = [UIColor blackColor].CGColor;
    hourL.bounds = CGRectMake(0, 0, 3, 50);
    hourL.position = CGPointMake(clock.bounds.size.width * 0.5, clock.bounds.size.height * 0.5);
    hourL.anchorPoint = CGPointMake(0.5, 0.8);
    //加载
    [clock addSublayer:hourL];
    self.hourLayer = hourL;

    
    //1.获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //2.获取当前的秒数
    NSInteger secondNum = [calendar component:NSCalendarUnitSecond fromDate:[NSDate date]];
    CGFloat currentSecAngle = (M_PI * 2 / 60) * secondNum;
    self.secondLayer.transform = CATransform3DRotate(self.secondLayer.transform, currentSecAngle, 0, 0, 1);
    //3.获取当前的分钟
    NSInteger minuteNum = [calendar component:NSCalendarUnitMinute fromDate:[NSDate date]];
    CGFloat currentMiuAngle = (M_PI * 2 / 60) * minuteNum + currentSecAngle / 60;
    self.minuteLayer.transform = CATransform3DRotate(self.minuteLayer.transform, currentMiuAngle, 0, 0, 1);
    //4.获取当前的小时
    NSInteger hourNum = [calendar component:NSCalendarUnitHour fromDate:[NSDate date]];
    CGFloat currentHorAngle = (M_PI * 2 / 12) * hourNum + currentMiuAngle / 12;
    
    self.hourLayer.transform = CATransform3DRotate(self.hourLayer.transform, currentHorAngle, 0, 0, 1);
}


@end
