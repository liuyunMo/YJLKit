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
-(id)init
{
    if (self=[super init]) {
        [self setupDefineValues];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupDefineValues];
    }
    return self;
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

-(NSString *)flag
{
    if (!_flag) {
        return NSStringFromClass([self class]);
    }
    return _flag;
}
#pragma mark -- YJLLayoutDelegate Methods
+(id)createWithInfoDict:(NSDictionary*)infoDict
{
    YJLImageView *im=[[[self class] alloc]init];
    NSString *frame=[infoDict objectForKey:@"frame"];
    if (frame) {
        CGRect rect;
        getFrameWithLayoutStr(frame, &rect);
        im.frame=rect;
    }
    NSString *backgroundColor=[infoDict objectForKey:@"backgroundColor"];
    if (backgroundColor) {
        UIColor *color=nil;
        getColorWithLayoutStr(backgroundColor, &color);
        im.backgroundColor=color;
    }
    
    NSString *flag=[infoDict objectForKey:@"flag"];
    if (flag) {
        im.flag=flag;
    }
    
    NSString *tag=[infoDict objectForKey:@"tag"];
    if (tag) {
        im.tag=[tag intValue];
    }
    
    NSString *image=[infoDict objectForKey:@"image"];
    if (image) {
        UIImage *img=nil;
        getImageWithName(image, &img);
        im.image=img;
    }
    
    NSString *scale=[infoDict objectForKey:@"scale"];
    if (scale) {
        im.scale=[scale floatValue];
    }
    
    return [im autorelease];
}
@end
