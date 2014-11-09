//
//  YJLObject.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YJLLayoutDelegate;
@interface YJLObject : NSObject<YJLLayoutDelegate>
-(void)setupDefineValues;
@end
