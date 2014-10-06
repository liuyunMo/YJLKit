//
//  QMLSegmentControl.h
//  QMLib
//
//  Created by 流云_陌陌 on 14-8-12.
//  Copyright (c) 2014年 流云_陌陌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QMLSegItem;
@interface QMLSegmentControl : YJLFlagView
@property(nonatomic,retain)NSArray *items; //QMLSegItem
@property(nonatomic,assign)int selectIndex;
@property(nonatomic,copy)VIBlock valueChanged;
-(id)initWithFrame:(CGRect)frame items:(NSArray *)items;
-(void)redrawView;
@end
