//
//  WYRootScrollView.m
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WYRootScrollView.h"

#import "Macros.h"

#define TableStartTag 600;
#define POSITIONID (int)(scrollView.contentOffset.x/320)

@implementation WYRootScrollView
{
    NSInteger currentPage;
}

@synthesize viewArray;

//+ (WYRootScrollView *)shareInstance {
//    static WYRootScrollView *_instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance=[[self alloc] initWithFrame:CGRectMake(0, 44+viewOriginY, WIDTH, viewHeight-44)];
//    });
//    return _instance;
//}

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 44+viewOriginY, WIDTH, viewHeight-44);
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        userContentOffsetX = 0;
        currentPage = 0;
        
        
        if ([self respondsToSelector:@selector(adjustTopViewPageWithNotification:)]) {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustTopViewPageWithNotification:) name:NOTIFICATIONPOSTTOROOTVIEW object:nil];
        }
        
    }
    return self;
}

- (void)initWithViews
{
    int tagId = 0;
    for (UIView *view in viewArray) {
        view.tag = tagId + TableStartTag;
        tagId += 1;
        [self addSubview:view];
    }
    self.contentSize = CGSizeMake(320*[viewArray count], viewHeight-44);
    //FIXME:这里是第一次加载页面时需要调用的加载首页数据
//    [self loadData];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    userContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (userContentOffsetX < scrollView.contentOffset.x) {
        isLeftScroll = YES;
    }
    else {
        isLeftScroll = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == currentPage*320) {
        return;
    }else
    {
        currentPage = scrollView.contentOffset.x/320;
    }
    //调整顶部滑条按钮状态
    [self adjustTopScrollViewButton:scrollView];
    
    //根据scrollView的位置来判断是哪个table
    
    
    [self loadData];
}



- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == currentPage*320) {
        return;
    }else
    {
        currentPage = scrollView.contentOffset.x/320;
    }
    //根据scrollView的位置来判断是哪个table
    
    [self loadData];
}

-(void)loadData
{
    CGFloat pagewidth = self.frame.size.width;
    int page = floor((self.contentOffset.x - pagewidth/viewArray.count)/pagewidth)+1;
    page += TableStartTag;
    //当前加载数据的view
    [self.delegateRoot loadDataPageWithRow:page];
    
}

//滚动后修改顶部滚动条
- (void)adjustTopScrollViewButton:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATIONPOSTTOTOPVIEW object:nil userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",POSITIONID] forKey:@"positionid"]];
}

- (void)adjustTopViewPageWithNotification:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSInteger page = [[dict objectForKey:@"buttonid"] integerValue];
    
    
    self.contentOffset = CGPointMake(page*320, 0);
    [self loadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTIFICATIONPOSTTOROOTVIEW object:nil];
}


@end
