//
//  YJLContentView.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLFlagView.h"

@interface YJLContentView : YJLFlagView
@property(nonatomic,copy)NSString    *content;
@property(nonatomic,retain)UIFont    *font;
@property(nonatomic,retain)UIColor   *textColor;
@property(nonatomic,assign)CGPoint   contentOffset;

-(id)initWithString:(NSString *)string frame:(CGRect)frame;
-(void)createView;
@end
