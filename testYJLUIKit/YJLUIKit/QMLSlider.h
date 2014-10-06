//
//  QMLSlider.h
//  testYJLUIKit
//
//  Created by user on 14-10-6.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLImageView.h"

@interface QMLSlider : YJLFlagView
@property(nonatomic,assign)float value;//0-1;
@property(nonatomic,assign)float scale;
@property(nonatomic,copy)VFBlock valueChanged;

@property(nonatomic,retain)UIImage *defaultImg;
@property(nonatomic,retain)UIImage *selectImg;
@end
