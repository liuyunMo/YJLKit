//
//  YJLDrawLabel.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-16.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//


#import "YJLTextObj.h"
#import "YJLView.h"
@class YJLView,YJLTextObj;
@interface YJLDrawLabel :YJLView
@property(nonatomic,retain)    YJLTextObj  *textObj;
@property(nonatomic,readonly)  float        width;
-(void)redraw;
-(void)adjustFrame;
@end
