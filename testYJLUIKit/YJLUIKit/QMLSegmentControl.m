//
//  QMLSegmentControl.m
//  QMLib
//
//  Created by 流云_陌陌 on 14-8-12.
//  Copyright (c) 2014年 流云_陌陌. All rights reserved.
//

#import "QMLSegmentControl.h"
#import "QMLSegItem.h"
#define SPAN_TO_BOUNDS 2

@interface QMLSegmentControl()
{
    float itemWidth;
}
@end
@implementation QMLSegmentControl
- (void)dealloc
{
    DEALLOC_PRINT;
    [_items release];
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    if (self=[super initWithFrame:frame]) {
        self.items=items;
    }
    return self;
}
-(void)setItems:(NSArray *)items
{
    SET_PAR(_items, items);
    [self createView];
}
-(void)createView
{
    if (self.items.count==0) {
        return;
    }
    itemWidth=self.frame.size.width/self.items.count;
    float height=self.frame.size.height;
    
    for (int i=0; i<self.items.count; i++) {
        
        QMLSegItem *item=[self.items objectAtIndex:i];
        if (item.title) {
            UILabel *titleLa=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, itemWidth, 20)];
            titleLa.text=item.title;
            titleLa.backgroundColor=[UIColor clearColor];
            titleLa.textColor=item.defaultTextColor;
            titleLa.tag=20+i;
            titleLa.textAlignment=UITextAlignmentCenter;
            titleLa.font=[UIFont systemFontOfSize:10];
            titleLa.center=CGPointMake(i*itemWidth+itemWidth/2, height/2);
            [self addSubview:titleLa];
            if (item.defaultImage) {
                UIImage *image=item.defaultImage;
                UIImageView *itemImView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
                itemImView.image=image;
                itemImView.tag=10+i;
                itemImView.center=CGPointMake(i*itemWidth+itemWidth/2, SPAN_TO_BOUNDS+image.size.height/4);
                [self addSubview:itemImView];
                
                titleLa.center=CGPointMake(i*itemWidth+itemWidth/2, height-SPAN_TO_BOUNDS-titleLa.frame.size.height/2);
            }
        }else{
            if (item.defaultImage) {
                UIImage *image=item.defaultImage;
                UIImageView *itemImView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
                itemImView.image=image;
                itemImView.tag=10+i;
                itemImView.center=CGPointMake(i*itemWidth+itemWidth/2, SPAN_TO_BOUNDS+image.size.height/4);
                [self addSubview:itemImView];
            }
        }
    }
}
-(void)redrawView
{
    
}
-(void)setSelectIndex:(int)selectIndex
{
    UIImageView *lastIm=(UIImageView *)[self viewWithTag:10+_selectIndex];
    UILabel *lastLa=(UILabel *)[self viewWithTag:20+_selectIndex];
    QMLSegItem *lastItem=[self.items objectAtIndex:_selectIndex];
    lastIm.image=lastItem.defaultImage;
    lastLa.textColor=lastItem.defaultTextColor;
    
    _selectIndex=selectIndex;
    
    UIImageView *im=(UIImageView *)[self viewWithTag:10+_selectIndex];
    UILabel *la=(UILabel *)[self viewWithTag:20+_selectIndex];
    QMLSegItem *item=[self.items objectAtIndex:_selectIndex];
    im.image=item.heightLightImage;
    la.textColor=item.heightLightTextColor;
    
    if (self.valueChanged) {
        self.valueChanged(_selectIndex);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t=[touches anyObject];
    CGPoint p=[t locationInView:self];
    self.selectIndex=p.x/itemWidth;
}
@end
