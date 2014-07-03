//
//  YJLQuestionView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-3.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLQuestionView.h"

@implementation YJLQuestionView
- (void)dealloc
{
    DEALLOC_PRINT;
    [_question release];
    [super dealloc];
}
@end
