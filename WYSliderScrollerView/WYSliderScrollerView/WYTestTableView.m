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


- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger )viewId
{
    
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, viewHeight-44)];
        bgView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:bgView];
        
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 300+viewId;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [bgView addSubview:tableView];
        contentStr = @"0000000000000000000000000000";
    }
    return self;
    
}

- (void)loadRefreshData:(NSArray *)data
{
    NSLog(@"data  %@",data);
    contentStr = data[0];
    [tableView reloadData];
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
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
    cell.backgroundColor = [UIColor greenColor];
    
    cell.textLabel.text = contentStr;
    
    
    return cell;
}


@end
