//
//  TestRefurbishView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-2.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "TestRefurbishView.h"


@implementation TestRefurbishView
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    YJLRefurbishView *refView=[[YJLRefurbishView alloc] initWithFrame:CGRectMake(10, 80, 300, 300)];
    refView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    [self.view addSubview:refView];
    [refView release];
}
@end
