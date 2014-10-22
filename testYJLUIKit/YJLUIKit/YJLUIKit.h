//
//  YJLUIKit.h
//  YJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>
#import "YJLDefine.h"
#import "QMLLayoutFunction.h"
#import "YJLView.h"
#import "YJLFlagView.h"
#import "YJLImageView.h"
#import "YJLContentView.h"
#import "YJLObject.h"
#import "YJLTextObj.h"
#import "YJLDrawLabel.h"
#import "YJLScrollLabel.h"
#import "YJLSelectView.h"
#import "YJLProgreeView.h"
#import "YJLRefurbishView.h"
#import "YJLRefView.h"
#import "YJLADControl.h"


@interface YJLUIKit : NSObject
+(NSString *)version;
+(CGFloat)getTextViewContentHeight:(UITextView *)textView;
//+(id<YJLLayoutDelegate>)viewWithInfoDict:(NSDictionary*)infoDict;
@end
