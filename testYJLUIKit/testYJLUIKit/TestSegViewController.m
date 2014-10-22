//
//  TestSegViewController.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-8-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "TestSegViewController.h"
#import "QMLSegItem.h"
#import "QMLSegmentControl.h"
@interface TestSegViewController ()

@end

@implementation TestSegViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//    NSArray *tabImages=@[
//                         @"pic_tab1_default.png",@"pic_tab1_select.png",
//                         @"pic_tab2_default.png",@"pic_tab2_select.png",
//                         @"pic_tab3_default.png",@"pic_tab3_select.png",
//                         @"pic_tab4_default.png",@"pic_tab4_select.png"
//                         ];
//    NSArray *tabTitles=@[@"连接",@"音乐",@"设置",@"关于"];
//    NSMutableArray *tabItems=[NSMutableArray array];
//    for (int i=0; i<tabTitles.count; i++) {
//        QMLSegItem *item=[[QMLSegItem alloc] init];
//        item.title=[tabTitles objectAtIndex:i];
//        item.defaultTextColor=[UIColor blackColor];
//        item.heightLightTextColor=[UIColor redColor];
//        item.defaultImage=[UIImage imageNamed:[tabImages objectAtIndex:i*2]];
//        item.heightLightImage=[UIImage imageNamed:[tabImages objectAtIndex:i*2+1]];
//        [tabItems addObject:item];
//        [item release];
//    }
//    
//	QMLSegmentControl *tab=[[QMLSegmentControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, 320, 50) items:tabItems];
//    tab.backgroundColor=[UIColor lightGrayColor];
//    tab.selectIndex=0;
//    __block typeof(self)bSelf=self;
//    tab.valueChanged=^(int index){
//        [bSelf valueChagedTo:index];
//    };
//    [self.view addSubview:tab];
//    [tab release];
//    
    
    NSArray *segImages=@[
                         @"btn_segment1_default.png",@"btn_segment1_select.png",
                         @"btn_segment2_default.png",@"btn_segment2_select.png",
                         @"btn_segment3_default.png",@"btn_segment3_select.png"
                         ];
    NSMutableArray *segItems=[NSMutableArray array];
    for (int i=0; i<segImages.count/2; i++) {
        QMLSegItem *item=[[QMLSegItem alloc] init];
        item.defaultImage=[UIImage imageNamed:[segImages objectAtIndex:i*2]];
        item.heightLightImage=[UIImage imageNamed:[segImages objectAtIndex:i*2+1]];
        [segItems addObject:item];
        [item release];
    }
    
    QMLSegmentControl *seg=[[QMLSegmentControl alloc] initWithFrame:CGRectMake(40,100, 48*3, 44) items:segItems];
    seg.selectIndex=0;
    [self.view addSubview:seg];
    [seg release];
    
    QMLSegmentControl *control=getInstanceWithLayoutFile(@"QMLItem",YES);
    [self.view addSubview:control];
}
-(void)valueChagedTo:(int)index
{
    NSLog(@"%d",index);
}
- (void)dealloc
{
    DEALLOC_PRINT;
    [super dealloc];
}


@end
