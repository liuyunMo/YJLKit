//
//  ViewController.m
//  testYJLUIKit
//
//  Created by 钟园园 on 14-5-30.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "ViewController.h"
#import "YJLContentView.h"
#define KEY_TITLE @"title"
#define KEY_CLASS @"class"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataToShow;
}
@end

@implementation ViewController
- (void)dealloc
{
    DEALLOC_PRINT;
    [dataToShow release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"YJLKit";
    dataToShow=@[
                 @{KEY_TITLE:@"YJLSelectView",
                   KEY_CLASS:@"TestSelectViewViewController"},
                 @{KEY_TITLE:@"YJLProgressView",
                   KEY_CLASS:@"TestProgressViewViewController"},
                 
                 ];
    [dataToShow retain];
    UITableView *tab=[[UITableView alloc] initWithFrame:self.view.bounds];
    tab.delegate=self;
    tab.dataSource=self;
    [self.view addSubview:tab];
    [tab release];
}
#pragma mark-- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataToShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dict=[dataToShow objectAtIndex:indexPath.row];
    cell.textLabel.text=[dict objectForKey:KEY_TITLE];
    return cell;
}
#pragma mark-- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    NSDictionary *dict=[dataToShow objectAtIndex:indexPath.row];
    Class c=NSClassFromString([dict objectForKey:KEY_CLASS]);
    UIViewController *vc=[[c alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        vc.title=[dict objectForKey:KEY_TITLE];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [vc release];
}
@end
