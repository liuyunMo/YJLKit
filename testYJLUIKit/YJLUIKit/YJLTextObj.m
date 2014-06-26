//
//  YJLTextObj.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLTextObj.h"

@implementation YJLTextObj
-(void)setupDefineValues
{
    self.font=[UIFont systemFontOfSize:15];
    self.textColor=[UIColor whiteColor];
}
- (void)dealloc
{
    DEALLOC_PRINT;
    [_font release];
    [_text release];
    [_textColor release];
    [super dealloc];
}

#pragma mark-- YJLCreateDelegate Methods
+(NSArray *)getInfoDictKeys{
    NSMutableArray *arr=[NSMutableArray arrayWithArray:[super getInfoDictKeys]];
    [arr addObjectsFromArray:@[
                               @"text",
                               @"font",
                               @"textColor"
                               ]];
    return arr;
}
+(id)createWithInfoDict:(NSDictionary*)infoDict
{
    YJLTextObj *obj=[super createWithInfoDict:infoDict];
    NSString *text=[infoDict objectForKey:@"text"];
    if (text&&[text isKindOfClass:[NSString class]]) {
        obj.text=text;
    }
    UIFont *font=[infoDict objectForKey:@"font"];
    if (font&&[font isKindOfClass:[NSString class]]) {
        obj.font=font;
    }
    UIColor *textColor=[infoDict objectForKey:@"textColor"];
    if (textColor&&[textColor isKindOfClass:[UIColor class]]) {
        obj.textColor=textColor;
    }
    return obj;
}
@end
