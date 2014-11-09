//
//  QMLSlider.m
//  testYJLUIKit
//
//  Created by user on 14-10-6.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLSlider.h"
#import "QMLTouchImageView.h"

@interface QMLSlider()
{
    QMLTouchImageView *valueIm;
    YJLProgreeView *valueView;
    
    BOOL touched;
}
@end

@implementation QMLSlider
- (void)dealloc
{
    DEALLOC_PRINT;
    Block_release(_valueChanged);
    [_defaultImg release];
    [_selectImg release];
    [super dealloc];
}
-(void)setupDefineValues
{
    [super setupDefineValues];
    _scale=20;
    _value=.5;
}
-(void)proValueChanged
{
    _value=valueView.progress;
    
    float proLen=valueView.frame.size.width;
    float proBegin=valueView.frame.origin.x;
    valueIm.center=CGPointMake(_value*proLen+proBegin, valueIm.center.y);
    if (self.valueChanged) {
        self.valueChanged(_value);
    }
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
-(void)createView
{
    __block typeof(self)bSelf=self;
    if (!valueView) {
        valueView=[[YJLProgreeView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/_scale)];
        valueView.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        valueView.borderType=YJLProgressViewBorderTypePlain;
        valueView.type=YJLProgressViewDefault;
        valueView.progress=self.value;
        valueView.flag=@"QMLSlider_YJLProgreeView_valueView";
        valueView.backgroundColor=[UIColor clearColor];
        valueView.progressChanged=^{[bSelf proValueChanged];};
        [self addSubview:valueView];
        [valueView release];
    }
    if (!valueIm) {
        valueIm=[[QMLTouchImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        valueIm.nextRes=YES;
        valueIm.flag=@"QMLSlider_QMLTouchImageView_valueIm";
        valueIm.beganHandle=^(NSSet*set){[bSelf enableTouch];};
        valueIm.endedHandle=^(NSSet*set){[bSelf disEnableTouch];};
        valueIm.cancelledHandle=^(NSSet*set){[bSelf disEnableTouch];};
        valueIm.backgroundColor=[UIColor clearColor];
        valueIm.clipsToBounds=YES;
        [self addSubview:valueIm];
        [valueIm release];
    }
    [self adjustView];
    [self proValueChanged];
}
-(void)enableTouch
{
    touched=YES;
    valueIm.image=self.selectImg;
}
-(void)disEnableTouch
{
    touched=NO;
    valueIm.image=self.defaultImg;
}
-(void)setDefaultImg:(UIImage *)defaultImg
{
    [defaultImg retain];
    [_defaultImg release];
    _defaultImg=defaultImg;
    valueIm.image=_defaultImg;
}
-(void)adjustView
{
    CGRect vvRect=valueView.frame;
    vvRect.origin.x=valueIm.frame.size.width/2;
    vvRect.size.width=self.frame.size.width-2*vvRect.origin.x;
    valueView.frame=vvRect;
}
-(void)setValue:(float)value
{
    valueView.progress=value;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touched) {
        UITouch *touch=[touches anyObject];
        CGPoint p=[touch locationInView:self];
        float proLen=valueView.frame.size.width;
        float proBegin=valueView.frame.origin.x;
        self.value=(p.x-proBegin)/proLen;
    }
}
@end
