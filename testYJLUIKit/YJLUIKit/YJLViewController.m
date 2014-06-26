//
//  YJLViewController.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-3.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLViewController.h"

@interface YJLViewController ()

@end

@implementation YJLViewController
@synthesize flag=_flag;
- (void)dealloc
{
    DEALLOC_PRINT;
    [_userInfo release];
    if (_result) {
        Block_release(_result);
    }
    [super dealloc];
}

#pragma mark -- YJLFlagDelegate Methods
-(NSString*)flag
{
    if (!_flag) {
        return NSStringFromClass([self class]);
    }
    return _flag;
}
@end
