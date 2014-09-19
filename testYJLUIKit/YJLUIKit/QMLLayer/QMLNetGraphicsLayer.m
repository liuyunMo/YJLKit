//
//  QMLNetGraphicsLayer.m
//  testYJLUIKit
//
//  Created by user on 14-9-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLNetGraphicsLayer.h"
@interface QMLNetGraphicsLayer()
{
    
}
@end
@implementation QMLNetGraphicsLayer
- (void)dealloc
{
    DEALLOC_PRINT;
    [_bezierPath release];
    [super dealloc];
}
-(void)draw
{
    CGRect rect=self.bounds;
    int dataCount=self.dataCount;
    float pan_angle=M_PI*2/dataCount;
    UIBezierPath *path=[UIBezierPath bezierPath];
    //[path addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:0];
    
    for (int i=0; i<dataCount; i++) {
        [path moveToPoint:CGPointMake(rect.size.width/2, rect.size.height/2)];
        float angle=i*pan_angle;
        
        float x=rect.size.width/2+self.radius*sinf(angle);
        float y=rect.size.height/2-self.radius*cosf(angle);
        [path addLineToPoint:CGPointMake(x, y)];
    }
    
    
    float span_level=self.radius/_level;
    
    for (int i=1; i<_level+1; i++)
    {
        float subRadiu=span_level*i;
        for (int j=0; j<dataCount+1; j++) {
            float angle=j*pan_angle;
            float x=rect.size.width/2+subRadiu*sinf(angle);
            float y=rect.size.height/2-subRadiu*cosf(angle);
            if (j==0) {
                [path moveToPoint:CGPointMake(x, y)];
                
            }else if(j==dataCount){
                [path addLineToPoint:CGPointMake(rect.size.width/2+subRadiu*sinf(0), rect.size.height/2-subRadiu*cosf(0))];
            }else{
                [path addLineToPoint:CGPointMake(x, y)];
            }
            if (i==1&&j!=dataCount){
                [self pathToKeyPointWithDict:@{
                                               @"point":[NSValue valueWithCGPoint:CGPointMake(x, y)],
                                               @"index":@(j),
                                               }];
            }
        }
    }
    [self drawWithPath:path];
}
-(void)pathToKeyPointWithDict:(NSDictionary *)dict
{
    if (self.pathToKeyPoint) {
        self.pathToKeyPoint(dict);
    }
}
-(NSString *)addValues:(NSArray *)data lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor lineWidth:(float)lineWidth
{
    return [self addValues:data lineColor:lineColor fillColor:fillColor lineWidth:lineWidth keyPoint:NULL];
}
-(NSString *)addValues:(NSArray *)data lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor lineWidth:(float)lineWidth keyPoint:(VDBlock)keyPoint
{
    if (data.count!=self.dataCount) {
        return nil;
    }
    CGRect rect=self.bounds;
    int dataCount=self.dataCount;
    float pan_angle=M_PI*2/dataCount;
    UIBezierPath *conPath=[UIBezierPath bezierPath];
    float f_x=0,f_y=0;
    for (int i=0; i<dataCount; i++)
    {
        float value=[[data objectAtIndex:i] floatValue];
        float subRadiu=value*(self.radius*(1-self.zeroValue))+self.radius*self.zeroValue;
        float angle=i*pan_angle;
        float subAngle=i*pan_angle+pan_angle/2;
        float x=rect.size.width/2+subRadiu*sinf(angle);
        float y=rect.size.height/2-subRadiu*cosf(angle);
        if (i==0) {
            f_x=x;
            f_y=y;
            [conPath moveToPoint:CGPointMake(x, y)];
        }else if(i==dataCount-1){
            [conPath addLineToPoint:CGPointMake(f_x, f_y)];
        }else{
            [conPath addLineToPoint:CGPointMake(x, y)];
        }
        
        if (keyPoint) {
            keyPoint(@{
                       @"point":[NSValue valueWithCGPoint:CGPointMake(x, y)],
                       @"index":@(i*2),
                       });
            float s_x=rect.size.width/2+subRadiu*sinf(subAngle);
            float s_y=rect.size.height/2-subRadiu*cosf(subAngle);
            keyPoint(@{
                       @"point":[NSValue valueWithCGPoint:CGPointMake(s_x, s_y)],
                       @"index":@(i*2+1),
                       });
        }
    }
    QMLShapeLayer *contentLayer=[QMLShapeLayer layer];
    contentLayer.path=[conPath CGPath];
    contentLayer.frame=self.bounds;
    contentLayer.lineWidth=lineWidth;
    contentLayer.fillColor=fillColor.CGColor;
    contentLayer.strokeColor=lineColor.CGColor;
    [self addSublayer:contentLayer];
    contentLayer.flag=[NSString stringWithFormat:@"QMLShapeLayer_dataLayer_%d",[self.sublayers indexOfObject:contentLayer]];
    return contentLayer.flag;
}
-(NSString *)addLineWithBezierPath:(UIBezierPath *)path lineColor:(UIColor *)lineColor lineWidth:(float)lineWidth animationTime:(NSTimeInterval)time
{
    float dash,pahse;int count;
    [path getLineDash:&dash count:&count phase:&pahse];
    NSMutableArray *dashArr=[NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; i++) {
        [dashArr addObject:@(dash++)];
    }
    QMLShapeLayer *contentLayer=[QMLShapeLayer layer];
    contentLayer.lineDashPattern=dashArr;
    contentLayer.lineDashPhase=pahse;
    contentLayer.path=[path CGPath];
    contentLayer.frame=self.bounds;
    contentLayer.lineWidth=lineWidth;
    contentLayer.strokeColor=lineColor.CGColor;
    [self addSublayer:contentLayer];
    contentLayer.flag=[NSString stringWithFormat:@"QMLShapeLayer_lineLayer_%d",[self.sublayers indexOfObject:contentLayer]];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.delegate = self;
    animation.duration = time;
    [contentLayer addAnimation:animation forKey:@"lineAnimation"];
    return contentLayer.flag;
}
-(void)drawWithPath:(UIBezierPath *)path
{
    self.lineWidth=1;
    self.strokeColor=[UIColor lightGrayColor].CGColor;
    self.path=path.CGPath;
    self.fillColor=[UIColor clearColor].CGColor;
    self.strokeStart=0;
}
@end
