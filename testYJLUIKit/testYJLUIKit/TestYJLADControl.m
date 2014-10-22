//
//  TestYJLADControl.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-20.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "TestYJLADControl.h"

@interface TestYJLADControl ()<YJLADControlDelegate>
{
    YJLADControl *control;
    CALayer *layer;
}
@end

@implementation TestYJLADControl
- (void)dealloc
{
    DEALLOC_PRINT;
    control.delegate=nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    control=[[YJLADControl alloc] initWithFrame:self.view.bounds];
    control.delegate=self;
    control.itemCount=2;
    control.autoScroll=YES;
    [self.view addSubview:control];
    [control release];
    layer=[CALayer layer];
    layer.frame=control.bounds;
    layer.backgroundColor=[UIColor colorWithRed:.2 green:.3 blue:.6 alpha:1].CGColor;
    [control.layer insertSublayer:layer atIndex:0];
}
-(void)ADControl:(YJLADControl*)contrl willShowView:(YJLView *)view atIndex:(int)index
{
    UILabel *im=[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    im.text=[NSString stringWithFormat:@"%d",index+1];
    im.backgroundColor=[UIColor whiteColor];
    im.textAlignment=UITextAlignmentCenter;
    im.center=CGPointMake(160, self.view.bounds.size.height/2);
    [view addSubview:im];
    [im release];
    
    
    [CATransaction setAnimationDuration:control.transitionTime];
    [CATransaction setDisableActions:NO];
    [layer setBackgroundColor:(index==0?[UIColor colorWithRed:.2 green:.3 blue:.6 alpha:1].CGColor:[UIColor colorWithRed:.2 green:.5 blue:.3 alpha:1].CGColor)];
    
}
-(void)ADControl:(YJLADControl*)control showView:(YJLView *)view atIndex:(int)index
{
    
    
}
@end
