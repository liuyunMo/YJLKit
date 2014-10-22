//
//  YJLProgreeView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-6-26.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLProgreeView.h"

@implementation YJLProgreeView
- (void)dealloc
{
    DEALLOC_PRINT;
    Block_release(_progressChanged);
    [_defaultColor release];
    [_progressColor release];
    [super dealloc];
}
-(void)setupDefineValues
{
    _type=YJLProgressViewRound;
    _borderType=YJLProgressViewBorderTypeRound;
    _progressWidth=10;
    UIColor *d_color=COLOR_WITH_RGB(153, 153, 153);
    UIColor *color=[UIColor whiteColor];
    SET_PAR(_defaultColor, d_color);
    SET_PAR(_progressColor, color);
}
-(void)setProgress:(float)progress
{
    _progress=progress<0?0:(progress>1?1:progress);
    if (_progressChanged) {
        _progressChanged();
    }
    [self setNeedsDisplay];
}
-(void)drawLoopProgress:(CGContextRef)ctx rect:(CGRect)rect
{
    float width=rect.size.width;
    float height=rect.size.height;
    float radius=width>height?(height/2):(width/2);
    CGContextSaveGState(ctx);
    CGContextAddEllipseInRect(ctx, CGRectMake(_progressWidth, _progressWidth, radius*2-2*_progressWidth, radius*2-2*_progressWidth));
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, radius*2, radius*2));
    CGContextSetFillColorWithColor(ctx, self.defaultColor.CGColor);
    CGContextDrawPath(ctx, kCGPathEOFill);
    CGContextRestoreGState(ctx);
    
    
    
    float angle=self.progress*2*M_PI;
    float m_radius=radius-self.progressWidth/2;
    float x=radius+m_radius*cos(angle);
    float y=radius+m_radius*sin(angle);
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, self.progressColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, self.progressColor.CGColor);
    CGContextMoveToPoint(ctx, 2*radius-self.progressWidth, radius);
    CGContextAddArc(ctx, radius, radius, radius-self.progressWidth, 0, angle, 0);
    switch (self.borderType)
    {
        case YJLProgressViewBorderTypeRound:
            CGContextAddArc(ctx, x, y, self.progressWidth/2, angle, angle+M_PI, 0);
            CGContextAddArc(ctx, radius, radius, radius, angle,0 , 1);
            CGContextAddArc(ctx, 2*radius-self.progressWidth/2, radius, self.progressWidth/2, 2*M_PI, M_PI, 0);
            break;
        case YJLProgressViewBorderTypePlain:
            CGContextAddLineToPoint(ctx, radius+2*radius*cos(angle), radius+2*radius*sin(angle));
            CGContextAddArc(ctx, radius, radius, radius, angle,0 , 1);
            CGContextAddLineToPoint(ctx, 2*radius-self.progressWidth, radius);
            break;
    }
    
    CGContextDrawPath(ctx, kCGPathEOFill);
    CGContextRestoreGState(ctx);
}
-(void)drawDefaultProgress:(CGContextRef)ctx rect:(CGRect)rect
{
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, self.defaultColor.CGColor);
    CGContextFillRect(ctx, rect);
    CGContextRestoreGState(ctx);
    
    float pro=self.progress*rect.size.width;
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, self.progressColor.CGColor);
    CGContextMoveToPoint(ctx, 0, 0);
    switch (self.borderType) {
        case YJLProgressViewBorderTypeRound:
        {
            float radius=rect.size.height/2;
            CGContextAddLineToPoint(ctx, pro-radius,0);
            CGContextAddArc(ctx, pro-radius, radius, radius, -M_PI/2, M_PI/2, 0);
        }
            break;
        case YJLProgressViewBorderTypePlain:
            CGContextAddLineToPoint(ctx, pro, 0);
            CGContextAddLineToPoint(ctx, pro, rect.size.height);
            break;
    }
    CGContextAddLineToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, 0, 0);
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
}
-(void)drawPieProgress:(CGContextRef)ctx rect:(CGRect)rect
{
    float width=rect.size.width;
    float height=rect.size.height;
    float radius=width>height?(height/2):(width/2);
    CGContextSaveGState(ctx);
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, radius*2, radius*2));
    CGContextSetFillColorWithColor(ctx, self.defaultColor.CGColor);
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
    
    float endAngle=self.progress*2*M_PI-M_PI/2;
    CGContextSaveGState(ctx);
    CGContextMoveToPoint(ctx, radius, radius);
    CGContextAddLineToPoint(ctx, radius, 0);
    CGContextAddArc(ctx, radius, radius, radius, -M_PI/2, endAngle, 0);
    CGContextAddLineToPoint(ctx, radius, radius);
    CGContextSetFillColorWithColor(ctx, self.progressColor.CGColor);
    CGContextFillPath(ctx);
    CGContextRestoreGState(ctx);
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    switch (self.type) {
        case YJLProgressViewDefault:
            [self drawDefaultProgress:ctx rect:rect];
            break;
        case YJLProgressViewRound:
            [self drawLoopProgress:ctx rect:rect];
            break;
        case YJLProgressViewPie:
            [self drawPieProgress:ctx rect:rect];
            break;
    }
    UIGraphicsPopContext();
}


#pragma mark--   YJLCreateDelegate
+(id)createWithInfoDict:(NSDictionary*)infoDict
{
    YJLProgreeView *vi=[super createWithInfoDict:infoDict];
    NSString *type=[infoDict objectForKey:@"type"];
    if (type) {
        vi.type=[type intValue];
    }
    
    NSString *borderType=[infoDict objectForKey:@"borderType"];
    if (borderType) {
        vi.borderType=[borderType intValue];
    }
    
    NSString *defaultColor=[infoDict objectForKey:@"defaultColor"];
    if (defaultColor) {
        UIColor *color=nil;
        getColorWithLatoutStr(defaultColor, &color);
        vi.defaultColor=color;
    }
    
    NSString *progressColor=[infoDict objectForKey:@"progressColor"];
    if (progressColor) {
        UIColor *color=nil;
        getColorWithLatoutStr(progressColor, &color);
        vi.progressColor=color;
    }
    
    NSString *progress=[infoDict objectForKey:@"progress"];
    if (progress) {
        vi.progress=[progress floatValue];
    }
    
    NSString *progressWidth=[infoDict objectForKey:@"progressWidth"];
    if (progressWidth) {
        vi.progressWidth=[progressWidth floatValue];
    }
    
    return vi;
}
@end
