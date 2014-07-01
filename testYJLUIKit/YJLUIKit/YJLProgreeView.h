//
//  YJLProgreeView.h
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-6-26.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLFlagView.h"
typedef enum:NSUInteger{
    YJLProgressViewDefault,
    YJLProgressViewRound,
    YJLProgressViewPie
}YJLProgressViewType;
typedef enum : NSUInteger {
    YJLProgressViewBorderTypePlain,
    YJLProgressViewBorderTypeRound
} YJLProgressViewBorderType;

@interface YJLProgreeView : YJLFlagView
@property(nonatomic,assign)YJLProgressViewType        type;
@property(nonatomic,assign)YJLProgressViewBorderType  borderType;
@property(nonatomic,assign)UIColor *                  defaultColor;
@property(nonatomic,retain)UIColor *                  progressColor;
@property(nonatomic,assign)float                      progress;     //0-1
@property(nonatomic,assign)float                      progressWidth;

@property(nonatomic,copy)VVBlock                      progressChanged;
@end
