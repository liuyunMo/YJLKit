//
//  QMLLayoutFunction.m
//  testYJLUIKit
//
//  Created by user on 14/10/22.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "QMLLayoutFunction.h"
void getLayoutStrWithLayoutFile(NSString *name,NSString **str);


NSString *getStringByDelWhiteSpaceAndNewLine(NSString *str)
{
    if (![str isKindOfClass:[NSString class]]) return nil;
    NSMutableString *muStr=[str mutableCopy];
    [muStr replaceOccurrencesOfString:@"\r\n" withString:@"\n" options:NSRegularExpressionSearch range:NSMakeRange(0, muStr.length)];
    [muStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, muStr.length)];
    [muStr replaceOccurrencesOfString:@" " withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, muStr.length)];
    return muStr;
}

void getScreenSize(float *w,float *h)
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    if (w) *w=size.width;
    if (h) *h=size.height;
}
void getFrameWithLayoutStr(NSString *str,CGRect *rect)
{
    NSString *f_str=getStringByDelWhiteSpaceAndNewLine(str);
    if (f_str) {
        float t_w=0,t_h=0;
        getScreenSize(&t_w, &t_h);
        NSArray *arr=[f_str componentsSeparatedByString:LAYOUT_ITEM_SEP];
        if (arr.count==4) {
            float value[4];
            for (int i=0; i<arr.count; i++) {
                NSString *subStr=[arr objectAtIndex:i];
                if ([subStr hasPrefix:LAYOUT_FLAG_TOTAL_HEIGHT]) {
                    NSString *v_str=[subStr substringFromIndex:1];
                    value[i]+= t_h+[v_str floatValue];
                }else if ([subStr hasPrefix:LAYOUT_FLAG_TOTAL_WIDTH]) {
                    NSString *v_str=[subStr substringFromIndex:1];
                    value[i]+= t_w+[v_str floatValue];
                }else{
                    value[i]=[subStr floatValue];
                }
            }
            if (rect) {
                rect->origin.x=value[0];
                rect->origin.y=value[1];
                rect->size.width=value[2];
                rect->size.height=value[3];
            }
            
        }
        
    }
    
}
void getColorWithLatoutStr(NSString *str,UIColor **color)
{
    NSString *c_str=getStringByDelWhiteSpaceAndNewLine(str);
    float value[4]={255.0,255.0,255.0,255.0};
    NSArray *arr=[c_str componentsSeparatedByString:LAYOUT_ITEM_SEP];
    for (int i=0; i<arr.count; i++) {
        NSString *subStr=[arr objectAtIndex:i];
        value[i]=[subStr floatValue];
    }
    if (color) {
        *color=COLOR_WITH_RGBA(value[0], value[1], value[2], value[3]);
    }
}
void getImageWithName(NSString *name,UIImage **img)
{
    if (img) {
        NSFileManager *manager=[NSFileManager defaultManager];
        NSString *pngFullName=[name stringByAppendingPathExtension:@"png"];
        NSString *jpgFullName=[name stringByAppendingPathExtension:@"jpg"];
        int count=0;
        const char*pathArr[4]={
                           [[PATH_LAYOUT_IMG stringByAppendingPathComponent:pngFullName] UTF8String],
                           [[PATH_LAYOUT_IMG stringByAppendingPathComponent:jpgFullName] UTF8String],
                           [[[NSBundle mainBundle] pathForResource:name ofType:@"png"] UTF8String],
                           [[[NSBundle mainBundle] pathForResource:name ofType:@"jpg"] UTF8String]
                          };
    findImg:
        {
            NSString *path=[NSString stringWithUTF8String:pathArr[count]];
            if ([manager fileExistsAtPath:path]) {
                *img = [UIImage imageWithContentsOfFile:path];
            }
            if (!*img&&count<4) {
                count++;
                goto findImg;
            }
        }
        
    }
}
UIImage *imageWithName(NSString *name)
{
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *pngFullName=[name stringByAppendingPathExtension:@"png"];
    NSString *jpgFullName=[name stringByAppendingPathExtension:@"jpg"];
    int count=0;
    const char*pathArr[4]={
        [[PATH_LAYOUT_IMG stringByAppendingPathComponent:pngFullName] UTF8String],
        [[PATH_LAYOUT_IMG stringByAppendingPathComponent:jpgFullName] UTF8String],
        [[[NSBundle mainBundle] pathForResource:name ofType:@"png"] UTF8String],
        [[[NSBundle mainBundle] pathForResource:name ofType:@"jpg"] UTF8String]
    };
findImg:
    {
        NSString *path=[NSString stringWithUTF8String:pathArr[count]];
        UIImage *img=nil;
        if ([manager fileExistsAtPath:path]) {
            img = [UIImage imageWithContentsOfFile:path];
        }
        if (!img&&count<4) {
            count++;
            goto findImg;
        }else{
            return img;
        }
    
    }
}
//hasAsso 是否存在关联
void getSingleInstanceWithLayoutStr(NSString *str,id<YJLLayoutDelegate> *instance,BOOL *hasAsso)
{
    if (str&&instance) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        NSArray *arr=[str componentsSeparatedByString:LAYOUT_ROW_SEP];
        for (NSString *subStr in arr) {
            NSArray *subArr=[subStr componentsSeparatedByString:LAYOUT_KEY_VALUE_SEP];
            if (subArr.count>1) {
                NSString *key=getStringByDelWhiteSpaceAndNewLine([subArr objectAtIndex:0]);
                NSString *value=getStringByDelWhiteSpaceAndNewLine([subArr objectAtIndex:1]);
                if (hasAsso&&!*hasAsso) {
                    *hasAsso=[value hasPrefix:LAYOUY_HAS_ASS_PREFIX];
                }
                if (key&&value) {
                    [dict setObject:value forKey:key];
                }
            }
        }
        NSString *c_str=[dict objectForKey:LAYOUT_KEY_CLASS];
        if (c_str) {
            *instance=[NSClassFromString(c_str) createWithInfoDict:dict];
        }
    }
}
void getInstancesWithLayoutStr(NSString *str,NSDictionary **dict)
{
    if (!dict||!str) {
        return;
    }
    NSString *c_str=getStringByDelWhiteSpaceAndNewLine(str);
    
    NSArray *arr=[c_str componentsSeparatedByString:LAYOUT_KEY_CLASS];
    
    NSMutableDictionary *mudict=[NSMutableDictionary dictionary];
    for (NSString *subStr in arr) {
        subStr = getStringByDelWhiteSpaceAndNewLine([LAYOUT_KEY_CLASS stringByAppendingString:subStr]);
        id <YJLLayoutDelegate> ins=nil;
        BOOL hasAss=NO;
        getSingleInstanceWithLayoutStr(subStr, &ins,&hasAss);
        if (ins&&ins.flag) {
            [mudict setObject:ins forKey:ins.flag];
        }
        if (dict) {
            *dict=mudict;
        }
    }
}
void* getInstanceWithLayoutStr(NSString *str,BOOL hasAsso)
{
    if (!str) {
        return nil;
    }
    NSString *c_str=getStringByDelWhiteSpaceAndNewLine(str);
    
    NSArray *arr=[c_str componentsSeparatedByString:LAYOUT_KEY_CLASS];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    for (NSString *subStr in arr) {
        if (getStringByDelWhiteSpaceAndNewLine(subStr).length<1) {
            continue;
        }
        subStr = getStringByDelWhiteSpaceAndNewLine([LAYOUT_KEY_CLASS stringByAppendingString:subStr]);
        id <YJLLayoutDelegate> ins=nil;
        getSingleInstanceWithLayoutStr(subStr, &ins,nil);
        if (ins&&ins.flag) {
            if (hasAsso) {
                [dict setObject:ins forKey:ins.flag];
            }else{
                return ins;
            }
        }
    }
    return dict;
}

