//
//  YJLRefView.h
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-2.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLFlagView.h"

@interface YJLRefView : YJLFlagView
@property(nonatomic,retain)UIView *contentView;
@property(nonatomic,assign)CGPoint contentOffset;
-(void)tryToRefurbish;
-(void)prepareToRefurbish;
-(void)refurbishFinish;
-(id)initWithContentView:(UIView *)contentView;
@end