//
//  YJLLayoutDelegate.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YJLLayoutDelegate <NSObject>
@required
@property(nonatomic,readonly)NSDictionary *infoDict;
+(NSArray *)getInfoDictKeys;
+(id)createWithInfoDict:(NSDictionary*)infoDict;
//+(BOOL)writeToFileAtPath:(NSString *)path;
@end

@protocol YJLCreateDelegate <YJLLayoutDelegate>
@end

//keyStr NSString 用,连接每个属性 如：@"frame,tag,backgroundColor"
//baseClass const char*
//示例： YJLLAYOUTDELEGATE_IMPLEMENTATION(@"frame,tag,backgroundColor","YJLView")

#define YJLLAYOUTDELEGATE_IMPLEMENTATION(keyStr,baseClass)\
GET_INFO_DICT_KEYS_IMPLEMENTATION(keyStr,baseClass) \
CREATE_WITH_INFO_DICT_IMPLEMENTATION \
INFO_DICT_IMPLEMENTATION




#define GET_INFO_DICT_KEYS_IMPLEMENTATION(keyStr,baseClass) \
+(NSArray *)getInfoDictKeys \
{ \
    Class currentClass=[self class]; \
    NSMutableArray *arr=[NSMutableArray array]; \
    [arr addObjectsFromArray:[keyStr componentsSeparatedByString:@","]]; \
    while (strcmp(class_getName(currentClass), baseClass)!=0) { \
        unsigned int proCount=0;\
        objc_property_t *proList=class_copyPropertyList(currentClass, &proCount); \
        for (int i=0; i<proCount; i++) { \
            const char *proName=property_getName(proList[i]); \
            [arr addObject:[NSString stringWithUTF8String:proName]]; \
        } \
        currentClass=class_getSuperclass(currentClass); \
    } \
    return arr; \
}

#define CREATE_WITH_INFO_DICT_IMPLEMENTATION \
+(id)createWithInfoDict:(NSDictionary*)infoDict \
{ \
    UIView *view=[[[self class] alloc] init]; \
    for (NSString *key in infoDict.allKeys) { \
        [view setValue:[infoDict objectForKey:key] forKey:key]; \
    } \
    return view; \
}


#define INFO_DICT_IMPLEMENTATION \
-(NSDictionary *)infoDict \
{ \
    NSMutableDictionary *dict=[NSMutableDictionary dictionary]; \
    for (NSString *key in [[self class] getInfoDictKeys]) { \
        id value=[self valueForKey:key]; \
        if (value) { \
            [dict setObject:value forKey:key]; \
        } \
    } \
    return dict; \
}


