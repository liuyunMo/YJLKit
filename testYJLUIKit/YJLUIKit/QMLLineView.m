//
//  QMLLineView.m
//  testYJLUIKit
//
//  Created by user on 14-9-11.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLLineView.h"
@implementation QMLLineItem
-(void)dealloc
{
    DEALLOC_PRINT;
    [_values release];
    [_lineColor release];
    [super dealloc];
}
-(void)getMinValue:(NSInteger *)minValue maxValue:(NSInteger*)maxValue
{
    NSInteger min=NSIntegerMax,max=NSIntegerMin;
    for(NSNumber *num in self.values)
    {
        NSInteger value=[num integerValue];
        min=min>value?value:min;
        max=max>value?max:value;
    }
    if(minValue)*minValue=min;
    if(maxValue)*maxValue=max;
}
@end
@implementation QMLLineView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    for(int i=0;i<self.lineItems.count;i++)
    {
        QMLLineItem *item=[self.lineItems objectAtIndex:i];
        CGContextSaveGState(ctx);
        CGContextSetStrokeColorWithColor(ctx,item.lineColor.CGColor);
        CGContextSetLineWidth(ctx, item.lineWidth);
        CGContextRestoreGState(ctx);
    }
}

@end
