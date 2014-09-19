//
//  TestNetLayerViewController.m
//  testYJLUIKit
//
//  Created by user on 14-9-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "TestNetLayerViewController.h"
#import "QMLNetGraphicsLayer.h"
@interface TestNetLayerViewController ()

@end

@implementation TestNetLayerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    QMLNetGraphicsLayer *layer=[QMLNetGraphicsLayer layer];
    layer.dataCount=5;
    layer.frame=CGRectMake(0, 100, 320, 320);
    layer.radius=150;
    layer.zeroValue=.2;
    layer.level=5;
    layer.backgroundColor=[UIColor whiteColor].CGColor;
    
//    layer.pathToKeyPoint=^(NSDictionary *dict){
//        NSLog(@"%@",dict);
//    };
    
    [layer draw];
    [self.view.layer addSublayer:layer];
    
    __block CGPoint startPoint;
    
    NSString *flag=[layer addValues:@[@(.2),@(.5),@(.3),@(.2),@(.2)] lineColor:COLOR_WITH_RGBA(255, 0, 0, 255) fillColor:COLOR_WITH_RGBA(255,0, 0, 100) lineWidth:3 keyPoint:^(NSDictionary *dict) {
        if ([[dict objectForKey:@"index"] intValue]==1) {
            startPoint=[[dict objectForKey:@"point"] CGPointValue];
        }
    }];
    
    
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    float p[2]={5,1};
    [bezierPath setLineDash:p count:2 phase:0];
    [bezierPath moveToPoint:startPoint];
    [bezierPath addLineToPoint:CGPointMake(240, 20)];
    [bezierPath stroke];
    
    NSString *flag1=[layer addLineWithBezierPath:bezierPath lineColor:[UIColor redColor] lineWidth:1 animationTime:.5];
    
    NSString *flag2=[layer addValues:@[@(.5),@(.5),@(.8),@(.1),@(.2)] lineColor:COLOR_WITH_RGBA(0, 255, 0, 255) fillColor:COLOR_WITH_RGBA(0, 255, 0, 100) lineWidth:3];
    NSLog(@"\n\n%@\n%@\n%@",flag,flag1,flag2);
}

@end
