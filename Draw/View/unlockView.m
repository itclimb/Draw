//
//  unlockView.m
//  Draw
//
//  Created by itclimb on 25/04/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "unlockView.h"

@interface unlockView ()
//划线颜色
@property (nonatomic, strong)UIColor *lineColor;
//子按钮
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnsArr;

@property (nonatomic, assign) CGPoint currentP;

@end

@implementation unlockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupButton];
    }
    return self;
}

#pragma mark -xib加载子控件
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupButton];
}

#pragma mark - 绘制
- (void)drawRect:(CGRect)rect {
    //1.获取路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.btnsArr enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [path moveToPoint:obj.center];
        }else{
            [path addLineToPoint:obj.center];
        }
    }];
    
    //连接最后一个点之前首先要判断数组里面是不是空的,如果是空的说明没有起始点
    if (self.btnsArr.count > 0) {
        //连接最后一个点
        [path addLineToPoint:self.currentP];
    }
    
    //设置连接样式和线头样式
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapButt;
    path.lineWidth = 10;
    [self.lineColor setStroke];
    //绘制
    [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获得触摸点
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:self];
    //遍历所有的按钮
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL iscontain = CGRectContainsPoint(obj.frame, loc);
        
        if (iscontain && obj.highlighted == NO) {
            obj.highlighted = YES;
            //MARK: - 将按钮存放到数组中
            [self.btnsArr addObject:obj];
        }else{
            obj.highlighted = NO;
        }
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获得触摸点
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:self];
    //保存当前点
    self.currentP = loc;
    [self setNeedsDisplay];
    
    //遍历所有的按钮
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL iscontain = CGRectContainsPoint(obj.frame, loc);
        
        if (iscontain && obj.highlighted == NO) {
            obj.highlighted = YES;
            //#MARK: - 将移动过程中高亮的按钮加入到数组中
            [self.btnsArr addObject:obj];
            //绘制路径
            [self setNeedsDisplay];
        }
    }];
}

#pragma mark - 触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //关闭与用户的交互
    self.userInteractionEnabled = NO;
    //在脱线结束的时候让线头回到最后一个按钮并立即重绘
    self.currentP = [self.btnsArr lastObject].center;
    [self setNeedsDisplay];
    
    //拼接密码字符串
    NSMutableString *pwdStr = [NSMutableString string];
    [self.btnsArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [pwdStr appendString:[NSString stringWithFormat:@"%@",@(obj.tag)]];
        
    }];
    
    BOOL isRight = false;
    
    if (self.unlockBlock) {
        isRight = self.unlockBlock(self,pwdStr);
    };
    
    if (isRight) {
        [self pwdIsRight];
    }else{
        [self pwdIsWrong];
    }
}

- (void)pwdIsWrong{
    [self.btnsArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.highlighted = NO;
        obj.enabled = NO;
    }];
    self.lineColor = [UIColor redColor];
    [self setNeedsDisplay];
    //延时后将数组中remove
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //1.将状态改回去
        [self.btnsArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.enabled = YES;
        }];
        
        //2.把线的颜色改过来
        self.lineColor = [UIColor colorWithRed:0.0 green:170/255.0 blue:255/255.0 alpha:0.5];
        //3.将数组中的数据移除
        [self.btnsArr removeAllObjects];
        //4.重绘
        [self setNeedsDisplay];
        self.userInteractionEnabled = YES;
    });
}

- (void)pwdIsRight{
    //全部改为普通状态
    [self.btnsArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.highlighted = NO;
    }];
    [self.btnsArr removeAllObjects];
    [self setNeedsDisplay];
    self.userInteractionEnabled = YES;
}

#pragma mark - 创建按钮
- (void)setupButton{
    // 0.设置颜色
    self.lineColor = [UIColor colorWithRed:0.0 green:170/255.0 blue:255/255.0 alpha:0.5];
    
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置每个按钮的索引
        btn.tag = i;
        //关闭按钮与用户的交互
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
        //添加到view上
        [self addSubview:btn];
    }
}

#pragma mark - 子控件布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat objW = 74;
    CGFloat objH = objW;
    //九宫格的列数为3
    int colNum = 3;
    CGFloat Margin = (self.bounds.size.width - objW * colNum) / (colNum - 1);
    //遍历view中所有的按钮
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //1.计算行列号
        CGFloat col = idx % colNum;
        CGFloat row = idx / colNum;
        //2.计算x,y值
        CGFloat objX = (Margin + objW) * col;
        CGFloat objY = (Margin + objH) * row;
        //3.设置按钮的frame
        obj.frame = CGRectMake(objX, objY, objW, objH);
    }];
}

#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)btnsArr{
    if (_btnsArr == nil) {
        _btnsArr = [NSMutableArray array];
    }
    return _btnsArr;
}


@end
