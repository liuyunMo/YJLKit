//
//  YJLView.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLView.h"

@implementation YJLView
@synthesize flag=_flag;
-(NSString*)flag
{
    if (!_flag) {
        return NSStringFromClass([self class]);
    }
    return _flag;
}
- (void)dealloc
{
    DEALLOC_PRINT;
    [_flag release];
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupDefineValues];
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        [self setupDefineValues];
    }
    return self;
}
-(void)setupDefineValues
{
    
}

#pragma mark -- YJLLayoutDelegate Methods
+(id)createWithInfoDict:(NSDictionary*)infoDict
{
    YJLView *vi=[[[self class] alloc]init];
    NSString *frame=[infoDict objectForKey:@"frame"];
    if (frame) {
        CGRect rect;
        getFrameWithLayoutStr(frame, &rect);
        vi.frame=rect;
    }
    NSString *backgroundColor=[infoDict objectForKey:@"backgroundColor"];
    if (backgroundColor) {
        UIColor *color=nil;
        getColorWithLayoutStr(backgroundColor, &color);
        vi.backgroundColor=color;
    }
   
    NSString *flag=[infoDict objectForKey:@"flag"];
    if (flag) {
        vi.flag=flag;
    }
    
    NSString *tag=[infoDict objectForKey:@"tag"];
    if (tag) {
        vi.tag=[tag intValue];
    }
    return [vi autorelease];
}
@end
