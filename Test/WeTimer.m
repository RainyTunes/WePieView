//
//  ViewController.m
//  Test
//
//  Created by RainyTunes on 16/8/9.
//  Copyright © 2016年 We.Can. All rights reserved.
//


#import "WeTimer.h"
#import "WeNumLabel.h"
#import "WeConfig.h"

@interface WeTimer ()
@property CGFloat radius; //Timer半径
@property CGFloat length; //View边长
@property CGFloat half_length; //View的边长一半
@property CGFloat innerRadius; //Timer内部中心空白圆半径
@property CGFloat borderRadius; //圆角半径
@property NSMutableArray <NSNumber *> *nums; //由饼图的百分比数字组成的数组

@end

@implementation WeTimer

static inline float radians(CGFloat degrees) {
    return degrees * 3.14 / 180;
}

- (void)drawRect:(CGRect)rect {
    CGFloat sum = 0;
    for (NSNumber *num in self.nums) {
        sum += num.doubleValue;
    }
    CGFloat nowAngle = INITIAL_ANGLE;
    for (int i = 0; i < self.nums.count; i++) {
        NSInteger nextAngle = (NSInteger)(nowAngle + self.nums[i].doubleValue / sum * 360) % 360;
        CGFloat middleAngle = nextAngle < nowAngle ? (nextAngle + nowAngle + 360)/ 2 : (nextAngle + nowAngle) / 2;
        [self addLabelwithNum:self.nums[i].doubleValue index:i middleAngle:middleAngle];
        [self drawArcWithStartAngle:nowAngle endAngle:nextAngle - gapAngle index:i];
        nowAngle = nextAngle;
        WeLog(@"now = %lf next = %ld middle = %lf" ,nowAngle,nextAngle,middleAngle);
    }
}

- (void)addLabelwithNum:(CGFloat)num index:(NSInteger)index middleAngle:(CGFloat)middleAngle {
    //百分比数字Label
    int labelX = self.half_length + ((_innerRadius + (_radius - _innerRadius) / 2))  * cos(middleAngle / 57.3);
    int labelY = self.half_length - ((_innerRadius + (_radius - _innerRadius) / 2))  * sin(middleAngle / 57.3);
    WeNumLabel *label = [[WeNumLabel alloc]initWithFrame:NUM_RECT index:index];
    label.text = [NSString stringWithFormat:@"%.0lf%%",num];
    [label sizeToFit];
    label.center = CGPointMake(labelX, labelY);
    [self addSubview:label];
}

- (instancetype)init{
    
    return self;
}

- (instancetype)initWithSquare:(CGRect)square Nums:(NSArray <NSNumber *>*)nums {
//    NSLog(@"%lf",radToRadians(57.3));
//    NSLog(@"%lf",radians(57.3));
    
    self = [super initWithFrame:square];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.nums = [nums mutableCopy];
        self.radius = square.size.width / 30 * 14;
        self.innerRadius=square.size.width / 8.0;
        self.length = square.size.width;
        self.half_length = self.length / 2;
        self.borderRadius = self.radius * sin(radians(borderAngle)) / (1 + sin(radians(borderAngle)));
    }
    [self.nums removeObject:@0];
    return self;
}

- (void)drawArcWithStartAngle:(CGFloat)start endAngle:(CGFloat)end index:(NSInteger)index {
    //顶点计算
    CGFloat cX = self.half_length + self.innerRadius * cos(radians(start));
    CGFloat cY = self.half_length - self.innerRadius * sin(radians(start));
    CGFloat a1X = self.half_length + self.radius * cos(radians(start + borderAngle));
    CGFloat a1Y = self.half_length - self.radius * sin(radians(start + borderAngle));
    CGFloat a2X = self.half_length + (self.borderRadius / tan(radians(borderAngle))) * cos(radians(start));
    CGFloat a2Y = self.half_length - (self.borderRadius / tan(radians(borderAngle))) * sin(radians(start));
    CGFloat k1 = -1.0/tan(radians(start + borderAngle));
    
    CGFloat paX = self.half_length + (self.radius * sin(radians(start + borderAngle)) - self.radius * cos(radians(start + borderAngle)) * k1) / (tan(radians(start)) - k1);
    CGFloat paY =  self.half_length - tan(radians(start)) * (self.radius * sin(radians(start + borderAngle)) - self.radius * cos(radians(start + borderAngle)) * k1) / (tan(radians(start)) - k1);
    
    CGFloat dX = self.half_length + self.innerRadius * cos(radians(end));
    CGFloat dY = self.half_length - self.innerRadius * sin(radians(end));
    //temporarily unused
    //CGFloat b1X = self.half_length + self.radius * cos(radians(end - borderAngle));
    //CGFloat b1Y = self.half_length - self.radius * sin(radians(end - borderAngle));
    CGFloat b2X = self.half_length + (self.borderRadius / tan(radians(borderAngle))) * cos(radians(end));
    CGFloat b2Y = self.half_length - (self.borderRadius / tan(radians(borderAngle))) * sin(radians(end));
    CGFloat k2 = -1.0/tan(radians(end - borderAngle));
    
    CGFloat pbX = self.half_length + (self.radius * sin(radians(end - borderAngle)) - self.radius * cos(radians(end - borderAngle)) * k2) / (tan(radians(end)) - k2);
    CGFloat pbY =  self.half_length - tan(radians(end)) * (self.radius * sin(radians(end - borderAngle)) - self.radius * cos(radians(end - borderAngle)) * k2) / (tan(radians(end)) - k2);
    
    //绘制扇形
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, color[index][0], color[index][1], color[index][2], 1);
    CGContextSetRGBStrokeColor(context, colorLine[index][0], colorLine[index][1], colorLine[index][2], 1);
                            
    CGContextMoveToPoint(context, cX, cY);
    CGContextAddLineToPoint(context, a2X, a2Y);
    CGContextAddArcToPoint(context, paX, paY, a1X, a1Y, self.borderRadius);
    
    CGContextAddArc(context, self.half_length, self.half_length, self.radius, -radians(start + borderAngle), -radians(end - borderAngle), 1);
    CGContextAddArcToPoint(context, pbX, pbY, b2X, b2Y, self.borderRadius);
    CGContextAddLineToPoint(context, dX, dY);
    
    CGContextAddArc(context, self.half_length, self.half_length, self.innerRadius, -radians(end), -radians(start), 0);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextFillPath(context);
}
@end