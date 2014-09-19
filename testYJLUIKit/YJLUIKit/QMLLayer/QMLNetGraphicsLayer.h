//
//  QMLNetGraphicsLayer.h
//  testYJLUIKit
//
//  Created by user on 14-9-12.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "QMLShapeLayer.H"
@interface QMLNetGraphicsLayer : QMLShapeLayer
@property(nonatomic,assign)float dataCount;
@property(nonatomic,assign)NSInteger level;
@property(nonatomic,assign)float radius;
@property(nonatomic,readonly)UIBezierPath *bezierPath;
//@property(nonatomic,assign)QMLEdge edge;
@property(nonatomic,assign)float zeroValue;//NSNumber 0-1;

@property(nonatomic,copy)VDBlock pathToKeyPoint;
-(void)draw;
//NSNumber 0-1
-(NSString *)addValues:(NSArray *)data lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor lineWidth:(float)lineWidth keyPoint:(VDBlock)keyPoint;
-(NSString *)addValues:(NSArray *)data lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor lineWidth:(float)lineWidth;
-(NSString *)addLineWithBezierPath:(UIBezierPath *)path lineColor:(UIColor *)lineColor lineWidth:(float)lineWidth animationTime:(NSTimeInterval)time;
@end
