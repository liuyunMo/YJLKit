//
//  QMLSliderViewController.m
//  testYJLUIKit
//
//  Created by user on 14-10-6.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLSliderViewController.h"
#import "QMLSlider.h"
@interface QMLSliderViewController ()
{
    QMLSlider *slider;
}
@end

@implementation QMLSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    
    slider=[[QMLSlider alloc] initWithFrame:CGRectMake(10, 180, 300, 50)];
    slider.defaultImg=[UIImage imageNamed:@"btn_brightness_default.png"];
    slider.selectImg=[UIImage imageNamed:@"btn_brightness_select.png"];
    [self.view addSubview:slider];
    [slider release];
    
    UILabel *la=[[UILabel alloc] initWithFrame:CGRectMake(0, 130, 320, 20)];
    la.textAlignment=UITextAlignmentCenter;
    la.text=[NSString stringWithFormat:@"%.2f",slider.value];
    [self.view addSubview:la];
    [la release];
    
    slider.valueChanged=^(float value){la.text=[NSString stringWithFormat:@"%.2f",value];};
    
    
    QMLSlider *slider1=[[QMLSlider alloc] initWithFrame:CGRectMake(10, 240, 300, 50)];
    slider1.value=0;
    slider1.defaultImg=[UIImage imageNamed:@"btn_brightness_default.png"];
    slider1.selectImg=[UIImage imageNamed:@"btn_brightness_select.png"];
    [self.view addSubview:slider1];
    [slider1 release];
    
    
    QMLSlider *slider2=[[QMLSlider alloc] initWithFrame:CGRectMake(10, 300, 300, 50)];
    slider2.value=1;
    slider2.defaultImg=[UIImage imageNamed:@"btn_brightness_default.png"];
    slider2.selectImg=[UIImage imageNamed:@"btn_brightness_select.png"];
    [self.view addSubview:slider2];
    [slider2 release];
    
}



@end
