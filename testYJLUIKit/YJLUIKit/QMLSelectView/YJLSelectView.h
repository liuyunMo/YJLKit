//
//  YJLSelectView.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-24.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//


#import "YJLTextObj.h"
@protocol YJLSelectViewDelegete;
@interface YJLSelectView : YJLView
@property(nonatomic,retain)NSArray       *options;
@property(nonatomic,assign)float         menuMaxHeight;
@property(nonatomic,assign)YJLDirection  direction;
@property(nonatomic,assign)CGPoint       menuOffset;
@property(nonatomic,copy)  NSString*     title;
@property(nonatomic,assign)float         menuWidth;
@property(nonatomic,readonly)BOOL        opening;

@property(nonatomic,assign)id<YJLSelectViewDelegete>delegate;
-(id)initWithFrame:(CGRect)frame title:(NSString *)title options:(NSArray *)options;
-(void)close;
-(BOOL)open;
@end
@protocol YJLSelectViewDelegete <NSObject>

@optional
-(UIView *)customItemAtIndex:(NSUInteger)index;
-(void)selectView:(YJLSelectView *)selectView setupItemProperties:(YJLTextObj **)textObj atIndex:(NSUInteger)index;
-(void)selectView:(YJLSelectView *)selectView createItemFinshed:(UIView *)itemView atIndex:(NSUInteger)index;
-(void)selectView:(YJLSelectView *)selectView createItemError:(NSError *)error atIndex:(NSUInteger)index;

-(BOOL)selectView:(YJLSelectView *)selectView shouldSelectItem:(UIView*)itemView atIndex:(NSUInteger)index;
-(void)selectView:(YJLSelectView *)selectView selectItem:(UIView *)itemView atIndex:(NSUInteger)index;
@end