void* getInstanceWithLayoutFile(NSString *name,BOOL hasAsso)
{
    NSString *layoutStr=nil;
    getLayoutStrWithLayoutFile(name, &layoutStr);
    if (layoutStr) {
        return  getInstanceWithLayoutStr(layoutStr,hasAsso);
    }
    return nil;
}
void getLayoutStrWithLayoutFile(NSString *name,NSString **str)
{
    if(str)
    {
        NSFileManager *manager=[NSFileManager defaultManager];
        NSString *path=[PATH_LAYOUT stringByAppendingPathComponent:[name stringByAppendingPathExtension:LAYOUT_FILE_SUFFIX]];
        if ([manager fileExistsAtPath:path]) {
            *str=getStringByDelWhiteSpaceAndNewLine([NSString stringWithContentsOfFile:path encoding:4 error:nil]);
        }
        if (!*str) {
            path=[[NSBundle mainBundle] pathForResource:name ofType:LAYOUT_FILE_SUFFIX];
            if ([manager fileExistsAtPath:path]) {
                *str=getStringByDelWhiteSpaceAndNewLine([NSString stringWithContentsOfFile:path encoding:4 error:nil]);
            }
        }
    }
}


BOOL createLayoutFolder()
{
    NSFileManager *manager=[NSFileManager defaultManager];
    if (![manager fileExistsAtPath:PATH_LAYOUT]) {
        if (![manager createDirectoryAtPath:PATH_LAYOUT withIntermediateDirectories:NO attributes:nil error:nil]) {
            return NO;
        };
    }
    if (![manager fileExistsAtPath:PATH_LAYOUT_IMG]) {
        if (![manager createDirectoryAtPath:PATH_LAYOUT_IMG withIntermediateDirectories:NO attributes:nil error:nil]) {
            return NO;
        };
    }
    return YES;
}