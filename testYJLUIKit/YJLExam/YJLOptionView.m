//
//  YJLOptionView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-3.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#define OPTION_IMAGR_DEFAULT  [UIImage imageNamed:@"option_btn_default.png"]
#define OPTION_IMAGR_SELECTED [UIImage imageNamed:@"option_btn_selected.png"]

#define FLAG_OPTION_SELECTEVIRW @"YJLOptionView_YJLImageView_selectView"

#import "YJLOptionView.h"
#import "YJLImageView.h"
@interface YJLOptionView()
{
    YJLImageView *selectView;
    BOOL move;
}
@end
@implementation YJLOptionView
- (void)dealloc
{
    DEALLOC_PRINT;
    self.delegate=nil;
    [super dealloc];
}
-(void)setupDefineValues
{
    [super setupDefineValues];
    self.contentOffset=CGPointMake(20, 0);
}
-(void)setSelected:(BOOL)selected
{
    _selected=selected;
    selectView.image=_selected?OPTION_IMAGR_SELECTED:OPTION_IMAGR_DEFAULT;
}
-(void)createView
{
    [super createView];
    if (!selectView)
    {
        selectView=[[YJLImageView alloc] initWithFrame:CGRectMake(2,self.bounds.size.height/2-10 , 20, 20)];
        selectView.flag=FLAG_OPTION_SELECTEVIRW;
        selectView.image=_selected?OPTION_IMAGR_SELECTED:OPTION_IMAGR_DEFAULT;
        [self addSubview:selectView];
        [selectView release];
    }
    selectView.frame=CGRectMake(2,self.bounds.size.height/2-10 , 20, 20);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    move=NO;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    move=YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (move) return;
    self.selected=!self.selected;
    if (self.selected&&[self.delegate respondsToSelector:@selector(selectOptionView:)])
    {
        [self.delegate selectOptionView:self];
    }else if(!self.selected&&[self.delegate respondsToSelector:@selector(deselectOptionView:)])
    {
        [self.delegate deselectOptionView:self];
    }
}
@end
