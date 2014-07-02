//
//  YJLRefView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-2.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLRefView.h"
#import "YJLProgreeView.h"
#define SPAN_TO_REF    80
@interface YJLRefView()
{
    YJLProgreeView *proVi;
    UIActivityIndicatorView *ac;
    BOOL isLoading;
}
@end
@implementation YJLRefView

- (void)dealloc
{
    DEALLOC_PRINT;
    [super dealloc];
}
-(id)initWithContentView:(UIView *)contentView
{
    if (self=[super initWithFrame:contentView.frame]) {
        self.contentView=contentView;
    }
    return self;
}
-(void)setContentView:(UIView *)contentView
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _contentView=contentView;
    _contentView.frame=self.bounds;
    [self addSubview:_contentView];
    
    
    proVi=[[YJLProgreeView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    proVi.backgroundColor=[UIColor clearColor];
    proVi.defaultColor=[UIColor clearColor];
    proVi.progressColor=[UIColor colorWithRed:0.276 green:0.551 blue:0.414 alpha:1.000];
    proVi.progress=0;
    proVi.progressWidth=3;
    [self addSubview:proVi];
    [proVi release];
    
    proVi.center=CGPointMake(self.frame.size.width/2, -SPAN_TO_REF/2);
    
}
-(void)setContentOffset:(CGPoint)contentOffset
{
    _contentOffset=contentOffset;
    CGRect rect = self.contentView.frame;
    rect.origin.y=-_contentOffset.y;
    self.contentView.frame=rect;
    
    if (!isLoading) {
        CGPoint center=proVi.center;
        center.y=-SPAN_TO_REF/2-_contentOffset.y;
        center.y=center.y>SPAN_TO_REF/2?SPAN_TO_REF/2:center.y;
        proVi.center=center;
        ac.center=proVi.center;
        
        proVi.progress=(-SPAN_TO_REF/2-_contentOffset.y)/(SPAN_TO_REF/2);
    }
}
-(void)prepareToRefurbish
{
    [UIView animateWithDuration:.25 animations:^{
        self.contentOffset=CGPointMake(0, -SPAN_TO_REF);
    }];
    [self tryToRefurbish];
}
-(void)tryToRefurbish
{
    if (isLoading) {
        [UIView animateWithDuration:.25 animations:^{
            self.contentOffset=CGPointMake(0, -SPAN_TO_REF);
        }];
        return;
    }
    if (proVi.progress==1.0f) {
        if (!ac) {
            ac=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            ac.color=[UIColor whiteColor];
            [ac startAnimating];
            [self addSubview:ac];
            [ac release];
            ac.center=proVi.center;
        }
        isLoading=YES;
        proVi.hidden=YES;
        [UIView animateWithDuration:.25 animations:^{
            self.contentOffset=CGPointMake(0, -SPAN_TO_REF);
        }];
    }else{
        [UIView animateWithDuration:.25 animations:^{
            self.contentOffset=CGPointZero;
        }];
    }
}
-(void)refurbishFinish
{
    [UIView animateWithDuration:.25 animations:^{
        self.contentOffset=CGPointZero;
    } completion:^(BOOL finished) {
        if (finished) {
            isLoading=NO;
            proVi.hidden=NO;
            CGPoint center=proVi.center;
            center.y=-SPAN_TO_REF/2-_contentOffset.y;
            proVi.center=center;
            [ac removeFromSuperview];
            ac=nil;
        }
    }];
}
@end
