//
//  ViewController.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "ViewController.h"
#import "YJLContentView.h"
@interface ViewController ()<YJLSelectViewDelegete>

@end

@implementation ViewController

- (void)viewDidLoad
{
    enableDeallocLog(YES);
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    YJLFlagView *flagView=[YJLFlagView createWithInfoDict:
  @{@"flag":@"flag",
    @"tag":@(10),
    @"frame":[NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)],
    @"backgroundColor":[UIColor redColor]
                                                        }];
    [self.view addSubview:flagView];
    NSLog(@"%ld_%@",(long)flagView.tag,flagView.flag);
    NSLog(@"%@",[YJLContentView getInfoDictKeys]);
    
    
    YJLScrollLabel *label=[[YJLScrollLabel alloc] initWithFrame:CGRectMake(0, 120, 100, 20)];
    YJLTextObj *textObj=[[YJLTextObj alloc] init];
    label.backgroundColor=[UIColor brownColor];
    textObj.text=@"just for test!just for test!just for test!";
    textObj.font=[UIFont systemFontOfSize:15];
    textObj.textColor=[UIColor redColor];
    label.textObj=textObj;
    [textObj release];
    [self.view addSubview:label];
    [label release];
    
//    UIScrollView *sc=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, 210, self.view.bounds.size.height-200)];
//    [self.view addSubview:sc];
//    [sc release];
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"readme" ofType:@"txt"];
//    YJLContentView *vi=[[YJLContentView alloc] initWithString:[NSString stringWithContentsOfFile:path encoding:4 error:nil] frame:CGRectMake(10, 0, 200, 10)];
//    vi.contentOffset=CGSizeMake(10, 30);
//    vi.font=[UIFont systemFontOfSize:10];
//    vi.backgroundColor=[UIColor cyanColor];
//    [sc addSubview:vi];
//    [vi release];
//    
//    NSLog(@"%@",flagView.infoDict);
//    [flagView.infoDict.description writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/info.txt"] atomically:YES encoding:4 error:nil];
//    sc.contentSize=CGSizeMake(320, vi.frame.size.height);
//    NSLog(@"%@",NSHomeDirectory());
    
    YJLSelectView *selectVi=[[YJLSelectView alloc] initWithFrame:CGRectMake(150, 40, 160, 30) title:@"这个是下拉菜单" options:@[@"选项1",@"选项2",@"选项3",@"选项4",@"选项1345",@"选项135",@"选项16",@"选项10",]];
    selectVi.delegate=self;
    selectVi.menuMaxHeight=0;
    [self.view addSubview:selectVi];
    NSLog(@"%@",selectVi.infoDict);
}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)selectView:(YJLSelectView*)selectView selectItem:(UIView *)itemView atIndex:(NSUInteger)index
{
    [selectView close];
}
@end
