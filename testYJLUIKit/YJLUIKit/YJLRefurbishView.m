//
//  YJLRefurbishView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-1.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLRefurbishView.h"
#import "YJLProgreeView.h"
@interface YJLRefurbishView()
{
    YJLProgreeView *proView;
    UIActivityIndicatorView *ac;
}
@end
@implementation YJLRefurbishView
- (void)dealloc
{
    DEALLOC_PRINT;
    [self removeKVO];
    [super dealloc];
}
- (void)didMoveToSuperview
{
    NSLog(@"%@",[NSValue valueWithUIEdgeInsets:self.contentInset]);
    NSLog(@"%@",[NSValue valueWithCGPoint:self.contentOffset]);
    NSLog(@"%@",[NSValue valueWithCGSize:self.contentSize]);
}
-(void)setupDefineValues
{
    self.clipsToBounds=YES;
    [self addKVO];
}
-(void)removeKVO
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
    for (UIPanGestureRecognizer *ges in self.gestureRecognizers)
    {
        if ([ges isKindOfClass:[UIPanGestureRecognizer class]])
        {
            [ges removeObserver:self forKeyPath:@"state"];
        }
    }
}
-(void)addKVO
{
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    for (UIPanGestureRecognizer *ges in self.gestureRecognizers)
    {
        if ([ges isKindOfClass:[UIPanGestureRecognizer class]])
        {
            [ges addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        }
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset=[[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (offset.y<-40) {
            proView.progress=fabsf(offset.y+40)/20;
        }else{
            proView.progress=0;
        }
    }
    if ([keyPath isEqualToString:@"state"]) {
        UIGestureRecognizerState state=[[change objectForKey:NSKeyValueChangeNewKey] unsignedIntegerValue];
        if (state==UIGestureRecognizerStateEnded&&proView.progress>=1.0f)
        {
            [self prepareToRefurbish];
            proView.progress=0;
        }
    }
}
-(void)prepareToRefurbish
{
    if (!ac) {
        ac=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        ac.color=[UIColor redColor];
        [ac startAnimating];
        [self addSubview:ac];
        [ac release];
        ac.center=proView.center;
    }
    proView.hidden=YES;
    
    self.contentInset=UIEdgeInsetsMake(60,0,0,0);
    [self performSelector:@selector(refurbishFinish) withObject:nil afterDelay:3];
}
-(void)refurbishFinish
{
    [UIView animateWithDuration:.5 animations:^{
        [self setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    } completion:^(BOOL finished) {
        if (finished) {
            proView.hidden=NO;
            [ac removeFromSuperview];
            ac=nil;
        }
    }];
}
-(void)createView
{
    if (!proView) {
        proView=[[YJLProgreeView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        proView.backgroundColor=[UIColor clearColor];
        proView.defaultColor=[UIColor clearColor];
        proView.progressColor=[UIColor colorWithRed:0.276 green:0.551 blue:0.414 alpha:1.000];
        proView.progress=0;
        proView.progressWidth=3;
        [self addSubview:proView];
        [proView release];
    }
    proView.center=CGPointMake(self.frame.size.width/2, -30);
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupDefineValues];
        [self createView];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self=[super initWithFrame:frame style:style]) {
        [self setupDefineValues];
        [self createView];
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        [self setupDefineValues];
        [self createView];
    }
    return self;
}
@end
