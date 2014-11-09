//
//  YJLADControl.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-20.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//
#define FLAG_CURRENT_VIEW  @"YJLADControl_YJLFlagView_currentView"
#define FLAG_NEXT_VIEW     @"YJLADControl_YJLFlagView_nextView"
#import "YJLADControl.h"
@interface YJLADControl ()
{
    YJLView *currentView;
    YJLView *nextView;
    NSTimer *timer;
    float timeCount;
    BOOL transiting;
}
//@property(nonatomic,retain)NSDate *beginDate;
@end
@implementation YJLADControl
- (void)dealloc
{
    DEALLOC_PRINT;
    [self endTimer];
    self.delegate=nil;
    [super dealloc];
}
-(void)setupDefineValues
{
    _scrollDirection=kYJLDirectionLeft;
    _showTime=2.0f;
    _transitionTime=.5f;
    _currentIndex=0;
    _autoScroll=YES;
}
-(void)setItemCount:(NSUInteger)itemCount
{
    _itemCount=itemCount;
    
    if (nextView) {
        [nextView removeFromSuperview];
        nextView=nil;
    }
    
    if (_itemCount>0) {
        if (!currentView) {
            currentView=[[YJLView alloc] initWithFrame:self.bounds];
            currentView.flag=FLAG_CURRENT_VIEW;
            [self addSubview:currentView];
            [currentView release];
            [self willShowView:currentView atIndex:self.currentIndex];
            [self showViewAtIndex:self.currentIndex];
        }
    }else{
        if (currentView) {
            [currentView removeFromSuperview];
            currentView=nil;
        }
    }
}
-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll=autoScroll;
    if (_autoScroll) {
        timer=[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }else{
        [self endTimer];
    }
}
-(void)setCurrentIndex:(int)currentIndex
{
    if (self.itemCount==0) {
        _currentIndex=0;
    }else{
        _currentIndex=currentIndex<0?self.itemCount-1:currentIndex;
        _currentIndex=_currentIndex>self.itemCount-1?0:_currentIndex;
    }
}
-(void)setCanSwipeGes:(BOOL)canSwipeGes
{
    _canSwipeGes=canSwipeGes;
    if (_canSwipeGes) {
        UISwipeGestureRecognizer *leftSwi=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction)];
        leftSwi.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftSwi];
        
        UISwipeGestureRecognizer *rightSwi=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction)];
        rightSwi.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightSwi];
    }else{
        for (UISwipeGestureRecognizer *swipe in self.gestureRecognizers) {
            if ([swipe isKindOfClass:[UISwipeGestureRecognizer class]]) {
                [self removeGestureRecognizer:swipe];
            }
        }
    }
}
-(void)rightSwipeAction
{
    if (transiting) {
        return;
    }
    timeCount=0;
    [self beginTransition:NO];
}
-(void)leftSwipeAction
{
    if (transiting) {
        return;
    }
    timeCount=0;
    [self beginTransition:YES];
}
-(void)startAnimation
{
    if (!timer&&_autoScroll) {
        timer=[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
}
-(void)stopAnimation
{
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
}
-(void)endTimer
{
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
}
-(void)timerRun
{
    if (!self.superview) {
        [self stopAnimation];
        return;
    }
    timeCount+=.1f;
    if (timeCount>=_showTime&&_autoScroll)
    {
        timeCount=0;
        [self beginTransition:YES];
    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self endTimer];
    }
}
-(YJLView *)getCurrentView
{
    return currentView;
}
-(void)beginTransition:(BOOL)next
{
    transiting=YES;
    float width=self.frame.size.width;
    float height=self.frame.size.height;
    CGRect nextRect,preRect;
    switch (self.scrollDirection) {
        case kYJLDirectionLeft:
            self.currentIndex=self.currentIndex+(next?1:-1);
            nextRect=CGRectMake(width, 0, width, height);
            preRect=CGRectMake(-width, 0, width, height);
            break;
        case kYJLDirectionRight:
            self.currentIndex=self.currentIndex-(next?1:-1);
            nextRect=CGRectMake(-width, 0, width, height);
            preRect=CGRectMake(width, 0, width, height);
            break;
        case kYJLDirectionDown:
            self.currentIndex=self.currentIndex-(next?1:-1);
            nextRect=CGRectMake(0, -height, width, height);
            preRect=CGRectMake(0, height, width, height);
            break;
        case kYJLDirectionUp:
            self.currentIndex=self.currentIndex+(next?1:-1);
            nextRect=CGRectMake(0, height, width, height);
            preRect=CGRectMake(0, -height, width, height);
            break;
    }
    if (!nextView) {
        nextView=[[YJLView alloc] initWithFrame:next?nextRect:preRect];
        nextView.userInteractionEnabled=YES;
        nextView.flag=FLAG_NEXT_VIEW;
        [self addSubview:nextView];
        [nextView release];
    }
    nextView.frame=next?nextRect:preRect;
    [self willShowView:nextView atIndex:self.currentIndex];
    
    __block typeof(self)bSelf=self;
    [UIView animateWithDuration:self.transitionTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        nextView.frame=bSelf.bounds;
        currentView.frame=next?preRect:nextRect;
    } completion:^(BOOL finished) {
        [bSelf endTransition];
    }];
}
-(void)endTransition
{
    transiting=NO;
    [currentView removeFromSuperview];
    currentView=nextView;
    currentView.flag=FLAG_CURRENT_VIEW;
    nextView=nil;
    [self showViewAtIndex:self.currentIndex];
}
-(void)showViewWithIndex:(int)index
{
    self.currentIndex=index;
    
    if (!nextView) {
        nextView=[[YJLView alloc] initWithFrame:self.bounds];
        nextView.userInteractionEnabled=YES;
        nextView.flag=FLAG_NEXT_VIEW;
        [self addSubview:nextView];
        [nextView release];
    }else{
        nextView.frame=self.bounds;
    }
    
    [self willShowView:nextView atIndex:self.currentIndex];
    
    [self endTransition];
}
-(void)willShowView:(YJLView *)view atIndex:(int)index
{
    if ([self.delegate respondsToSelector:@selector(ADControl:willShowView:atIndex:)])
    {
        [self.delegate ADControl:self willShowView:view atIndex:index];
    }
}
-(void)showViewAtIndex:(int)index
{
    if ([self.delegate respondsToSelector:@selector(ADControl:showView:atIndex:)])
    {
        [self.delegate ADControl:self showView:currentView atIndex:index];
    }
}
@end
