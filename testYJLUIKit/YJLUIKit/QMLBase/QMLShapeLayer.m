//
//  QMLShapeLayer.m
//  testYJLUIKit
//
//  Created by user on 14-9-15.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLShapeLayer.h"

@implementation QMLShapeLayer
@synthesize flag=_flag;
-(void)dealloc
{
    [_flag release];
    [super dealloc];
}
-(NSString *)flag
{
    if (!_flag) {
        return NSStringFromClass([self class]);
    }
    return _flag;
}
@end
