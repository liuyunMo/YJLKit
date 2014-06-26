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
//+(NSArray *)getInfoDictKeys
//{
//    Class currentClass=[self class];
//    NSMutableArray *arr=[NSMutableArray array];
//    [arr addObjectsFromArray:@[
//                               @"flag"
//                               ]];
//    while (strcmp(class_getName(currentClass), "YJLObject")!=0) {
//        unsigned int proCount=0;
//        objc_property_t *proList=class_copyPropertyList(currentClass, &proCount);
//        for (int i=0; i<proCount; i++) {
//            const char *proName=property_getName(proList[i]);
//            [arr addObject:[NSString stringWithUTF8String:proName]];
//        }
//        currentClass=class_getSuperclass(currentClass);
//        
//    }
//    return arr;
//}
GET_INFO_DICT_KEYS_IMPLEMENTATION(@"flag","YJLObject")
CREATE_WITH_INFO_DICT_IMPLEMENTATION
INFO_DICT_IMPLEMENTATION
@end
