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

+(id)createWithInfoDict:(NSDictionary*)infoDict
{
    YJLTextObj *obj=[super createWithInfoDict:infoDict];
    NSString *text=[infoDict objectForKey:@"text"];
    if (text) {
        obj.text=text;
    }
    NSString *fontStr=[infoDict objectForKey:@"font"];
    if (fontStr) {
        UIFont *font=nil;
        getFontWithLayoutStr(fontStr, &font);
        obj.font=font;
    }
    NSString *textColor=[infoDict objectForKey:@"textColor"];
    if (textColor) {
        UIColor *color=nil;
        getColorWithLayoutStr(textColor, &color);
        obj.textColor=color;
    }
    return obj;
}
@end
