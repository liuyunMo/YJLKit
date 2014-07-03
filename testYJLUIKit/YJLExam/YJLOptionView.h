//
//  YJLOptionView.h
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-3.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLContentView.h"
@protocol YJLOptionViewDelegate;
@interface YJLOptionView : YJLContentView
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,assign)id<YJLOptionViewDelegate>delegate;
@end
@protocol YJLOptionViewDelegate <NSObject>
@optional
-(void)selectOptionView:(YJLOptionView *)optionView;
-(void)deselectOptionView:(YJLOptionView *)optionView;
@end