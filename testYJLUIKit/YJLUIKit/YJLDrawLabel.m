//
//  YJLDrawLabel.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-6-16.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLDrawLabel.h"

@implementation YJLDrawLabel
- (void)dealloc
{
    DEALLOC_PRINT;
    [_textObj release];
    [super dealloc];
}
-(void)setupDefineValues
{
    [super setupDefineValues];
    _textObj=[[YJLTextObj alloc] init];
    _textObj.textColor=[UIColor blackColor];
    _textObj.font=[UIFont systemFontOfSize:15];
}
-(float)width
{
    NSString *drawStr=[self getDrawString:[self.textObj text]];
    UIFont   *font=[self.textObj font];
    return [drawStr sizeWithFont:font].width;
}
-(NSString *)getDrawString:(NSString *)string
{
    NSMutableString *str=[NSMutableString stringWithString:string];
    
    [str replaceOccurrencesOfString:@"\r\n" withString:@"\n" options:NSRegularExpressionSearch range:NSMakeRange(0, str.length)];
    [str replaceOccurrencesOfString:@"\n" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, str.length)];
    
    return str;
}
-(void)adjustFrame
{
    CGRect rect=self.frame;
    rect.size.width=self.width;
    self.frame=rect;
}
-(void)redraw
{
    [self adjustFrame];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    NSString *drawStr=[self getDrawString:self.textObj.text];
    UIFont   *font=self.textObj.font;
    UIColor  *color=self.textObj.textColor;
    float height=[drawStr sizeWithFont:font].height;
    float y=(rect.size.height-height)/2;
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(ctx);
    
    CGContextSaveGState(ctx);
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, rect);
    CGContextRestoreGState(ctx);
    
    CGContextSaveGState(ctx);
    [color setFill];
    [drawStr drawInRect:CGRectMake(0, y, self.width, height) withFont:font];
    CGContextRestoreGState(ctx);
    
    UIGraphicsPopContext();
}
@end
