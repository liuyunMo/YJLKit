//
//  TestSelectViewViewController.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-26.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "TestSelectViewViewController.h"

@interface TestSelectViewViewController ()<YJLSelectViewDelegete>

@end

@implementation TestSelectViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    YJLSelectView *selectVi=[[YJLSelectView alloc] initWithFrame:CGRectMake(30, 100, 160, 30) title:@"这个是下拉菜单" options:@[@"选项1",@"选项2",@"选项3",@"选项4",@"选项1345",@"选项135",@"选项16",@"选项10",]];
    selectVi.delegate=self;
    selectVi.menuMaxHeight=0;
    selectVi.menuOffset=CGPointMake(160, -30);
    selectVi.menuWidth=100;
    [self.view addSubview:selectVi];
    [selectVi release];
    //NSLog(@"%@",selectVi.infoDict);
    
    NSLog(@"%@",[YJLSelectView getInfoDictKeys]);
    YJLSelectView *vi=[YJLSelectView createWithInfoDict:selectVi.infoDict];
    vi.menuOffset=CGPointZero;
    CGRect rect=vi.frame;
    rect.origin.x=200;
    rect.size.width=100;
    vi.frame=rect;
    [self.view addSubview:vi];
    [vi release];
}
-(void)selectView:(YJLSelectView *)selectView selectItem:(UIView *)itemView atIndex:(NSUInteger)index
{
    selectView.title=[selectView.options objectAtIndex:index];
    [selectView close];
}

@end
