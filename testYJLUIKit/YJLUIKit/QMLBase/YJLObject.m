//
//  YJLObject.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLObject.h"

@implementation YJLObject
@synthesize flag=_flag;
-(NSString*)flag
{
    if (!_flag) {
        return NSStringFromClass([self class]);
    }
    return _flag;
}
-(id)init{
    if (self=[super init]) {
        [self setupDefineValues];
    }
    return self;
}
-(void)setupDefineValues{};
- (void)dealloc
{
    DEALLOC_PRINT;
    [_flag release];
    [super dealloc];
}
#pragma mark-- YJLCreateDelegate Methods
+(id)createWithInfoDict:(NSDictionary *)infoDict
{
    YJLObject *obj=[[[self class] alloc] init];
    NSString *flag=[infoDict objectForKey:@"flag"];
    if (flag) {
        obj.flag=flag;
    }
    return [obj autorelease];
}
@end
