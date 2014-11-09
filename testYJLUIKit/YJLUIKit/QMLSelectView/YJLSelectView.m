//
//  YJLSelectView.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-24.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLSelectView.h"
#import "YJLContentView.h"
@interface YJLSelectView ()
{
    UILabel *titleLa;
    UIScrollView *menuView;
    BOOL animating;
    int lastSelectOptionTag;
}
@end
@implementation YJLSelectView
- (void)dealloc
{
    DEALLOC_PRINT;
    [_title release];
    [_options release];
    [super dealloc];
}
-(void)createView
{
    if (!titleLa) {
        titleLa=[[UILabel alloc] initWithFrame:self.bounds];
        titleLa.backgroundColor=[UIColor clearColor];
        titleLa.layer.borderColor=[UIColor whiteColor].CGColor;
        titleLa.layer.borderWidth=.5;
        titleLa.layer.cornerRadius=5;
        titleLa.textAlignment=UITextAlignmentCenter;
        titleLa.textColor=[UIColor whiteColor];
        [self addSubview:titleLa];
        [titleLa release];
    }
    titleLa.frame=self.bounds;
    titleLa.text=self.title;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview) {
        [self createView];
    }else{
        if (self.opening) {
            [menuView removeFromSuperview];
            menuView=nil;
        }
    }
}
-(id)initWithFrame:(CGRect)frame title:(NSString *)title options:(NSArray *)options
{
    if (self=[self initWithFrame:frame]) {
        SET_PAR(_title, title);
        SET_PAR(_options, options);
        [self createView];
    }
    return self;
}
-(void)setupDefineValues
{
    _menuOffset=CGPointZero;
    _direction=kYJLDirectionDown;
    _menuMaxHeight=80;
}

-(void)setTitle:(NSString *)title
{
    SET_PAR(_title, title);
    [self createView];
}

-(void)close
{
    if(!self.opening||animating)return;
    _opening=NO;
    animating=YES;
    [UIView animateWithDuration:.25 animations:^{
        CGRect rect=menuView.frame;
        rect.size.height=0;
        menuView.frame=rect;
    } completion:^(BOOL finished) {
        if (finished) {
            [menuView removeFromSuperview];
            menuView=nil;
            animating=NO;
        }
    }];
}
-(BOOL)open
{
    if (self.opening)    return NO;
    if (!self.superview) return NO;
    if (animating)       return NO;
    
    _opening=YES;
    float x=0,y=0,w=0,h=0;
    
    w=self.menuWidth==0?self.frame.size.width:self.menuWidth;
    
    switch (self.direction) {
        case kYJLDirectionDown:
            x=self.frame.origin.x+self.menuOffset.x;
            y=self.frame.origin.y+self.frame.size.height+self.menuOffset.y;
            break;
        case kYJLDirectionLeft:
            x=self.frame.origin.x-w+self.menuOffset.x;
            y=self.frame.origin.y+self.menuOffset.y;
            break;
        case kYJLDirectionRight:
            x=self.frame.origin.x+w+self.menuOffset.x;
            y=self.frame.origin.y+self.menuOffset.y;
            break;
        case kYJLDirectionUp:
            x=self.frame.origin.x+self.menuOffset.x;
            y=self.frame.origin.y+self.menuOffset.y;
            break;
    }
    
    if (!menuView) {
        menuView=[[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        menuView.bounces=NO;
        [self.superview addSubview:menuView];
    }
    [self.superview bringSubviewToFront:self];
    [self.superview bringSubviewToFront:menuView];
    
    for (int i=0; i<self.options.count; i++) {
        
        BOOL custom=NO;
        UIView *item=nil;
        if ([self.delegate respondsToSelector:@selector(customItemAtIndex:)]) {
            UIView *customVi=[self.delegate customItemAtIndex:i];
            if (customVi) {
                CGRect rect=customVi.frame;
                rect.origin.x=0;
                rect.origin.y=h;
                customVi.frame=rect;
                custom=YES;
                item=customVi;
            }
        }
        if (!custom) {
            NSString *option=[self.options objectAtIndex:i];
            if (![option isKindOfClass:[NSString class]]) {
                NSError *error=[NSError errorWithDomain:@"item must NSString obj" code:11 userInfo:nil];
                [self tryToPostError:error atIndex:i];
            }else{
                YJLTextObj *obj=[[YJLTextObj alloc] init];
                obj.text=option;
                if ([self.delegate respondsToSelector:@selector(selectView:setupItemProperties:atIndex:)])
                {
                    [self.delegate selectView:self setupItemProperties:&obj atIndex:i];
                }
                
                YJLContentView *contentVi=[[YJLContentView alloc] initWithString:option frame:CGRectMake(0, h, w, 10)];
                contentVi.backgroundColor = COLOR_WITH_RGB(40, 161, 114);
                contentVi.font=obj.font;
                contentVi.textColor=obj.textColor;
                [menuView addSubview:contentVi];
                item=contentVi;
            }
        }
        
        if (item) {
            item.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOption:)];
            [item addGestureRecognizer:tap];
            
            if ([self.delegate respondsToSelector:@selector(selectView:createItemFinshed:atIndex:)])
            {
                [self.delegate selectView:self createItemFinshed:item atIndex:i];
            }
            
            h+=item.frame.size.height;
            item.tag=i+1;
        }
    }
    
    float menuViHeight=(self.menuMaxHeight==0?h:self.menuMaxHeight);
    if(h>menuViHeight){
        menuView.contentSize=CGSizeMake(menuView.frame.size.width, h);
    }
    
    animating=YES;
    [UIView animateWithDuration:.25 animations:^{
        CGRect rect=menuView.frame;
        rect.size.height=menuViHeight;
        menuView.frame=rect;
    } completion:^(BOOL finished) {
        if (finished) {
            animating=NO;
        }
    }];
    return YES;
}
-(void)tapOption:(UITapGestureRecognizer *)tap
{
    
    if (lastSelectOptionTag!=tap.view.tag) {
        BOOL shouldSelect=YES;
        if ([self.delegate respondsToSelector:@selector(selectView:shouldSelectItem:atIndex:)])
        {
            shouldSelect=[self.delegate selectView:self shouldSelectItem:tap.view atIndex:tap.view.tag-1];
        }
        if (shouldSelect&&[self.delegate respondsToSelector:@selector(selectView:selectItem:atIndex:)])
        {
            [self.delegate selectView:self selectItem:tap.view atIndex:tap.view.tag-1];
        }
        lastSelectOptionTag=tap.view.tag;
    }
}
-(void)tryToPostError:(NSError *)error atIndex:(int)index
{
    if ([self.delegate respondsToSelector:@selector(selectView:createItemError:atIndex:)]) {
        [self.delegate selectView:self createItemError:error atIndex:index];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (animating) return;
    self.opening?[self close]:[self open];
}
@end
