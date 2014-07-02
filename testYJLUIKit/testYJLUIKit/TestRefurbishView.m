//
//  TestRefurbishView.m
//  testYJLUIKit
//
//  Created by 流云_陌陌 on 14-7-2.
//  Copyright (c) 2014年 钟园园. All rights reserved.
//

#import "TestRefurbishView.h"


@implementation TestRefurbishView
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    YJLRefurbishView *refView=[[YJLRefurbishView alloc] initWithFrame:CGRectMake(10, 80, 300, 300) style:UITableViewStylePlain];
    refView.delegate=self;
    refView.dataSource=self;
    [refView prepareToRefurbish];
    refView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    [self.view addSubview:refView];
    [refView release];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    return cell;
}
@end
