//
//  WeNumLabel.m
//  Test
//
//  Created by RainyTunes on 16/9/6.
//  Copyright © 2016年 We.Can. All rights reserved.
//



#import "WeNumLabel.h"
#import "WeConfig.h"

@implementation WeNumLabel
- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index {
    self = [super initWithFrame:frame];
    [self setTextColor:[UIColor colorWithRed:colorLine[index][0] green:colorLine[index][1] blue:colorLine[index][2] alpha:1]];
    self.backgroundColor = [UIColor clearColor];
    [self sizeToFit];
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
