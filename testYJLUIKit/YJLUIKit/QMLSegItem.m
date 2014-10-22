//
//  QMLSegItem.m
//  QMLib
//
//  Created by 流云_陌陌 on 14-8-12.
//  Copyright (c) 2014年 流云_陌陌. All rights reserved.
//

#import "QMLSegItem.h"

@implementation QMLSegItem
- (void)dealloc
{
    DEALLOC_PRINT;
    [_title release];
    [_defaultTextColor release];
    [_heightLightTextColor release];
    [_defaultImage release];
    [_heightLightImage release];
    [super dealloc];
}

#pragma mark--   YJLCreateDelegate

+(id)createWithInfoDict:(NSDictionary*)infoDict
{
    QMLSegItem *item=[super createWithInfoDict:infoDict];
    
    NSString *title=[infoDict objectForKey:@"title"];
    if (title) {
        item.title=STR_LOCATION(title);
    }
    
    NSString *defaultTextColor=[infoDict objectForKey:@"defaultTextColor"];
    if (defaultTextColor) {
        UIColor *color=nil;
        getColorWithLatoutStr(defaultTextColor, &color);
        item.defaultTextColor=color;
    }
    
    NSString *heightLightTextColor=[infoDict objectForKey:@"heightLightTextColor"];
    if (defaultTextColor) {
        UIColor *color=nil;
        getColorWithLatoutStr(heightLightTextColor, &color);
        item.heightLightTextColor=color;
    }
    
    NSString *defaultImage=[infoDict objectForKey:@"defaultImage"];
    if (defaultImage) {
        UIImage *image=nil;
        getImageWithName(defaultImage, &image);
        item.defaultImage=image;
    }
    
    NSString *heightLightImage=[infoDict objectForKey:@"heightLightImage"];
    if (heightLightImage) {
        UIImage *image=nil;
        getImageWithName(heightLightImage, &image);
        item.heightLightImage=image;
    }
    return item;
}
@end
