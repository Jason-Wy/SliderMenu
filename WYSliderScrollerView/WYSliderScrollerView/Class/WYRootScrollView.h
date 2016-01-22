//
//  WYRootScrollView.h
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WYTopScrollView.h"

@protocol WYRootScrollViewDelegate <NSObject>

- (void)loadDataPageWithRow:(NSInteger )row;

@end

@interface WYRootScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *viewArray;
    
    CGFloat userContentOffsetX;
    BOOL isLeftScroll;
}

@property (nonatomic ,retain) id <WYRootScrollViewDelegate> delegateRoot;
@property (nonatomic, retain) NSArray *viewArray;

//+ (WYRootScrollView *)shareInstance;

/**
 *  加载页面，屏蔽首次加载数据
 */
- (void)initWithViews;
/**
 *  加载主要内容
 */
- (void)loadData;


@end
