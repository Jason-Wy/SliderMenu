//
//  WYTestTableView.h
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYTestTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *contentTableView;
    
    NSArray *dataArray;
    
    UIView *whiteView;
    NSString *contentStr;
}

//创建方法
- (instancetype)initWithFrame:(CGRect)frame;
//需实现的刷新数据方法
- (void)loadRefreshData:(NSArray *)data;

@end
