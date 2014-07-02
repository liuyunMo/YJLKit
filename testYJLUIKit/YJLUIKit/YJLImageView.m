//
//  YJLImageView.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLImageView.h"

@implementation YJLImageView
@synthesize flag=_flag;
- (void)dealloc
{
    DEALLOC_PRINT;
    [_flag release];
    [super dealloc];
}
-(void)setupDefineValues
{
    _scale=.5;
}
-(id)initWithImage:(UIImage *)image
{
    if (self=[super initWithImage:image]) {
        [self setupDefineValues];
        [self adjustFrame];
    }
    return self;
}
-(void)setScale:(float)scale{
    _scale=scale>0?scale:0;
    _scale=_scale>1?1:_scale;
    [self adjustFrame];
}
-(void)adjustFrame
{
    if (self.image) {
        CGRect rect = self.frame;
        rect.size.width=self.image.size.width*self.scale;
        rect.size.height = self.image.size.height*self.scale;
        self.frame=rect;
    }
}
#pragma mark -- YJLFlagDelegate Methods
-(NSString *)flag
{
    if (!_flag) {
        return NSStringFromClass([self class]);
    }
    return _flag;
}
#pragma mark -- YJLLayoutDelegate Methods
YJLLAYOUTDELEGATE_IMPLEMENTATION(@"frame,tag,backgroundColor,flag","YJLImageView")
@end
