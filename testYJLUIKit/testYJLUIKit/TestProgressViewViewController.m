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
    
    NSDictionary *dict=nil;
    NSString *layoutStr=nil;
    getLayoutStrWithLayoutFile(@"YJLProgreeView", &layoutStr);
    getInstancesWithLayoutStr(layoutStr, &dict);
    proVi1=[dict objectForKey:@"TestProgressViewViewController_YJLProgreeView_pro1"];
    [self.view addSubview:proVi1];
    
    proVi2=[dict objectForKey:@"TestProgressViewViewController_YJLProgreeView_pro3"];
    [self.view addSubview:proVi2];
    
    
    proVi4=[dict objectForKey:@"TestProgressViewViewController_YJLProgreeView_pro4"];
    [self.view addSubview:proVi4];
    
    proVi=[dict objectForKey:@"TestProgressViewViewController_YJLProgreeView_pro5"];
    [self.view addSubview:proVi];
    LYLog(@"%@",dict);
    timer=[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(run) userInfo:nil repeats:YES];
}
-(void)run
{
    proVi.progress +=.01;
    proVi1.progress+=.01;
    proVi2.progress+=.01;
    proVi3.progress+=.01;
    proVi4.progress+=.01;
    if (proVi.progress>=1) {
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
