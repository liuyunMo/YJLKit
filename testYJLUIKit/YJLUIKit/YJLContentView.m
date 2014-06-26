//
//  YJLContentView.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLContentView.h"
@interface YJLContentView()
{
    UITextView *contentView;
}
@end
@implementation YJLContentView
-(void)setupDefineValues
{
    [super setupDefineValues];
    self.userInteractionEnabled=NO;
    _font=[[UIFont systemFontOfSize:15] retain];
    _textColor=[[UIColor blackColor] retain];
    _contentOffset=CGSizeMake(0, 0);
}
-(id)initWithString:(NSString *)string frame:(CGRect)frame
{
    if (self=[self initWithFrame:frame]) {
        [self setupDefineValues];
        self.content=string;
    }
    return self;
}
-(void)createView
{
    if (!contentView)
    {
        contentView=[[UITextView alloc] initWithFrame:CGRectMake(self.contentOffset.width, self.contentOffset.height, self.bounds.size.width-self.contentOffset.width, self.bounds.size.height)];
        contentView.editable=self.userInteractionEnabled;
        contentView.backgroundColor=[UIColor clearColor];
        contentView.userInteractionEnabled=self.userInteractionEnabled;
        [self addSubview:contentView];
        [contentView release];
    }
    
    
    contentView.textColor = self.textColor;
    contentView.font      = self.font;
    contentView.text      = self.content;
    [self adjustFrame];
}
-(void)adjustFrame
{
    contentView.frame     = CGRectMake(self.contentOffset.width,
                                       self.contentOffset.height,
                                       self.bounds.size.width-self.contentOffset.width,
                                       self.bounds.size.height-self.contentOffset.height);
    float height=[YJLUIKit getTextViewContentHeight:contentView];
    CGRect selfRect=self.frame;
    selfRect.size.height=self.contentOffset.height+height;
    self.frame=selfRect;//会触发 contentView.frame发成改变
}
-(void)dealloc
{
    DEALLOC_PRINT;
    [_textColor release];
    [_font release];
    [_content release];
    [super dealloc];
}
-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    contentView.editable=self.userInteractionEnabled;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    contentView.frame     = CGRectMake(self.contentOffset.width,
                                       self.contentOffset.height,
                                       self.bounds.size.width-self.contentOffset.width,
                                       self.bounds.size.height-self.contentOffset.height);
}
-(void)setContent:(NSString *)content
{
    [content retain];
    [_content release];
    _content=content;
    [self createView];
}
-(void)setContentOffset:(CGSize)contentOffset
{
    _contentOffset=contentOffset;
    [self createView];
}
-(void)setFont:(UIFont *)font
{
    [font retain];
    [_font release];
    _font=font;
    [self createView];
}
-(void)setTextColor:(UIColor *)textColor
{
    [textColor retain];
    [_textColor release];
    _textColor=textColor;
    if (!contentView)
    {
        [self createView];
    }else{
        contentView.textColor=_textColor;
    }
}

@end
