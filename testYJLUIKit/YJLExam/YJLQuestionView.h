//
//  YJLQuestionView.h
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-3.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//


#import "YJLQuestion.h"
@protocol YJLQuestionViewDelegate;
@interface YJLQuestionView : YJLView
@property(nonatomic,assign)YJLQuestion *question;
@property(nonatomic,assign)BOOL        ableAnswer;
@property(nonatomic,readonly)BOOL      showingParse;
@property(nonatomic,readonly)CGSize    contentSize;

@property(nonatomic,assign)id<YJLQuestionViewDelegate> delegate;
@end
@protocol YJLQuestionViewDelegate <NSObject>

@optional

@end
