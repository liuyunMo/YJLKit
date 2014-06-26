//
//  AppDelegate.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.rootViewController=[[ViewController alloc] init];
    window.backgroundColor=[UIColor whiteColor];
    [window makeKeyAndVisible];
    return YES;
}
							

@end
