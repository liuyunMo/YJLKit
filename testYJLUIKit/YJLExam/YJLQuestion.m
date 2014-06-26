//
//  YJLQuestion.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-13.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLQuestion.h"

@implementation YJLQuestion
- (void)dealloc
{
    DEALLOC_PRINT;
    [_title release];
    [_options release];
    [_answers release];
    [_flags release];
    [super dealloc];
}
@end
