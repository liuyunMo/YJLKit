//
//  YJLUIKit.m
//  YJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "YJLUIKit.h"
static BOOL shouldLogDealloc=NO;

void enableDeallocLog(BOOL enable)
{
    shouldLogDealloc=enable;
}
BOOL logEnable()
{
    return shouldLogDealloc;
}
BOOL isIOS7()
{
    UIDevice *device=[UIDevice currentDevice];
    return [device.systemVersion floatValue]>=7.0f;
}

@implementation YJLUIKit
+(NSString *)version
{
    return @"v 1.0";
}
+(CGFloat)getTextViewContentHeight:(UITextView *)textView
{
    if (isIOS7()) {
        CGRect frame = textView.bounds;
        
        // Take account of the padding added around the text.
        UIEdgeInsets textContainerInsets = textView.textContainerInset;
        UIEdgeInsets contentInsets = textView.contentInset;
        
        CGFloat leftRightPadding = textContainerInsets.left + textContainerInsets.right + textView.textContainer.lineFragmentPadding * 2 + contentInsets.left + contentInsets.right;
        CGFloat topBottomPadding = textContainerInsets.top + textContainerInsets.bottom + contentInsets.top + contentInsets.bottom;
        
        frame.size.width -= leftRightPadding;
        frame.size.height -= topBottomPadding;
        
        NSString *textToMeasure = textView.text;
        if ([textToMeasure hasSuffix:@"\n"])
        {
            textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
        }
        
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName: textView.font, NSParagraphStyleAttributeName : paragraphStyle };
        
        CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        CGFloat measuredHeight = ceilf(CGRectGetHeight(size) + topBottomPadding);
        return measuredHeight;
    }else{
        return textView.contentSize.height;
    }
}
@end