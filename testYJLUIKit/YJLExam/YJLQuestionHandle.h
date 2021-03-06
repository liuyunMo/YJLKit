//
//  YJLQuestionHandle.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-13.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLObject.h"
#import "YJLQuestion.h"

@interface YJLQuestionHandle : YJLObject
@property(nonatomic,assign)int questionCount;
-(id)initWithQuestions:(NSArray*)questions;
-(int)getQuestionIdWithIndex:(NSUInteger)index;
-(YJLQuestion *)getQuestionWithIndex:(NSUInteger)index;
-(YJLQuestion *)getQuestionWithQuestionId:(int)questionId;
-(NSArray *)getAnswerWithQuestionId:(int)questionId;
-(NSArray *)getAnswerWithIndex:(NSUInteger)index;
@end
