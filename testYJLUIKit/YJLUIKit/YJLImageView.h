//
//  YJLImageView.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJLImageView : UIImageView<YJLLayoutDelegate>
@property(nonatomic,assign)float scale;//0--1 default .5;
@property(nonatomic,copy)NSString *flag;
-(void)setupDefineValues;
@end
