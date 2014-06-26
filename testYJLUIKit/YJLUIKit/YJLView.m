//
//  YJLView.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLView.h"

@implementation YJLView
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
- (void)dealloc
{
    DEALLOC_PRINT;
    [super dealloc];
}
#pragma mark -- YJLLayoutDelegate Methods
+(NSArray *)getInfoDictKeys
{
    Class currentClass=[self class];
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObjectsFromArray:@[
                     @"frame",
                     @"tag",
                     @"backgroundColor"
                     ]];
    while (strcmp(class_getName(currentClass), "YJLView")!=0) {
        unsigned int proCount=0;
        objc_property_t *proList=class_copyPropertyList(currentClass, &proCount);
        for (int i=0; i<proCount; i++) {
            const char *proName=property_getName(proList[i]);
            [arr addObject:[NSString stringWithUTF8String:proName]];
        }
        currentClass=class_getSuperclass(currentClass);
        
    }
    return arr;
}
+(id)createWithInfoDict:(NSDictionary*)infoDict
{
    UIView *view=[[[self class] alloc] init];
    for (NSString *key in infoDict.allKeys) {
        [view setValue:[infoDict objectForKey:key] forKey:key];
    }
    return view;
}
-(NSDictionary *)infoDict
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    for (NSString *key in [[self class] getInfoDictKeys]) {
        id value=[self valueForKey:key];
        if (value) {
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}
@end
