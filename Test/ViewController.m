//
//  ViewController.m
//  Test
//
//  Created by RainyTunes on 16/8/9.
//  Copyright © 2016年 We.Can. All rights reserved.
//

#import "ViewController.h"
#import "WeTimer.h"

const NSInteger circle_X = 90;
const NSInteger circle_Y = 267;
const NSInteger length = 415 / 2;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect square = CGRectMake(circle_X, circle_Y, length, length);
    WeTimer *timerView = [[WeTimer alloc] initWithSquare:square Nums:@[@25,@55,@20,@20,@0]];
    [self.view addSubview: timerView];
    
//    self.view.backgroundColor = [UIColor greenColor];
//    MyView *view = [[MyView alloc]initWithFrame:CGRectMake(circle_X, circle_Y, diameter, diameter)];
//    view.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
