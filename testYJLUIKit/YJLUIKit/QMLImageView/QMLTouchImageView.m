//
//  QMLTouchImageView.m
//  testYJLUIKit
//
//  Created by user on 14-10-6.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLTouchImageView.h"

@implementation QMLTouchImageView
-(void)setupDefineValues
{
    [super setupDefineValues];
    self.userInteractionEnabled=YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.beganHandle) {
        self.beganHandle(touches);
    }
    if (self.nextRes) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.endedHandle) {
        self.endedHandle(touches);
    }
    if (self.nextRes) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.movedHandle) {
        self.movedHandle(touches);
    }
    if (self.nextRes) {
        [self.nextResponder touchesMoved:touches withEvent:event];
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.cancelledHandle) {
        self.cancelledHandle(touches);
    }
    if (self.nextRes) {
        [self.nextResponder touchesCancelled:touches withEvent:event];
    }
}
- (void)dealloc
{
    DEALLOC_PRINT;
    Block_release(_beganHandle);
    Block_release(_movedHandle);
    Block_release(_endedHandle);
    Block_release(_cancelledHandle);
    [super dealloc];
}
@end
