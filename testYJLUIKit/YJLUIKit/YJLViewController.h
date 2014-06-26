//
//  YJLViewController.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-3.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJLViewController : UIViewController<YJLFlagDelegate>
@property(nonatomic,strong)NSDictionary *userInfo;
@property(nonatomic,copy)void (^result)(id userInfo);
@end
