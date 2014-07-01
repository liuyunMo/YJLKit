//
//  TestProgressViewViewController.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-1.
//  Copyright (c) 2014年 钟园园. All rights reserved.

#import "TestProgressViewViewController.h"
@interface TestProgressViewViewController ()
{
    YJLProgreeView *proVi,*proVi1,*proVi2,*proVi3,*proVi4;
    NSTimer *timer;
}

@end
@implementation TestProgressViewViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    proVi1=[[YJLProgreeView alloc] initWithFrame:CGRectMake(140, 70, 160, 160)];
    proVi1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:proVi1];
    [proVi1 release];
    
    proVi3=[[YJLProgreeView alloc] initWithFrame:CGRectMake(20, 250, 280, 15)];
    proVi3.borderType=YJLProgressViewBorderTypeRound;
    proVi3.type=YJLProgressViewDefault;
    proVi3.layer.cornerRadius=7.5;
    proVi3.layer.borderColor=[UIColor whiteColor].CGColor;
    proVi3.layer.borderWidth=2;
    proVi3.clipsToBounds=YES;
    proVi3.backgroundColor=[UIColor clearColor];
    [self.view addSubview:proVi3];
    [proVi3 release];
    
    proVi2=[[YJLProgreeView alloc] initWithFrame:CGRectMake(20, 280, 280, 10)];
    proVi2.borderType=YJLProgressViewBorderTypePlain;
    proVi2.type=YJLProgressViewDefault;
    proVi2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:proVi2];
    [proVi2 release];
    
    proVi=[[YJLProgreeView alloc] initWithFrame:CGRectMake(20, 70, 100, 100)];
    proVi.borderType=YJLProgressViewBorderTypePlain;
    proVi.backgroundColor=[UIColor clearColor];
    [self.view addSubview:proVi];
    [proVi release];
    
    proVi4=[[YJLProgreeView alloc] initWithFrame:CGRectMake(80, 300, 100, 100)];
    proVi4.type=YJLProgressViewPie;
    proVi4.backgroundColor=[UIColor clearColor];
    [self.view addSubview:proVi4];
    [proVi4 release];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(run) userInfo:nil repeats:YES];
    NSLog(@"%@",proVi.infoDict);
}
-(void)run
{
    proVi.progress +=.01;
    proVi1.progress+=.01;
    proVi2.progress+=.01;
    proVi3.progress+=.01;
    proVi4.progress+=.01;
    if (proVi.progress>1) {
        [timer invalidate];
        timer=nil;
    }
}
- (void)dealloc
{
    DEALLOC_PRINT;
    [timer invalidate];
    timer=nil;
    [super dealloc];
}
@end
