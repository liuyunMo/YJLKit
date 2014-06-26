//
//  YJLQuestion.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-13.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLObject.h"
enum YJLQuestionType{
    kQTSingle,//单选
};
typedef unsigned int YJLQuestionType;
@interface YJLQuestion : YJLObject
@property(nonatomic,assign) int             questionId;
@property(nonatomic,assign) YJLQuestionType type;
@property(nonatomic,copy)   NSString        *title;
@property(nonatomic,retain) NSArray         *options;
@property(nonatomic,retain) NSArray         *answers;
@property(nonatomic,retain) NSArray         *flags;
@end
