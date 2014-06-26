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
