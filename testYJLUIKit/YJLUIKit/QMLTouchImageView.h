//
//  QMLTouchImageView.h
//  testYJLUIKit
//
//  Created by user on 14-10-6.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLImageView.h"

@interface QMLTouchImageView : YJLImageView
@property(nonatomic,copy)VSBlock beganHandle;
@property(nonatomic,copy)VSBlock movedHandle;
@property(nonatomic,copy)VSBlock endedHandle;
@property(nonatomic,copy)VSBlock cancelledHandle;

@property(nonatomic,assign)BOOL nextRes;
@end
