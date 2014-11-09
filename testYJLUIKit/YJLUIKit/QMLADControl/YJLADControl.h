//
//  YJLADControl.h
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-20.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLView.h"
@protocol YJLADControlDelegate;
@interface YJLADControl : YJLView
@property(nonatomic,assign)NSUInteger itemCount;
@property(nonatomic,assign)YJLDirection scrollDirection;
@property(nonatomic,assign)BOOL autoScroll;
@property(nonatomic,assign)BOOL canSwipeGes;
@property(nonatomic,assign)int currentIndex;
@property(nonatomic,assign)NSTimeInterval showTime;
@property(nonatomic,assign)NSTimeInterval transitionTime;
@property(nonatomic,assign)id<YJLADControlDelegate> delegate;

-(void)stopAnimation;
-(void)startAnimation;
-(YJLView *)getCurrentView;
-(void)showViewWithIndex:(int)index;
@end


@protocol YJLADControlDelegate <NSObject>
@optional
-(void)ADControl:(YJLADControl*)control willShowView:(YJLView *)view atIndex:(int)index;
-(void)ADControl:(YJLADControl*)control showView:(YJLView *)view atIndex:(int)index;
@end