//
//  YJLScrollLabel.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-16.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLFlagView.h"
#import "YJLTextObj.h"
enum YJLLabelScrollType{
    YJLLabelScrollTypeOrder,
    YJLLabelScrollTypeCircle,
    YJLLabelScrollTypeRevert
};
typedef NSUInteger YJLLabelScrollType;
@interface YJLScrollLabel : YJLFlagView
@property(nonatomic,retain)YJLTextObj *textObj;
@property(nonatomic,assign)YJLLabelScrollType type;
@end
