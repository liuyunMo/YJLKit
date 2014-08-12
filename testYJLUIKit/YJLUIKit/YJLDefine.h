//
//  YJLDefine.h
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#ifndef testYJLUIKit_YJLDefine_h
#define testYJLUIKit_YJLDefine_h


typedef enum : NSUInteger {
    kYJLDirectionUp=0,
    kYJLDirectionDown,
    kYJLDirectionLeft,
    kYJLDirectionRight
} YJLDirection;

void enableDeallocLog(BOOL);
BOOL logEnable();
BOOL isIOS7();

typedef void(^VVBlock)(void);
typedef void(^VTBlock)(int index);

//颜色
#define SAFE_COLOR(x)   ((x)>0.0f?((x)>255.0f?255.0f:(x)):0.0f)

#define COLOR_WITH_RGB(r,g,b) [UIColor colorWithRed:SAFE_COLOR(r)/255.0 \
                                              green:SAFE_COLOR(g)/255.0 \
                                               blue:SAFE_COLOR(b)/255.0 \
                                              alpha:1]

#define COLOR_WITH_RGBA(r,g,b,a) [UIColor colorWithRed:SAFE_COLOR(r)/255.0 \
                                                 green:SAFE_COLOR(g)/255.0 \
                                                  blue:SAFE_COLOR(b)/255.0 \
                                                 alpha:SAFE_COLOR(a)/255.0]

#define RAND_COLOR COLOR_WITH_RGB(arc4random()%255, arc4random()%255, arc4random()%255)



#define DEALLOC_PRINT if(logEnable())printf(("\n%s"), __PRETTY_FUNCTION__)

#define SET_PAR(_p,p) do{[p retain];[_p release];_p=p;}while(0)

#endif
