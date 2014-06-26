//
//  YJLQuestionHandle.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-13.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLQuestionHandle.h"
@interface YJLQuestionHandle ()
{
    NSMutableArray       *qIds;
    NSMutableDictionary  *allQuestion;
}
@end
@implementation YJLQuestionHandle
- (void)dealloc
{
    DEALLOC_PRINT;
    [qIds release];
    [allQuestion release];
    [super dealloc];
}
-(id)init
{
    if (self=[super init]) {
        [self initData];
    }
    return self;
}
-(void)initData
{
    if (!allQuestion) {
        allQuestion=[[NSMutableDictionary alloc] init];
    }
    if (!qIds) {
        qIds=[[NSMutableArray alloc] init];
    }
}
-(id)initWithQuestions:(NSArray*)questions
{
    if (self=[self init]) {
        [self initData];
        NSMutableArray *t_q_ids=[[NSMutableArray alloc] initWithCapacity:questions.count];
        for (YJLQuestion *question in questions) {
            [t_q_ids addObject:@(question.questionId)];
            [allQuestion setObject:question forKey:@(question.questionId)];
        }
        [qIds addObjectsFromArray:[t_q_ids sortedArrayUsingSelector:@selector(compare:)]];
        [t_q_ids release];
    }
    return self;
}
-(int)questionCount
{
    return qIds.count;
}
-(int)getQuestionIdWithIndex:(unsigned int)index
{
    if(index>self.questionCount-1){
        return -1;
    }else{
        return [[qIds objectAtIndex:index] intValue];
    }
}
-(YJLQuestion *)getQuestionWithIndex:(unsigned int)index
{
    int qId=[self getQuestionIdWithIndex:index];
    if (qId!=-1) {
        return [self getQuestionWithQuestionId:qId];
    }
    return nil;
}
-(YJLQuestion *)getQuestionWithQuestionId:(int)questionId
{
    return [allQuestion objectForKey:@(questionId)];
}
-(NSArray *)getAnswerWithQuestionId:(int)questionId
{
    YJLQuestion*question=[allQuestion objectForKey:@(questionId)];
    if (question) {
        return [question.answers sortedArrayUsingSelector:@selector(compare:)];
    }
    return nil;
}
-(NSArray *)getAnswerWithIndex:(unsigned int)index
{
    if(index>self.questionCount-1){
        return nil;
    }
    int qId=[self getQuestionIdWithIndex:index];
    return [self getAnswerWithQuestionId:qId];
}
@end
