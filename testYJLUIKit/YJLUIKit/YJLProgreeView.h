//
//  YJLProgreeView.h
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-6-26.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLFlagView.h"
enum:NSUInteger{
    kYJLProgressViewDefault,
    kYJLProgressViewRound
}YJLProgressViewType;
typedef enum : NSUInteger {
    YJLProgreeViewBorderTypePlain,
    YJLProgreeViewBorderTypeRound
} YJLProgreeViewBorderType;

@interface YJLProgreeView : YJLFlagView

@end
