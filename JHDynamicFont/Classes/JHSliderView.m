//
//  JHSliderView.m
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/13.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "JHSliderView.h"

@interface JHSliderView ()

@property (nonatomic, strong) UIImageView* sliderImageView;
@property (nonatomic, strong) UIImage* sliderImage;

@property (nonatomic) NSInteger count;
@property (nonatomic) CGFloat originX;
@property (nonatomic) CGFloat originY;
@property (nonatomic, strong) NSArray *options;

@end

@implementation JHSliderView


+ (instancetype)sliderViewWithFrame:(CGRect)frame options:(NSArray *)options valueDidChangedBlokck:(JHSliderValuerDidChangedBlock)changedBlock
{
    JHSliderView *sliderView = [[JHSliderView alloc] initWithFrame:frame options:options valueDidChangedBlokck:changedBlock];
    return sliderView;
}

- (instancetype)initWithFrame:(CGRect)frame options:(NSArray *)options valueDidChangedBlokck:(JHSliderValuerDidChangedBlock)changedBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _originX = 20;
        _originY = frame.size.height / 2 - 10;
        _count = options.count;
        _currentIndex = 3;
        _options = options;
        _changedBlock = changedBlock;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self createOptionsWithFrame:frame];
        
        [self createSliderImageView];
        
        [self updateSliderViewPositonAtIndex:3];
    }
    return self;
}

#pragma mark 创建slider的滑动圆点
- (void)createSliderImageView
{
    _sliderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _sliderImageView.layer.cornerRadius = 15;
    _sliderImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_sliderImageView];
    [self bringSubviewToFront:_sliderImageView];
}

#pragma mark 设置初始位置 || 更新位置
- (void)updateSliderViewPositonAtIndex:(NSInteger)index
{
    [_sliderImageView setCenter:[self getIndexPointWithIndex:index frame:self.frame]];
}

#pragma mark 获取中心坐标点
- (CGPoint)getIndexPointWithIndex:(NSInteger)index frame:(CGRect)frame
{
    CGFloat divWidth = (frame.size.width - 2 * _originX) / (_count - 1);
    return CGPointMake(_originX + index * divWidth, _originY);
}

- (void)createOptionsWithFrame:(CGRect)frame
{
    CGFloat optionCenterY = frame.size.height / 2 + 20;
    
    for (NSInteger i = 0; i < _count; i++) {
        
        NSString* option = _options[i];
        UILabel* optionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [optionLabel setBackgroundColor:[UIColor clearColor]];
        optionLabel.text = option;
        optionLabel.font = [UIFont systemFontOfSize:16];
        optionLabel.textColor = [UIColor grayColor];
        [optionLabel sizeToFit];
        [self addSubview:optionLabel];
        CGPoint optionLabelCenter = [self getIndexPointWithIndex:i frame:frame];
        [optionLabel setCenter:CGPointMake(optionLabelCenter.x, optionCenterY)];
    }
}

#pragma mark 画线
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, _originX, _originY);
    CGContextAddLineToPoint(context, rect.size.width - _originX, _originY);
    CGContextStrokePath(context);
    
    for (NSInteger i = 0; i < _count + 1; i++) {
        
        CGPoint indexPoint = [self getIndexPointWithIndex:i frame:rect];
        CGContextMoveToPoint(context, indexPoint.x, indexPoint.y - 5);
        CGContextAddLineToPoint(context, indexPoint.x, indexPoint.y + 5);
        CGContextStrokePath(context);
    }
}

#pragma mark 手势操作
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    //获取触摸点坐标
    CGPoint touchPoint = [touch locationInView:self];
    [self updateSliderWithIndex:[self checkTouchPointToIndex:touchPoint]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    //获取触摸点坐标
    CGPoint touchPoint = [touch locationInView:self];
    [self updateSliderWithIndex:[self checkTouchPointToIndex:touchPoint]];
}

#pragma mark 检验当前触摸点
- (NSInteger)checkTouchPointToIndex:(CGPoint)touchPoint
{
    //触摸点相对于option的x距离
    NSInteger pointX = touchPoint.x - _originX;
    //总滑动点宽度
    NSInteger sliderWidth = self.frame.size.width - 2 * _originX;
    //每个滑动点之间距离
    NSInteger divWidth = sliderWidth / (_count - 1);
    //当前滑动点所在option位置
    NSInteger index = pointX / divWidth;
    //偏离滑动点的距离
    NSInteger div = pointX % divWidth;
    
    if (div > divWidth / 2) {
        //偏移距离大于一般就移动到下个option点
        index += 1;
    }
    //超出边界的处理
    if (index < 0) {
        
        index = 0;
    }
    
    if (index > _count) {
        
        index = _count;
    }
    return index;
}

#pragma mark 更新option点
- (void)updateSliderWithIndex:(NSInteger)index
{
    if (index != _currentIndex) {
        [self setCurrentIndex:index];
        _currentIndex = index;
        if (_changedBlock) {
            _changedBlock(index);
        }
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (_currentIndex != currentIndex) {
        
        _currentIndex = currentIndex;
        
        [self updateSliderViewPositonAtIndex:_currentIndex];
    }
}

@end
