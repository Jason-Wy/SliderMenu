//
//  ViewController.m
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "Macros.h"

#import "WYTestTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *topShadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 5)];
    [topShadowImageView setImage:[UIImage imageNamed:@"top_background_shadow.png"]];
    [self.view addSubview:topShadowImageView];
    
    WYTopScrollView *topScrollView = [WYTopScrollView shareInstance];
    WYRootScrollView *rootScrollView = [WYRootScrollView shareInstance];
    
    topScrollView.nameArray = @[@"网易新闻", @"新浪微博新闻", @"搜狐", @"头条新闻", @"本地动态", @"精美图片集"];
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [topScrollView.nameArray count]; i++) {
        
        WYTestTableView *tableView = [[WYTestTableView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, viewHeight-44) withTag:300];
        
        [mutableArray addObject:tableView];
    }
    
    rootScrollView.viewArray = [NSArray arrayWithArray:mutableArray];
    rootScrollView.delegateRoot = self;
    
    [self.view addSubview:topScrollView];
    [self.view addSubview:rootScrollView];
    
    [topScrollView initWithNameButtons];
    [rootScrollView initWithViews];
}

- (void)loadDataPageWithRow:(NSInteger)row
{
    WYTestTableView *tableView = [self.view  viewWithTag:row+300];
    
    [tableView loadRefreshData:@[[NSString stringWithFormat:@"%ld",(long)row*11111111111111111],@"111",@"111"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
