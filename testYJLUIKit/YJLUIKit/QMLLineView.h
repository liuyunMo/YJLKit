//
//  QMLLineView.h
//  testYJLUIKit
//
//  Created by user on 14-9-11.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLFlagView.h"

@interface QMLLineItem:YJLObject
@property(nonatomic,retain)NSArray *values;//NSNumber
@property(nonatomic,retain)UIColor *lineColor;
@property(nonatomic,assign)float lineWidth;
-(void)getMinValue:(NSInteger *)minValue maxValue:(NSInteger*)maxValue;
@end
@interface QMLLineView : YJLFlagView
@property(nonatomic,retain)NSArray *lineItems;// QMLLineItem
@property(nonatomic,assign)QMLEdge edge;
@end
          