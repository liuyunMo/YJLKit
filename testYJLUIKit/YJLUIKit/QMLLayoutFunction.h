//
//  QMLLayoutFunction.h
//  testYJLUIKit
//
//  Created by user on 14/10/22.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#ifndef testYJLUIKit_QMLLayoutFunction_h
#define testYJLUIKit_QMLLayoutFunction_h

#define PATH_CACHES      [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
#define PATH_DOCUMENTS   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define PATH_LAYOUT_IMG  [PATH_CACHES stringByAppendingPathComponent:@"Layout_Img"]
#define PATH_LAYOUT      [PATH_CACHES stringByAppendingPathComponent:@"Layout"]


#define LAYOUT_FILE_SUFFIX    @"qml"
#define LAYOUY_HAS_ASS_PREFIX @"CF"

#define LAYOUT_FLAG_TOTAL_HEIGHT @"H"
#define LAYOUT_FLAG_TOTAL_WIDTH  @"W"

#define LAYOUT_ITEM_SEP        @","
#define LAYOUT_ROW_SEP         @";"
#define LAYOUT_KEY_VALUE_SEP   @"="

#define LAYOUT_KEY_CLASS       @"class"

@protocol YJLLayoutDelegate;

BOOL createLayoutFolder();

NSString *getStringByDelWhiteSpaceAndNewLine(NSString *str);

void getScreenSize(float *w,float *h);
void getFrameWithLayoutStr(NSString *str,CGRect *rect);
void getColorWithLatoutStr(NSString *str,UIColor **color);
void getImageWithName(NSString *name,UIImage **img);
UIImage *imageWithName(NSString *name);

void getInstancesWithLayoutStr(NSString *str,NSDictionary **dict);
void* getSingleInstanceWithLayoutStr(NSString *str,Class *mainClass);
void getLayoutStrWithLayoutFile(NSString *name,NSString **str);
void* getInstanceWithLayoutFile(NSString *name,BOOL hasAsso);

#endif