//
//  YJLView.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLView.h"

@implementation YJLView
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupDefineValues];
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        [self setupDefineValues];
    }
    return self;
}
-(void)setupDefineValues
{
    
}
- (void)dealloc
{
    DEALLOC_PRINT;
    [super dealloc];
}
#pragma mark -- YJLLayoutDelegate Methods
YJLLAYOUTDELEGATE_IMPLEMENTATION(@"frame,tag,backgroundColor","YJLView")
@end
