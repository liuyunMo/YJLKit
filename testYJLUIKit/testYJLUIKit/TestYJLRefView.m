//
//  TestYJLRefView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-2.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "TestYJLRefView.h"
@interface TestYJLRefView()
{
    YJLRefView *refView;
    float b_y;
}
@end
@implementation TestYJLRefView
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    refView=[[YJLRefView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height-64)];
    refView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    [self.view addSubview:refView];
    [refView release];
    
    UIView *vi=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    refView.contentView=vi;
    vi.backgroundColor=[UIColor lightGrayColor];
    [vi release];
    [refView prepareToRefurbish];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [vi addGestureRecognizer:pan];
    [pan release];
}
-(void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint point=[pan translationInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            b_y=refView.contentOffset.y;
            break;
        case UIGestureRecognizerStateChanged:
            refView.contentOffset=CGPointMake(0,b_y-point.y);
            break;
        case UIGestureRecognizerStateEnded:
            [refView tryToRefurbish];
            break;
        default:
            break;
    }
    
}
@end
