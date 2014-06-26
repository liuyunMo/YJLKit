//
//  YJLImageView.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLImageView.h"

@implementation YJLImageView
@synthesize flag=_flag;
- (void)dealloc
{
    DEALLOC_PRINT;
    [_flag release];
    [super dealloc];
}
-(void)setupDefineValues
{
    _scale=.5;
}
-(id)initWithImage:(UIImage *)image
{
    if (self=[super initWithImage:image]) {
        [self setupDefineValues];
        [self adjustFrame];
    }
    return self;
}
-(void)setScale:(float)scale{
    _scale=scale>0?scale:0;
    _scale=_scale>1?1:_scale;
    [self adjustFrame];
}
-(void)adjustFrame
{
    if (self.image) {
        CGRect rect = self.frame;
        rect.size.width=self.image.size.width*self.scale;
        rect.size.height = self.image.size.height*self.scale;
        self.frame=rect;
    }
}
#pragma mark -- YJLFlagDelegate Methods
-(NSString *)flag
{
    if (!_flag) {
        return NSStringFromClass([self class]);
    }
    return _flag;
}
#pragma mark -- YJLLayoutDelegate Methods
+(NSArray *)getInfoDictKeys
{
    Class currentClass=[self class];
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObjectsFromArray:@[
                               @"frame",
                               @"tag",
                               @"backgroundColor",
                               @"flag"
                               ]];
    while (strcmp(class_getName(currentClass), "YJLImageView")!=0) {
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
