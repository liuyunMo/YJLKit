//
//  QMLSegItem.h
//  QMLib
//
//  Created by 流云_陌陌 on 14-8-12.
//  Copyright (c) 2014年 流云_陌陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMLSegItem : YJLObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,retain)UIColor *defaultTextColor;
@property(nonatomic,retain)UIColor *heightLightTextColor;
@property(nonatomic,retain)UIImage *defaultImage;
@property(nonatomic,retain)UIImage *heightLightImage;
@end
