//
//  WYTestTableView.m
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WYTestTableView.h"

#import "Macros.h"

@implementation WYTestTableView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, viewHeight-44)];
        bgView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:bgView];
        
        contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, frame.size.height)];
        contentTableView.delegate = self;
        contentTableView.dataSource = self;
        contentTableView.backgroundColor = [UIColor clearColor];
        contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [bgView addSubview:contentTableView];
    }
    return self;
    
}

- (void)loadRefreshData:(NSArray *)data
{
    NSLog(@"data  %@",data);
    dataArray = data;
    contentStr = data[0];
    [contentTableView reloadData];
}


#pragma mark - UITableView
- (UIView *)creatWhiteView
{
    if (whiteView == nil) {
        whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
        whiteView.backgroundColor = [UIColor clearColor];
        
        UILabel *contentLable = [[UILabel alloc]initWithFrame:whiteView.frame];
        contentLable.backgroundColor = UIColorFromRGB(0xf6f6f6);
        contentLable.textColor = UIColorFromRGB(0x848484);
        contentLable.textAlignment = NSTextAlignmentCenter;
        contentLable.font = [UIFont systemFontOfSize:13];
        contentLable.text = @"正在加载数据。。。";
        [whiteView addSubview:contentLable];
        
    }
    
    return whiteView;
    
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (dataArray == nil) {
        return 1;
    }
    else
    {
        return dataArray.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataArray == nil) {
        return 0;
    }
    else
    {
        return 1;
    }
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (dataArray == nil) {
        return 100;
    }
    else
    {
        return 10;
    }
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (dataArray == nil) {
        return [self creatWhiteView];
    }
    else
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
        view.backgroundColor = [UIColor clearColor];
        
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @" cellIdentifier ";
    
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.8 alpha:1.0];
    
    cell.textLabel.text = contentStr;
    
    
    return cell;
}


@end
