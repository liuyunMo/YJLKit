//
//  QMLStatusImageView.m
//  testYJLUIKit
//
//  Created by user on 14-10-5.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLStatusImageView.h"

@implementation QMLStatusImageView
-(id)initWithImage:(UIImage *)image
{
    if (self=[super initWithImage:image]) {
        self.defaultImg=image;
    }
    return self;
}
-(void)setupDefineValues
{
    [super setupDefineValues];
}
@end
